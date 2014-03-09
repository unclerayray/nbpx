package com.nb.nbpx.service.solr;

import java.io.IOException;
import java.util.List;

import org.apache.solr.client.solrj.SolrServerException;

import com.nb.nbpx.pojo.wenda.Question;
import com.nb.nbpx.service.IBaseService;
import com.nb.nbpx.utils.NbpxException;

/**
 * 问答连接SORL索引的service
 * @author Roger
 * @date 2014年3月9日
 */
public interface ISolrQuestionService  extends IBaseService {
	public void addQuestion2Solr(Question question);
	public void addQuestions2Solr(List<Question> questionList);
	public String queryRelatedQuestion(String q, Integer start, Integer rows) throws SolrServerException, IOException, NbpxException;
}
