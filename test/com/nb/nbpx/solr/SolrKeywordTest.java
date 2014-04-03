package com.nb.nbpx.solr;

import java.io.IOException;
import java.util.logging.Logger;

import javax.annotation.Resource;

import org.apache.solr.client.solrj.SolrServerException;
import org.junit.Test;

import com.nb.nbpx.BaseServiceTest;
import com.nb.nbpx.service.solr.ISolrKeywordService;
import com.nb.nbpx.utils.NbpxException;

public class SolrKeywordTest extends BaseServiceTest{
	private static final Logger log = Logger.getLogger(SolrKeywordTest.class
			.getName());
	@Resource
	public ISolrKeywordService solrKeywordService;
	@Test
	public void testQueryRelatedKeywords() {
		try {
			String keywords = solrKeywordService.queryRelatedKeywords("xl", 0, 10);
			log.info("---------keywords:"+keywords);
		} catch (SolrServerException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (NbpxException e) {
			e.printStackTrace();
		}
		
	}

}
