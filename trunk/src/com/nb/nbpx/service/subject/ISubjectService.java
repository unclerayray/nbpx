package com.nb.nbpx.service.subject;

import java.util.List;

import com.nb.nbpx.pojo.keyword.Keyword;
import com.nb.nbpx.pojo.subject.Subject;
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
	
	public List<Subject> saveSubjects(String category, String subjects);
	
	public Boolean importSubjects(String category, String[] subjectsArray);
	
	//得到专题列表，flag:1代表点击率，2代表推荐，3代表热搜
	public String getSubjectsList(boolean isInner,String type,Integer flag,Integer start,Integer rows);
	
	//分课程类别获取专题
	public String getSubjectsListByCategory(boolean isInner,String type,Integer start,Integer rows);
	
	//根据行业、职位、产品、专业获取专题
	public String getSubjectsListByOthers(boolean isInner,String type,Integer start,Integer rows);

}
