package com.nb.nbpx.server.wenda;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.nb.nbpx.common.ResponseStatus;
import com.nb.nbpx.pojo.wenda.Answer;
import com.nb.nbpx.pojo.wenda.Question;
import com.nb.nbpx.server.BaseAction;
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
	public IQuestionService qestionService;
	public IAnswerService answerService;

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
		if(questionId!=null){
			json = qestionService.queryQuestions(answerId, getStartPosi(), sort, order, questionId);
		}else{
			json = qestionService.queryQuestions(rows,
					getStartPosi(), sort, order, closed);
		}
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
			qestionService.saveQuestion(question);
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
}
