package com.nb.nbpx.service.keyword;

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

	public String queryComboKeywords(String category);
	
	public Boolean saveRecommands(String[] keyIds);
	
	public Boolean importKeywords(String category, String[] keywordsArray);
}
