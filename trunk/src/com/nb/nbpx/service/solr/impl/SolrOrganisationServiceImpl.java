package com.nb.nbpx.service.solr.impl;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.apache.solr.client.solrj.SolrQuery;
import org.apache.solr.client.solrj.SolrServer;
import org.apache.solr.client.solrj.SolrServerException;
import org.apache.solr.client.solrj.impl.HttpSolrServer;
import org.apache.solr.client.solrj.response.QueryResponse;
import org.apache.solr.common.SolrDocument;
import org.apache.solr.common.SolrDocumentList;
import org.apache.solr.common.SolrInputDocument;
import org.apache.solr.common.params.ModifiableSolrParams;
import org.springframework.stereotype.Component;

import com.nb.nbpx.common.ResponseStatus;
import com.nb.nbpx.pojo.keyword.Keyword;
import com.nb.nbpx.pojo.user.OrgInfo;
import com.nb.nbpx.service.impl.BaseServiceImpl;
import com.nb.nbpx.service.solr.ISolrOrganisationService;
import com.nb.nbpx.utils.JsonUtil;
import com.nb.nbpx.utils.NbpxException;
import com.nb.nbpx.utils.SolrUtil;

@Component("SolrOrganisation")
public class SolrOrganisationServiceImpl extends BaseServiceImpl implements
		ISolrOrganisationService {

    public static Logger logger = LogManager.getLogger(SolrOrganisationServiceImpl.class);
	@Override
	public void addOrganisation2Solr(OrgInfo orgInfo) {
		String serverURL;
		try {
			serverURL = SolrUtil.getOraganisationServerUrl();
			SolrServer solrServer = new HttpSolrServer(serverURL);
			SolrInputDocument sid = new SolrInputDocument();
			sid.addField("orgId", orgInfo.getOrgId());
			sid.addField("orgName", orgInfo.getOrgName());
			sid.addField("introduction", orgInfo.getIntroduction());
			solrServer.add(sid);
            solrServer.commit();
            logger.debug("已成功为插入的提问创建索引");
		} catch (IOException e) {
			logger.error("未能取得提问的SolrServer URL。"+e.getMessage());;
			e.printStackTrace();
		} catch (SolrServerException e) {
			logger.error("commit为成功。"+e.getMessage());;
			e.printStackTrace();
		}		
	}

	@Override
	public void addOrganisations2Solr(List<OrgInfo> orgInfoList) {
	}

	@Override
	public String queryRelatedOrganisation(String q, Integer start, Integer rows)
			throws SolrServerException, IOException, NbpxException {
		if(q==null){
			throw new NbpxException("查询关键词不能为空。");
		}
		String json = "";
		String serverURL = SolrUtil.getOraganisationServerUrl();
		SolrServer solrServer = new HttpSolrServer(serverURL);
		q = SolrUtil.escapeQueryChars(q);
		ModifiableSolrParams params = new ModifiableSolrParams();
		SolrQuery query = new SolrQuery();
		q = SolrUtil.escapeQueryChars(q);
		//TODO keyword key title->> something else
		q = "orgName:"+q;
		params.set("q", q);
		if(start!=null){
			params.set("start", start);
		}
		if(rows!=null){
			params.set("rows", rows);
		}
		query.set("qt", "select");
		query.add(params);
		QueryResponse response = solrServer.query(query);
		int numFound = (int) response.getResults().getNumFound();
		int count = response.getResults().size();
		SolrDocumentList list = response.getResults();
		List<OrgInfo> resultList = new ArrayList<OrgInfo>();
		for (int i = 0; i < count; i++) {
			SolrDocument sd = list.get(i);
			Object orgIdobj = sd.getFieldValue("orgId");
			Object orgNameobj = sd.getFieldValue("orgName");
			Object introobj = sd.getFieldValue("introduction");
			if(orgNameobj==null){
				continue;
			}
			OrgInfo orgInfo = new OrgInfo();
			orgInfo.setOrgId((Integer) orgIdobj);
			orgInfo.setOrgName(orgNameobj.toString());
			orgInfo.setIntroduction(introobj.toString());
			resultList.add(orgInfo);
		}
		/**
		 * 以下为去重的代码
		 */
		HashSet hs = new HashSet();
		hs.addAll(resultList);
		resultList.clear();
		resultList.addAll(hs);
		json = JsonUtil.formatToJsonWithTimeStamp(numFound,
				ResponseStatus.SUCCESS, "", list);
		return json;
	}

	@Override
	public void removeOrganisationFromSolr(Integer orgId)
			throws SolrServerException, IOException {
		String serverURL = SolrUtil.getOraganisationServerUrl();
		SolrServer solrServer = new HttpSolrServer(serverURL);
		solrServer.deleteById(orgId+"");
		solrServer.commit();		
	}

}
