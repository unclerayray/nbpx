package com.nb.nbpx.service.solr;


public interface IBaseSolrService {
	public void audit(Integer id,Boolean state) throws Exception;
	
	public String setItsServerURL()  throws Exception;
}
