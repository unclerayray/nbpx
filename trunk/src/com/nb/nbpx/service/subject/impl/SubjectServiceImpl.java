package com.nb.nbpx.service.subject.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.nb.nbpx.common.ResponseStatus;
import com.nb.nbpx.dao.subject.ISubjectDao;
import com.nb.nbpx.pojo.subject.Subject;
import com.nb.nbpx.service.impl.BaseServiceImpl;
import com.nb.nbpx.service.subject.ISubjectService;
import com.nb.nbpx.utils.JsonUtil;
import com.nb.nbpx.utils.NbpxException;

/**
 * @author Roger
 * @date 2013年8月4日
 */
@Component("SubjectService")
public class SubjectServiceImpl extends BaseServiceImpl implements ISubjectService{
	@Resource
	private ISubjectDao subjectDao;
	@Override
	public String querySubjects(String category, String subjectText,
			Integer subjectId, Integer rows, Integer start, String sort,
			String order) throws NbpxException {
		String json = "";
		Map<String,Object> propsMap = new HashMap<String,Object>();
		if(category!=null&&category.isEmpty()){
			propsMap.put("category",category);
		}
		//TODO combobox的取值验证
		//List<Subject> list = subjectDao.queryEntityListByProperties(Subject.class, rows, start, propsMap);
		List<Subject> list = subjectDao.querySubjects(rows, start, category, subjectText, subjectId,sort,order);
		if(list.isEmpty()){
//			json = JsonUtil.formatToJsonWithTimeStamp(0,
//					ResponseStatus.SUCCESS, "", list);
			throw new NbpxException("未查询到结果");
		}else{
			int count = subjectDao.querysubjectsCount(rows, start, category, subjectText, subjectId).intValue();
			json = JsonUtil.formatToJsonWithTimeStamp(count,
					ResponseStatus.SUCCESS, "", list);
		}
		return json;
	}

	@Override
	public String queryComboSubjects(String category) {
		Map<String,Object> propsMap = new HashMap<String,Object>();
		if(category!=null&&category.isEmpty()){
			propsMap.put("category",category);
		}
		List<Subject> list = subjectDao.queryEntityListByProperties(Subject.class, null, null, propsMap);
		return JsonUtil.formatListToJson(list);
	}

	@Override
	public Boolean saveRecommands(String[] subjectIds) {
		return subjectDao.recommandSubjects(subjectIds);
	}

	@Override
	public Boolean importSubjects(String category, String[] subjectsArray) {
		subjectDao.importSubjects(category, subjectsArray);
		return true;
	}

	public ISubjectDao getSubjectDao() {
		return subjectDao;
	}

	public void setSubjectDao(ISubjectDao subjectDao) {
		this.subjectDao = subjectDao;
	}

}
