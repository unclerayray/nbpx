package com.nb.nbpx.service.subject.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.nb.nbpx.common.ResponseStatus;
import com.nb.nbpx.dao.subject.ISubjectDao;
import com.nb.nbpx.pojo.subject.Subject;
import com.nb.nbpx.service.impl.BaseServiceImpl;
import com.nb.nbpx.service.solr.ISolrSubjectService;
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
	@Resource
	private ISolrSubjectService solrSubjectService;
	@Override
	public String querySubjects(String category, String subjectText,
			Integer subjectId, Integer rows, Integer start, String sort,
			String order) throws NbpxException {
		String json = "";
		Map<String,Object> propsMap = new HashMap<String,Object>();
		if(category!=null){
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
		if(category!=null){
			propsMap.put("category",category);
		}
		List<Subject> list = subjectDao.queryEntityListByProperties(Subject.class, null, null, null, null , propsMap);
		return JsonUtil.formatListToJson(list);
	}

	//得到专题列表，flag:1代表点击率，2代表推荐，3代表热搜
	public String getSubjectsList(boolean isInner,String type,Integer flag,Integer start,Integer rows){
		List<Subject> subjects = subjectDao.getSubjectsList(isInner, type, flag, start, rows);
		
		List<Map<String,String>> results = new ArrayList<Map<String,String>>();
		for(Subject temp : subjects){
			Map<String,String> result = new HashMap<String,String>();
			result.put("id", temp.getSubjectId().toString());
			result.put("name", temp.getSubject());
			if(flag == 1)//1代表点击率，2代表推荐，3代表热搜
				result.put("count", temp.getHits().toString());
			if(flag == 3)
				result.put("count", temp.getSearchCnt().toString());
			
			results.add(result);
		}
		String json = JsonUtil.getJsonString(results);
		
		return json;
	}
	
	//分课程类别获取专题
	public String getSubjectsListByCategory(boolean isInner,String type,Integer start,Integer rows){
		List<Subject> subjects = subjectDao.getSubjectsListByCategory(isInner, type, start, rows);
		
		List<Map<String,String>> results = new ArrayList<Map<String,String>>();
		for(Subject temp : subjects){
			Map<String,String> result = new HashMap<String,String>();
			result.put("id", temp.getSubjectId().toString());
			result.put("name", temp.getSubject());
			
			results.add(result);
		}
		String json = JsonUtil.getJsonString(results);
		
		return json;
	}

	//根据行业、职位、产品、专业获取专题
	public String getSubjectsListByOthers(boolean isInner,String type,Integer start,Integer rows){
		List<Subject> subjects = subjectDao.getSubjectsListByOthers(isInner, type, start, rows);
		
		List<Map<String,String>> results = new ArrayList<Map<String,String>>();
		for(Subject temp : subjects){
			Map<String,String> result = new HashMap<String,String>();
			result.put("id", temp.getSubjectId().toString());
			result.put("name", temp.getSubject());
			
			results.add(result);
		}
		String json = JsonUtil.getJsonString(results);
		
		return json;
	}

	@Override
	public Boolean saveRecommands(String[] subjectIds) {
		return subjectDao.recommandSubjects(subjectIds);
	}

	@Override
	public Boolean importSubjects(String category, String[] subjectsArray) {
		subjectDao.importSubjects(category, subjectsArray);
		//TODO 其实暂时没有导入专题，没有用  ，加了的话要加solr索引函数
		return true;
	}

	public ISubjectDao getSubjectDao() {
		return subjectDao;
	}

	public void setSubjectDao(ISubjectDao subjectDao) {
		this.subjectDao = subjectDao;
	}

}
