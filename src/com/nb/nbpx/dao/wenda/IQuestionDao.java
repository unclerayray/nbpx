package com.nb.nbpx.dao.wenda;

import java.util.List;

import com.nb.nbpx.dao.IBaseDao;
import com.nb.nbpx.pojo.wenda.Question;

/**
 * @author Roger
 * @date 2013年11月17日
 */
public interface IQuestionDao extends IBaseDao<Question,Integer>{
	public List<Question>  queryQuestions(Integer rows, Integer start, String sort,
			String order, Boolean closed, String title, String askedBy);
}
