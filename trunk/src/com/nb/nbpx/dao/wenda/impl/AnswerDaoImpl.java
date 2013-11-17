package com.nb.nbpx.dao.wenda.impl;

import org.springframework.stereotype.Component;

import com.nb.nbpx.dao.impl.BaseDaoImpl;
import com.nb.nbpx.dao.wenda.IAnswerDao;
import com.nb.nbpx.pojo.wenda.Answer;

@Component("AnswerDao")
public class AnswerDaoImpl  extends BaseDaoImpl<Answer, Integer> implements
IAnswerDao {

}
