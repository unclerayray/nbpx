/**
 * @author Roger
 */
package com.nb.nbpx.service.solr;

import com.nb.nbpx.service.IBaseService;

/**
 * 用于SOLR导入索引
 * @author Roger
 * @date 2013-6-15
 */
public interface IDataImportService {
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
}
