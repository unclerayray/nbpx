package com.nb.nbpx.service.solr.impl;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.StringReader;
import java.text.SimpleDateFormat;
import java.util.List;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.apache.lucene.analysis.charfilter.HTMLStripCharFilter;
import org.apache.solr.client.solrj.SolrServer;
import org.apache.solr.client.solrj.SolrServerException;
import org.apache.solr.client.solrj.impl.HttpSolrServer;
import org.apache.solr.common.SolrInputDocument;

import com.nb.nbpx.pojo.course.CourseInfo;
import com.nb.nbpx.pojo.user.TeacherInfo;
import com.nb.nbpx.service.solr.ISolrTeacherService;
import com.nb.nbpx.utils.SolrUtil;

public class SolrTeacherServiceImpl implements ISolrTeacherService {
    public static Logger logger = LogManager.getLogger(SolrTeacherServiceImpl.class);
	@Override
	public void addTeacher2Solr(TeacherInfo teacher) {
		String serverURL;
		try {
			serverURL = SolrUtil.getTeacherServerUrl();
			SolrServer solrServer = new HttpSolrServer(serverURL);
			SolrInputDocument sid = new SolrInputDocument();
			sid.addField("teacherId", teacher.getTeacherId());
			sid.addField("realName", teacher.getRealName());
			sid.addField("expertIn", teacher.getExpertIn());
			sid.addField("majorCatgory", teacher.getMajorCatgory());
			String introduction = teacher.getIntroduction();
			introduction = stripHTMLX(introduction);
			sid.addField("content", introduction);
			sid.addField("introduction", introduction);
			solrServer.add(sid);
            solrServer.commit();
            logger.debug("已成功为插入的讲师创建索引");
		} catch (IOException e) {
			logger.error("未能取得讲师的SolrServer URL。"+e.getMessage());;
			e.printStackTrace();
		} catch (SolrServerException e) {
			logger.error("commit未成功。"+e.getMessage());;
			e.printStackTrace();
		}
	}

	@Override
	public void removeTeacherInfoFromSolr(Integer teacherId)
			throws SolrServerException, IOException {
		// TODO Auto-generated method stub

	}

	/**
	 * 清除课程内容中的HTML标签，并存入SOLR中
	 * @param value
	 * @return
	 */
	private String stripHTMLX(String value) { 
        StringBuilder out = new StringBuilder(); 
        StringReader strReader = new StringReader(value); 
        try { 
            HTMLStripCharFilter html = new HTMLStripCharFilter(new BufferedReader(strReader)); 
            char[] cbuf = new char[1024 * 10]; 
            while (true) { 
                int count = html.read(cbuf); 
                if (count == -1) 
                    break; // end of stream mark is -1 
                if (count > 0) 
                    out.append(cbuf, 0, count); 
            } 
            html.close(); 
        } catch (IOException e) { 
            e.printStackTrace(); 
            return null; 
            //  "Failed stripping HTML for column: " + column, e); 
        } finally{
        	strReader.close();
        }
        return out.toString(); 
    } 
}
