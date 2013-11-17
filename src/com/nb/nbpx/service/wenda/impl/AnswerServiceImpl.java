package com.nb.nbpx.service.wenda.impl;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.nb.nbpx.common.ResponseStatus;
import com.nb.nbpx.dao.wenda.IAnswerDao;
import com.nb.nbpx.pojo.wenda.Answer;
import com.nb.nbpx.service.impl.BaseServiceImpl;
import com.nb.nbpx.service.wenda.IAnswerService;
import com.nb.nbpx.utils.JsonUtil;
import com.nb.nbpx.utils.daotool.Equality;

/**
 * @author Roger
 * @date 2013年11月17日
 */
@Component("AnswerService")
public class AnswerServiceImpl  extends BaseServiceImpl implements IAnswerService{
	public IAnswerDao answerDao;
	public IAnswerDao getAnswerDao() {
		return answerDao;
	}

	@Resource
	public void setAnswerDao(IAnswerDao answerDao) {
		this.answerDao = answerDao;
	}

	@Override
	public String queryAnswers(Integer questionId) {
		String json = "";
		Map<String, Object> propsMap = this.createPropMap(new Equality(
				"questionId", questionId));
		List<Answer>  list = answerDao.queryEntityListByProperties(Answer.class, null, null, null, null, propsMap);
		if (list.isEmpty()) {
			json = JsonUtil.formatToJsonWithTimeStamp(0,
					ResponseStatus.SUCCESS, "", list);
		} else {
			int count = answerDao.queryTotalCount(Answer.class, propsMap).intValue();
			json = JsonUtil.formatToJsonWithTimeStamp(count,
					ResponseStatus.SUCCESS, "", list);
		}

		return json;
	}

	@Override
	public Answer saveAnswer(Answer answer) {
		if(answer.getAnswerId()!=null){
			answerDao.saveOrUpdate(answer);
		}else{
			answer.setAnswerdDate(new Date());
			answerDao.save(answer);
		}
		return answer;
	}

	@Override
	public void deleteAnswer(Answer answer) {
		answerDao.delete(answer);
	}

}
