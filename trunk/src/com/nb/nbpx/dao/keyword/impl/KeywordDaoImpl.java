package com.nb.nbpx.dao.keyword.impl;

import java.util.List;

import org.springframework.stereotype.Component;

import com.nb.nbpx.dao.impl.BaseDaoImpl;
import com.nb.nbpx.dao.keyword.IKeywordDao;
import com.nb.nbpx.pojo.keyword.Keyword;

/**
 * @author Roger
 * @date 2013年7月21日
 */
@Component("KeywordDao")
public class KeywordDaoImpl extends BaseDaoImpl<Keyword, Integer> implements
		IKeywordDao {

	@SuppressWarnings("rawtypes")
	@Override
	public Keyword saveOrGetExistsKeyword(Keyword keyword) {

		List list = find("from Keyword where keyword = '" + keyword.getKeyword()+"'");
		if (list.isEmpty()) {
			// 不存在重复
			save(keyword);
		} else {
			// 存在重复
			keyword = (Keyword) list.get(0);
		}

		return keyword;
	}

}
