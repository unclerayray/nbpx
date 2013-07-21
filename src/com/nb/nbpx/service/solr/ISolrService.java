/**
 * @author Roger
 */
package com.nb.nbpx.service.solr;

import java.io.IOException;
import java.util.List;

import com.nb.nbpx.service.IBaseService;

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
}
