package com.nb.nbpx.service.wenda.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.nb.nbpx.common.ResponseStatus;
import com.nb.nbpx.dao.wenda.IQuestionDao;
import com.nb.nbpx.pojo.wenda.Question;
import com.nb.nbpx.service.impl.BaseServiceImpl;
import com.nb.nbpx.service.wenda.IQuestionService;
import com.nb.nbpx.utils.JsonUtil;
import com.nb.nbpx.utils.daotool.Equality;

/**
 * @author Roger
 * @date 2013年11月17日
 */
@Component("QuestionService")
public class QuestionServiceImpl extends BaseServiceImpl implements IQuestionService{

	public IQuestionDao questionDao;
	
	public IQuestionDao getQuestionDao() {
		return questionDao;
	}

	@Resource
	public void setQuestionDao(IQuestionDao questionDao) {
		this.questionDao = questionDao;
	}

	@Override
	public String queryQuestions(Integer rows, Integer start, String sort,
			String order, Boolean closed, String title, String askedBy) {
		String json = "";
		Map<String, Object> propsMap = this.createPropMap(new Equality(
				"isClosed", closed),new Equality(
						"askedBy", askedBy));
		Map<String, Object> likeMap = new HashMap<String, Object>();
		if(title != null && !"".equals(title)){
			likeMap.put("title", title);
		}
		List<Question>  list = questionDao.queryQuestions(rows, start, sort, order, closed, title, askedBy);
		if (list.isEmpty()) {
			json = JsonUtil.formatToJsonWithTimeStamp(0,
					ResponseStatus.SUCCESS, "", list);
		} else {
			int count = questionDao.queryLikeTotalCount(Question.class, propsMap, likeMap).intValue();
			json = JsonUtil.formatToJsonWithTimeStamp(count,
					ResponseStatus.SUCCESS, "", list);
		}

		return json;
	}

	@Override
	public Question saveQuestion(Question question) throws Exception {
		if(question.getQuestionId()!=null){
			questionDao.saveOrUpdate(question);
		}else{
			Map<String, Object> propsMap = this.createPropMap(new Equality(
					"title", question.getTitle()));
			int count = questionDao.queryTotalCount(Question.class, propsMap).intValue();
			if(count>0){
				throw new Exception("已存在相同题目的问题！");
			}
			question.setAskDate(new Date());
			questionDao.save(question);
		}
		return question;
	}

	@Override
	public void deleteQuestion(Question question) {
		questionDao.delete(question);
	}

	@Override
	public String queryQuestions(Integer rows,
			Integer start, String sort, String order,Integer questionId) {
		String json = "";
		Map<String, Object> propsMap = this.createPropMap(new Equality(
				"questionId", questionId));
		List<Question>  list = questionDao.queryEntityListByProperties(Question.class, rows, start, sort, order, propsMap);
		if (list.isEmpty()) {
			json = JsonUtil.formatToJsonWithTimeStamp(0,
					ResponseStatus.SUCCESS, "", list);
		} else {
			int count = questionDao.queryTotalCount(Question.class, propsMap).intValue();
			json = JsonUtil.formatToJsonWithTimeStamp(count,
					ResponseStatus.SUCCESS, "", list);
		}

		return json;
	}

	@Override
	public String viewQuestion(Integer id) {
		Question question = questionDao.getById(Question.class, id);
		return JsonUtil.formatToJson(question,"yyyy-MM-dd HH:mm:ss");
	}

}