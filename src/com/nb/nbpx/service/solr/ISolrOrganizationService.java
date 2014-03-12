package com.nb.nbpx.service.solr;

import java.io.IOException;
import java.util.List;

import org.apache.solr.client.solrj.SolrServerException;

import com.nb.nbpx.pojo.user.OrgInfo;
import com.nb.nbpx.service.IBaseService;
import com.nb.nbpx.utils.NbpxException;

/**
 * 机构连接SORL索引的service
 * @author Roger
 * @date 2014年3月10日
 */
public interface ISolrOrganizationService  extends IBaseService {
	public void addOrganization2Solr(OrgInfo orgInfo);
	public void addOrganizations2Solr(List<OrgInfo> orgInfoList);
	public String queryRelatedOrganization(String q, Integer start, Integer rows) throws SolrServerException, IOException, NbpxException;

}
