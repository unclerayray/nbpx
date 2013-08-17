package com.nb.nbpx.dao.keyword;

import java.util.List;

import com.nb.nbpx.dao.IBaseDao;
import com.nb.nbpx.pojo.course.CourseKeyword;
import com.nb.nbpx.pojo.keyword.Keyword;

/**
 * @author Roger
 * @date 2013年7月21日
 */
public interface IKeywordDao extends IBaseDao<Keyword, Integer> {
	
	/**
	 * 用于保存产生关键词，如果该关键词已存在于数据库中，就从数据库中把这条记录查出来并返回
	 * @param keyword 只包含keyword值的对象，无id
	 * @return
	 */
	public Keyword saveOrGetExistsKeyword(Keyword keyword);
	
	public List<Keyword> queryKeywords(Integer limit, Integer start, String category, String keyText, Integer keyId, String sort, String order);
	
	public Long querykeywordsCount(Integer limit, Integer start, String category, String keyText, Integer keyId);
	
	public Boolean recommandKeywords(String[] keyIds);
	
	public Boolean importKeywords(String category, String[] keywords);
	
	//得到关键词列表，flag:1代表点击率，2代表推荐，3代表热搜
	public List<Keyword> getKeyWordsList(boolean isInner,Integer flag,String type,Integer start,Integer rows);

}
