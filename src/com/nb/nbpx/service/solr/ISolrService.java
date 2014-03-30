/**
 * @author Roger
 */
package com.nb.nbpx.service.solr;

import java.io.IOException;
import java.util.List;

import org.apache.solr.client.solrj.SolrServerException;

import com.nb.nbpx.pojo.course.CourseSearchResult;
import com.nb.nbpx.service.IBaseService;
import com.nb.nbpx.utils.NbpxException;

/**
 * 用于SOLR导入索引
 * @author Roger
 * @date 2013-6-15
 */
public interface ISolrService extends IBaseService{
	/**
	 * 全量导入
	 * @throws Exception
	 */
	public void fullImport() throws Exception;
	/**
	 * 增量导入
	 * @throws Exception
	 */
	public void deltaImport() throws Exception;
	
	/**
	 * 切分text
	 * @param text
	 */
	public String cutText(String text) throws IOException;
	
	/**
	 * 【公开课】通过变量全文查找，用于显示列表。高亮显示,返回json字符串
	 * @param q 查找参数
	 * @return
	 */
	public String fullTextQueryForHl(String q, Integer start, Integer rows) throws SolrServerException, IOException;
	
	
	/**
	 * @param q
	 * @param start
	 * @param rows
	 * @return
	 * @throws SolrServerException
	 * @throws IOException
	 */
	public String queryKeywordsByKeyword(String q, Integer start, Integer rows) throws SolrServerException, IOException, NbpxException;
	/**
	 * 【公开课】通过变量全文查找，用于显示列表。高亮显示，返回一个List
	 * @param q 查找参数
	 * @return
	 */
	public List<CourseSearchResult> fullTextQueryForHlReturnList(String q, Integer start, Integer rows) throws SolrServerException, IOException;
	
	
	/**
	 * 【内训课】通过变量全文查找，用于显示列表。高亮显示,返回json字符串
	 * @param q 查找参数
	 * @return
	 */
	public String fullTextQueryForHlInnerCourse(String q, Integer start, Integer rows) throws SolrServerException, IOException;
	
	/**
	 * 【内训课】通过变量全文查找，用于显示列表。高亮显示，返回一个List
	 * @param q 查找参数
	 * @return
	 */
	public List<CourseSearchResult> fullTextQueryForHlReturnInnerCourseList(String q, Integer start, Integer rows) throws SolrServerException, IOException;
	
	/**
	 * 【公开课】通过变量全文查找，用于显示列表。高亮显示,返回json字符串
	 * @param subject
	 * @param start
	 * @param rows
	 * @return
	 * @throws SolrServerException
	 * @throws IOException
	 * @throws NbpxException
	 */
	public String queryCoursesBySubject(String subject, Integer start, Integer rows) throws SolrServerException, IOException, NbpxException;
	
	/**
	 * 【内训课】通过变量全文查找，用于显示列表。高亮显示,返回json字符串
	 * @param subject
	 * @param start
	 * @param rows
	 * @return
	 * @throws SolrServerException
	 * @throws IOException
	 * @throws NbpxException
	 */
	public String queryInnerCoursesBySubject(String subject, Integer start, Integer rows) throws SolrServerException, IOException, NbpxException;
	

	/**
	 * 【公开课】通过变量全文查找，用于显示列表。高亮显示,返回List<CourseSearchResult>
	 * @param subject
	 * @param start
	 * @param rows
	 * @return
	 * @throws SolrServerException
	 * @throws IOException
	 * @throws NbpxException
	 */
	public List<CourseSearchResult> queryCourseListBySubject(String subject, Integer start, Integer rows) throws SolrServerException, IOException, NbpxException;
	
	/**
	 * 【内训课】通过变量全文查找，用于显示列表。高亮显示,返回List<CourseSearchResult>
	 * @param subject
	 * @param start
	 * @param rows
	 * @return
	 * @throws SolrServerException
	 * @throws IOException
	 * @throws NbpxException
	 */
	public List<CourseSearchResult> queryInnerCourseListBySubject(String subject, Integer start, Integer rows) throws SolrServerException, IOException, NbpxException;
}
