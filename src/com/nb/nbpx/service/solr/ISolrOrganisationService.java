package com.nb.nbpx.service.solr;

import java.io.IOException;
import java.util.List;

import org.apache.solr.client.solrj.SolrServerException;

import com.nb.nbpx.pojo.user.OrgInfo;
import com.nb.nbpx.utils.NbpxException;

/**
 * 机构连接SORL索引的service
 * @author Roger
 * @date 2014年3月10日
 */
public interface ISolrOrganisationService  extends IBaseSolrService {
	public void addOrganisation2Solr(OrgInfo orgInfo);
	public void addOrganisations2Solr(List<OrgInfo> orgInfoList);
	public String queryRelatedOrganisation(String q, Integer start, Integer rows) throws SolrServerException, IOException, NbpxException;
	public void removeOrganisationFromSolr(Integer orgId) throws SolrServerException, IOException;

}
