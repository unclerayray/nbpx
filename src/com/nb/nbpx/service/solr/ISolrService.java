/**
 * @author Roger
 */
package com.nb.nbpx.service.solr;

import java.io.IOException;
import java.util.List;

import org.apache.solr.client.solrj.SolrServerException;

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
	
	/**
	 * 通过变量全文查找，用于显示列表。高亮显示
	 * @param q 查找参数
	 * @return
	 */
	public String fullTextQueryForHl(String q, Integer start, Integer rows) throws SolrServerException, IOException;
}
