/**
 * @author Roger
 */
package com.nb.nbpx.server.course;

import javax.annotation.Resource;

import org.apache.solr.client.solrj.SolrServerException;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.nb.nbpx.common.ResponseStatus;
import com.nb.nbpx.server.BaseAction;
import com.nb.nbpx.service.solr.ISolrService;
import com.nb.nbpx.utils.JsonUtil;

/**
 * @author Roger
 * @date 2013-6-18
 */
@Component("CourseAction")
@Scope("prototype")
public class CourseAction extends BaseAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private ISolrService dataImportor;
	
	public String fullImport(){
		try {
			dataImportor.fullImport();
		}catch(SolrServerException ce){
			ce.printStackTrace();
			this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
					ResponseStatus.FAIL, ResponseStatus.IMPORT_FAILED+"Solr服务器连接失败！请检查服务器！"));
			return "failure";
		}catch (Exception e) {
			e.printStackTrace();
			this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
					ResponseStatus.FAIL, ResponseStatus.IMPORT_FAILED+e.getMessage()));
			return "failure";
		}
		this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
				ResponseStatus.SUCCESS, ResponseStatus.IMPORT_SUCCESS));
		return SUCCESS;
	}

	/**
	 * @param dataImportor the dataImportor to set
	 */
	@Resource
	public void setDataImportor(ISolrService dataImportor) {
		this.dataImportor = dataImportor;
	}

	/**
	 * @return the dataImportor
	 */
	public ISolrService getDataImportor() {
		return dataImportor;
	}
}
