package com.nb.nbpx.service.keyword;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.List;

import com.nb.nbpx.dto.article.ArticleDetail;
import com.nb.nbpx.dto.course.CourseAllInfoDto;
import com.nb.nbpx.pojo.keyword.Keyword;
import com.nb.nbpx.service.IBaseService;
import com.nb.nbpx.utils.NbpxException;

/**
 * @author Roger
 * @date 2013年7月27日
 */
public interface IKeywordService extends IBaseService {
	public String queryKeywords(String category, String keywordText,
			Integer keywordId, Integer rows, Integer start, String sort, String order)
			throws NbpxException;

	public String getArticleKeyWordsList(Integer flag, String type,Integer start, Integer rows);
	
	public String queryComboKeywords(String category);
	
	public Boolean saveRecommands(String[] keyIds);
	
	public Boolean importKeywords(String category, String[] keywordsArray);
	

	/**
	 * 保存通过切割生成的Keywords，重复的忽略
	 * @return 带ID的keyword List
	 */
	public List<Keyword> saveKeywords(CourseAllInfoDto courseDto);
	

	/**
	 * 保存通过切割生成的Keywords，重复的忽略
	 * @return 带ID的keyword List
	 */
	public List<Keyword> saveKeywords(ArticleDetail articleDetail);
	
	public List<Keyword> saveKeywords(String category, String keywords);
	
	/**
	 * 在内容中添加关键词的超链接
	 * @param content
	 * @return
	 */
	public String setKeywordHyperLink(List<Keyword> keywords,String content);
	
	/**
	 * 在内容中添加超链接
	 * @param links
	 * @param content
	 * @return
	 */
	public String setHyperLink(String[]  links,String content);
	
	public String getKeyWordsListOnly(Integer flag,String type,Integer start,Integer rows);
	
	public String getKeyWordsList(boolean isInner,Integer flag,String type,Integer start,Integer rows);
	
	public String getKeyWordsListByType(String type,Integer start,Integer rows);
	
	public String getLastedKeyWords(Integer start,Integer rows);
	
	public void saveKeyword2Dic(String keyword) throws IOException;
	
	public List<Keyword> getKeywordsByKey(String key);
	
	public void saveKeywords2Dic(String[] keywords) throws IOException;
	
	public void removeKeyword(Integer keyId)throws Exception ;
	
	public String getHotKeyWords(Integer start,Integer rows);
}
