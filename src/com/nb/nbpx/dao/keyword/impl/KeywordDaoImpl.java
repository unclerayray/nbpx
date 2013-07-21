package com.nb.nbpx.dao.keyword.impl;

import org.springframework.stereotype.Component;

import com.nb.nbpx.dao.impl.BaseDaoImpl;
import com.nb.nbpx.dao.keyword.IKeywordDao;
import com.nb.nbpx.pojo.keyword.Keyword;

/**
 * @author Roger
 * @date 2013年7月21日
 */
@Component("KeywordDao")
public class KeywordDaoImpl extends BaseDaoImpl<Keyword, Integer> implements IKeywordDao {

}
