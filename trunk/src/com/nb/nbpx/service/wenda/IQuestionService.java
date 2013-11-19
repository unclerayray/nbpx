package com.nb.nbpx.service.wenda;

import com.nb.nbpx.pojo.wenda.Question;
import com.nb.nbpx.service.IBaseService;

/**
 * @author Roger
 * @date 2013年11月17日
 */
public interface IQuestionService  extends IBaseService  {
	public String queryQuestions(Integer rows,
			Integer start, String sort, String order, Boolean closed);
	public String queryQuestions(Integer rows,
			Integer start, String sort, String order,Integer questionId);
	public Question saveQuestion(Question question) throws Exception ;
	public void deleteQuestion(Question question);
}
