/**
 * @author Roger
 */
package com.nb.nbpx.service.solr.impl;

import org.apache.solr.client.solrj.SolrServer;
import org.apache.solr.client.solrj.impl.HttpSolrServer;
import org.apache.solr.client.solrj.response.QueryResponse;
import org.apache.solr.common.params.ModifiableSolrParams;
import org.springframework.stereotype.Component;

import com.nb.nbpx.service.impl.BaseServiceImpl;
import com.nb.nbpx.service.solr.ISolrService;
import com.nb.nbpx.utils.NbpxException;

/**
 * @author Roger
 * @date 2013-6-15
 */
@Component("SolrService")
public class SolrServiceImpl extends BaseServiceImpl implements ISolrService {

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.nb.nbpx.service.solr.IDataImportService#fullImport()
	 */
	@Override
	public void fullImport() throws Exception {
		SolrServer solrServer = new HttpSolrServer("http://localhost:8080/solr");
		ModifiableSolrParams params = new ModifiableSolrParams();
		params.set("qt", "/dataimport");
		params.set("command", "full-import");
		params.set("commit", true);
		params.set("command", "full-import");
		params.set("clean", true);
		solrServer.ping();
		QueryResponse response = solrServer.query(params);
		if (response.getStatus() == 0) {
			System.out.println("------------------全量导入成功！");
		} else {
			throw new NbpxException("全量导入失败！");
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.nb.nbpx.service.solr.IDataImportService#deltaImport()
	 */
	@Override
	public void deltaImport() throws Exception {
		// TODO Auto-generated method stub

	}

}
