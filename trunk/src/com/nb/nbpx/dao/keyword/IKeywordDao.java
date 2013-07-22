package com.nb.nbpx.dao.keyword;

import com.nb.nbpx.dao.IBaseDao;
import com.nb.nbpx.pojo.keyword.Keyword;

/**
 * @author Roger
 * @date 2013年7月21日
 */
public interface IKeywordDao extends IBaseDao<Keyword, Integer> {
	
	/**
	 * 用于保存产生关键字，如果该关键字已存在于数据库中，就从数据库中把这条记录查出来并返回
	 * @param keyword 只包含keyword值的对象，无id
	 * @return
	 */
	public Keyword saveOrGetExistsKeyword(Keyword keyword);
}
