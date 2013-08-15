package com.nb.nbpx.dao.subject;

import java.util.List;

import com.nb.nbpx.dao.IBaseDao;
import com.nb.nbpx.pojo.subject.Subject;

public interface ISubjectDao extends IBaseDao<Subject,Integer>{
	/**
	 * 用于保存产生专题，如果该专题已存在于数据库中，就从数据库中把这条记录查出来并返回
	 * @param subject 只包含subject值的对象，无id
	 * @return
	 */
	public Subject saveOrGetExistsSubject(Subject subject);
	
	public List<Subject> querySubjects(Integer limit, Integer start, String category, String subjectText, Integer subjectId, String sort, String order);
	
	public Long querysubjectsCount(Integer limit, Integer start, String category, String subjectText, Integer subjectId);
	
	public Boolean recommandSubjects(String[] keyIds);
	
	public Boolean importSubjects(String category, String[] subjects);
}
