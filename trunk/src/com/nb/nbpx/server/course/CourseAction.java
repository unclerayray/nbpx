/**
 * @author Roger
 */
package com.nb.nbpx.server.course;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.nb.nbpx.common.ResponseStatus;
import com.nb.nbpx.server.BaseAction;
import com.nb.nbpx.service.solr.IDataImportService;
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
	private IDataImportService dataImportor;
	
	public String fullImport(){
		try {
			dataImportor.fullImport();
		} catch (Exception e) {
			e.printStackTrace();
			this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
					ResponseStatus.FAIL, ResponseStatus.IMPORT_SUCCESS+e.getMessage()));
			return "failure";
		}
		this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
				ResponseStatus.SUCCESS, ResponseStatus.IMPORT_FAILED));
		return SUCCESS;
	}

	/**
	 * @param dataImportor the dataImportor to set
	 */
	@Resource
	public void setDataImportor(IDataImportService dataImportor) {
		this.dataImportor = dataImportor;
	}

	/**
	 * @return the dataImportor
	 */
	public IDataImportService getDataImportor() {
		return dataImportor;
	}
}
