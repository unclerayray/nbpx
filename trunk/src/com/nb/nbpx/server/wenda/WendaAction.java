package com.nb.nbpx.server.wenda;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.nb.nbpx.common.ResponseStatus;
import com.nb.nbpx.pojo.keyword.Keyword;
import com.nb.nbpx.pojo.subject.Subject;
import com.nb.nbpx.pojo.wenda.Answer;
import com.nb.nbpx.pojo.wenda.Question;
import com.nb.nbpx.pojo.wenda.QuestionKeyword;
import com.nb.nbpx.pojo.wenda.QuestionSubject;
import com.nb.nbpx.server.BaseAction;
import com.nb.nbpx.service.keyword.IKeywordService;
import com.nb.nbpx.service.solr.ISolrQuestionService;
import com.nb.nbpx.service.subject.ISubjectService;
import com.nb.nbpx.service.wenda.IAnswerService;
import com.nb.nbpx.service.wenda.IQuestionService;
import com.nb.nbpx.utils.JsonUtil;
@Component("WendaAction")
@Scope("prototype")
public class WendaAction  extends BaseAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public Boolean closed;
	public Question question;
	public Answer answer;
	public Integer answerId;
	public Integer questionId;
	public String category;
	public String title;
	public String askedBy;
	public String content;
	public String questionSubjects;
	public String questionKeywords;
	public IQuestionService qestionService;
	public IAnswerService answerService;
	public IKeywordService keywordService;
	public ISubjectService subjectService;
	private ISolrQuestionService solrQuestionService;

	public String queryAnswers(){
		String json = answerService.queryAnswers(questionId);
		this.inputStream = castToInputStream(json);
		return SUCCESS;
	}
	
	public String saveAnswer() {
		try {
			answerService.saveAnswer(answer);
		} catch (Exception e) {
			e.printStackTrace();
			this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
					ResponseStatus.FAIL,
					ResponseStatus.SAVE_FAILED + e.getMessage()));
			return "failure";
		}
		this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
				ResponseStatus.SUCCESS, ResponseStatus.SAVE_SUCCESS));
		return SUCCESS;
	}
	
	public String deleteAnswer() {
		answerService.deleteAnswer(answer);
		this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
				ResponseStatus.SUCCESS, ResponseStatus.DELETE_SUCCESS));
		return SUCCESS;
	}
	
	
	public String queryQuestions(){
		String json = "";
		json = qestionService.queryQuestions(answerId, getStartPosi(), sort, order, closed, title, askedBy);
		this.inputStream = castToInputStream(json);
		return SUCCESS;
	}
	
	public String setBestAnswer(){
		try {
			answerService.setBestAnswer(answerId, questionId);
		} catch (Exception e) {
			e.printStackTrace();
			this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
					ResponseStatus.FAIL,
					"设置最佳答案失败" + e.getMessage()));
			return "failure";
		}
		this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
				ResponseStatus.SUCCESS, "设置最佳答案成功"));
		return SUCCESS;
	}
	
	public String saveQuestion() {
		try {
			if(askedBy==null||askedBy.equals("")){
				askedBy = getClientSessionUserName();
			}
			question = new Question(questionId,title,content,false,new Date(),askedBy,category);
			String regEx1 = "[\\pP‘’“”_]";
			if (questionKeywords != null) {
				questionKeywords = questionKeywords.replace(" ", "");
				questionKeywords = questionKeywords.replaceAll(regEx1, ",");
			}
			List<Keyword> keys = keywordService.saveKeywords(question.getCategory(), questionKeywords);
			if (questionSubjects != null) {
				questionSubjects = questionSubjects.replace(" ", "");
				questionSubjects = questionSubjects.replaceAll(regEx1, ",");
			}
			List<Subject> subs = subjectService.saveSubjects(question.getCategory(), questionSubjects);
			question = saveKeywords2Question(question,keys);
			question = saveSubjects2Question(question,subs);
			qestionService.saveQuestion(question);
			solrQuestionService.addQuestion2Solr(question);
		} catch (Exception e) {
			e.printStackTrace();
			this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
					ResponseStatus.FAIL,
					ResponseStatus.SAVE_FAILED + e.getMessage()));
			return "failure";
		}
		this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
				ResponseStatus.SUCCESS, ResponseStatus.SAVE_SUCCESS));
		return SUCCESS;
	}
	
	public String deleteQuestion() {
		qestionService.deleteQuestion(question);
		this.inputStream = castToInputStream(JsonUtil.formatToOpResJson(
				ResponseStatus.SUCCESS, ResponseStatus.DELETE_SUCCESS));
		return SUCCESS;
	}
	

	private Question saveKeywords2Question(Question question,List<Keyword> keys){
		for(Keyword key:keys){
			QuestionKeyword dk = new QuestionKeyword();
			dk.setQuestion(question);
			dk.setKeyword(key.getKeyword());
			dk.setKeywordId(key.getKeyId());
			question.getQuestionKeywords().add(dk);
		}
		return question;
	}
	
	private Question saveSubjects2Question(Question question,List<Subject> subs){
		for(Subject sub:subs){
			QuestionSubject ds = new QuestionSubject();
			ds.setSubject(sub.getSubject());
			ds.setQuestion(question);
			ds.setSubjectId(sub.getSubjectId());
			question.getQuestionSubjects().add(ds);
		}
		return question;
	}

	public Boolean getClosed() {
		return closed;
	}

	public void setClosed(Boolean closed) {
		this.closed = closed;
	}

	public IQuestionService getQestionService() {
		return qestionService;
	}

	@Resource
	public void setQestionService(IQuestionService qestionService) {
		this.qestionService = qestionService;
	}

	public Question getQuestion() {
		return question;
	}

	public void setQuestion(Question question) {
		this.question = question;
	}

	public Answer getAnswer() {
		return answer;
	}

	public void setAnswer(Answer answer) {
		this.answer = answer;
	}

	public Integer getAnswerId() {
		return answerId;
	}

	public void setAnswerId(Integer answerId) {
		this.answerId = answerId;
	}

	public Integer getQuestionId() {
		return questionId;
	}

	public void setQuestionId(Integer questionId) {
		this.questionId = questionId;
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

	public String getQuestionSubjects() {
		return questionSubjects;
	}

	public void setQuestionSubjects(String questionSubjects) {
		this.questionSubjects = questionSubjects;
	}

	public String getQuestionKeywords() {
		return questionKeywords;
	}

	public void setQuestionKeywords(String questionKeywords) {
		this.questionKeywords = questionKeywords;
	}
}
