package com.nb.nbpx.service.solr;

import java.io.IOException;
import java.util.List;

import org.apache.solr.client.solrj.SolrServerException;

import com.nb.nbpx.pojo.keyword.Keyword;
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
	/**
	 * 查找相关的机构，用于提示与小模块
	 * @param q 拼音，人名或者关键词
	 * @param start
	 * @param rows
	 * @return
	 * @throws SolrServerException
	 * @throws IOException
	 * @throws NbpxException
	 */
	public List<Keyword> queryTipOrg(String q, Integer start, Integer rows) throws SolrServerException, IOException, NbpxException ;
}
