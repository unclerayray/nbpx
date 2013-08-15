package com.nb.nbpx.service.subject;

import com.nb.nbpx.service.IBaseService;
import com.nb.nbpx.utils.NbpxException;

/**
 * @author Roger
 * @date 2013年8月4日
 */
public interface ISubjectService extends IBaseService{
	public String querySubjects(String category, String subjectText,
			Integer subjectId, Integer rows, Integer start, String sort, String order)
			throws NbpxException;

	public String queryComboSubjects(String category);
	
	public Boolean saveRecommands(String[] subjectIds);
	
	public Boolean importSubjects(String category, String[] subjectsArray);
}
