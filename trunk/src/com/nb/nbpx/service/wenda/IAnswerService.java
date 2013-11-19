package com.nb.nbpx.service.wenda;

import com.nb.nbpx.pojo.wenda.Answer;
import com.nb.nbpx.service.IBaseService;

/**
 * @author Roger
 * @date 2013年11月17日
 */
public interface IAnswerService extends IBaseService  {
	public String queryAnswers(Integer questionId);
	public Answer saveAnswer(Answer answer);
	public void deleteAnswer(Answer answer);
	public Boolean setBestAnswer(Integer answerId, Integer questionId);
}
