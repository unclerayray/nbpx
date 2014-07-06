package com.nb.nbpx.server.wenda;

import java.util.Date;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.nb.nbpx.common.ResponseStatus;
import com.nb.nbpx.pojo.wenda.Answer;
import com.nb.nbpx.server.BaseAction;
import com.nb.nbpx.service.keyword.IKeywordService;
import com.nb.nbpx.service.solr.ISolrQuestionService;
import com.nb.nbpx.service.subject.ISubjectService;
import com.nb.nbpx.service.wenda.IAnswerService;
import com.nb.nbpx.service.wenda.IQuestionService;
import com.nb.nbpx.utils.JsonUtil;

@Component("QuestionAction")
@Scope("prototype")
public class QuestionAction extends BaseAction{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public IQuestionService qestionService;
	public IAnswerService answerService;
	public IKeywordService keywordService;
	public ISubjectService subjectService;
	private ISolrQuestionService solrQuestionService;
	
	public Integer id;
	public String myAnswer;


	public String viewQuestion(){
		String json = "";
		try {
			json = qestionService.viewQuestion(id);
		} catch (Exception e) {
			this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
					ResponseStatus.FAIL,
					"无此问题" + e.getMessage()));
			return "failure";
		}
		this.inputStream = castToInputStream(json);
		return SUCCESS;
	}
	
	public String viewAnswers(){
		String json = "";
		try {
			json = answerService.queryAnswers(id);
		} catch (Exception e) {
			this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
					ResponseStatus.FAIL,
					"无此问题" + e.getMessage()));
			return "failure";
		}
		this.inputStream = castToInputStream(json);
		return SUCCESS;
	}
	

	
	public String answerIt(){
		try {
			Answer answer = new Answer();
			answer.setAnswerdDate(new Date());
			answer.setAnsweredBy(getClientSessionUserName());
			answer.setIsBest(false);
			answer.setContent(myAnswer);
			answer.setQuestionId(id);
			answerService.saveAnswer(answer);
		} catch (Exception e) {
			this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
					ResponseStatus.FAIL,
					"回复失败!" + e.getMessage()));
			return "failure";
		}
		this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
				ResponseStatus.FAIL,
				"回答成功！"));
		return SUCCESS;
	}


	public IQuestionService getQestionService() {
		return qestionService;
	}

	@Resource
	public void setQestionService(IQuestionService qestionService) {
		this.qestionService = qestionService;
	}

	public IAnswerService getAnswerService() {
		return answerService;
	}

	@Resource
	public void setAnswerService(IAnswerService answerService) {
		this.answerService = answerService;
	}

	public IKeywordService getKeywordService() {
		return keywordService;
	}

	@Resource
	public void setKeywordService(IKeywordService keywordService) {
		this.keywordService = keywordService;
	}

	public ISubjectService getSubjectService() {
		return subjectService;
	}

	@Resource
	public void setSubjectService(ISubjectService subjectService) {
		this.subjectService = subjectService;
	}

	public ISolrQuestionService getSolrQuestionService() {
		return solrQuestionService;
	}

	@Resource
	public void setSolrQuestionService(ISolrQuestionService solrQuestionService) {
		this.solrQuestionService = solrQuestionService;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}
	

	public String getMyAnswer() {
		return myAnswer;
	}

	public void setMyAnswer(String myAnswer) {
		this.myAnswer = myAnswer;
	}
}
