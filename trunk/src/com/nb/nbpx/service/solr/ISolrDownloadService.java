package com.nb.nbpx.service.solr;

import java.io.IOException;

import org.apache.solr.client.solrj.SolrServerException;

import com.nb.nbpx.pojo.zixun.Download;
import com.nb.nbpx.service.IBaseService;
import com.nb.nbpx.utils.NbpxException;

/**
 * @author Roger
 * @date 2014年3月30日
 */
public interface ISolrDownloadService extends IBaseService {
	public void addDownload2Solr(Download download);
	public String queryRelatedDownloads(String q, Integer start, Integer rows) throws SolrServerException, IOException, NbpxException;
	public String queryDownloadsBySubject(String subject, Integer start, Integer rows) throws SolrServerException, IOException, NbpxException;
	public void removeDownloadFromSolr(Integer downloadId) throws SolrServerException, IOException;
}
