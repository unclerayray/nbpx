package com.nb.nbpx.server.course;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.nb.nbpx.server.BaseAction;
import com.nb.nbpx.service.course.ICourseService;
import com.nb.nbpx.service.solr.ISolrKeywordService;
import com.nb.nbpx.service.solr.ISolrSubjectService;

@Component("TrainAction")
@Scope("prototype")
public class TrainingAction extends BaseAction{
	
	private static final long serialVersionUID = 1L;
	private ICourseService courseService;

	@Resource
	private ISolrKeywordService solrKeywordService;
	private ISolrSubjectService solrSubjectService;
	public String flag;//(flag:1-行业，2-专业，3-职位，4-产品)
	public String catogery;//课程分类
	
	

	public String getPXTypeCourse(){
		String typeCode = "003_0"+catogery;//(01-财务管理,02-物流管理,03-人力资源,04-生产管理,05-营销培训,06-综合战略)
		String result = courseService.queryHotCourseByType(false, flag, typeCode, 10, 0);
		this.inputStream = castToInputStream(result);
	
		return SUCCESS;
	}	
	
	public String getNXTypeCourse(){
		String typeCode = "003_0"+catogery;//(01-财务管理,02-物流管理,03-人力资源,04-生产管理,05-营销培训,06-综合战略)
		String result = courseService.queryHotCourseByType(true, flag, typeCode, 10, 0);
		this.inputStream = castToInputStream(result);
	
		return SUCCESS;
	}
	
	public String getPXCourseByPrice(){
		String typeCode = "003_0"+catogery;//(01-财务管理,02-物流管理,03-人力资源,04-生产管理,05-营销培训,06-综合战略)
		String result = courseService.queryCourseByPrice(false, typeCode, 10, 0);
		this.inputStream = castToInputStream(result);
		
		return SUCCESS;
	}
	
	public String getNXCourseByPrice(){
		String typeCode = "003_0"+catogery;//(01-财务管理,02-物流管理,03-人力资源,04-生产管理,05-营销培训,06-综合战略)
		String result = courseService.queryCourseByPrice(true, typeCode, 10, 0);
		this.inputStream = castToInputStream(result);
		
		return SUCCESS;
	}
	
	public String getClassicPXCourse(){
		String result = courseService.queryClassiscCourse(false, 8, 0);
		this.inputStream = castToInputStream(result);
		
		return SUCCESS;
	}
	
	public String getClassicNXCourse(){
		String result = courseService.queryClassiscCourse(true, 8, 0);
		this.inputStream = castToInputStream(result);
		
		return SUCCESS;
	}
	
	public String getPXHotCourse(){
		String result = courseService.queryHotCourse(false, 7, 0);
		this.inputStream = castToInputStream(result);
		
		return SUCCESS;
	}
	
	public String getNXHotCourse(){
		String result = courseService.queryHotCourse(true, 7, 0);
		this.inputStream = castToInputStream(result);
		
		return SUCCESS;
	}
	
	public String getCourseType(){
		String result = courseService.queryCourseType(flag, 8, 0);
		this.inputStream = castToInputStream(result);
		
		return SUCCESS;
	}
	
	public String getPXTeachers(){
		String typeCode = "003_0"+catogery;//(01-财务管理,02-物流管理,03-人力资源,04-生产管理,05-营销培训,06-综合战略)
		String result = courseService.getTeacherRecommand(false, typeCode, 10, 0);
		
		this.inputStream = castToInputStream(result);
		return SUCCESS;
	}
	
	public String getNXTeachers(){
		String typeCode = "003_0"+catogery;//(01-财务管理,02-物流管理,03-人力资源,04-生产管理,05-营销培训,06-综合战略)
		String result = courseService.getTeacherRecommand(true, typeCode, 10, 0);
		
		this.inputStream = castToInputStream(result);
		return SUCCESS;
	}
	
	public String getPXRelatedKeyWords(){
		try {
			String result = solrKeywordService.queryRelatedKeywords("企业培训", 0, 20);
			this.inputStream = castToInputStream(result);
		} catch (Exception e) {
			e.printStackTrace();
			this.inputStream = castToInputStream("[]");
		}
		return SUCCESS;
	}
	
	public String getNXRelatedKeyWords(){
		try {
			String result = solrKeywordService.queryRelatedKeywords("企业内训", 0, 20);
			this.inputStream = castToInputStream(result);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}
	
	public String getPXRelatedSubjects(){
		try {
			String result = solrSubjectService.queryRelatedSubject("企业培训", 0, 20);
			this.inputStream = castToInputStream(result);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}
	
	public String getNXRelatedSubjects(){
		try {
			String result = solrSubjectService.queryRelatedSubject("企业内训", 0, 20);
			this.inputStream = castToInputStream(result);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}
	public ICourseService getCourseService() {
		return courseService;
	}
	
	@Resource
	public void setCourseService(ICourseService courseService) {
		this.courseService = courseService;
	}

	public String getFlag() {
		return flag;
	}

	public void setFlag(String flag) {
		this.flag = flag;
	}
	public String getCatogery() {
		return catogery;
	}

	public void setCatogery(String catogery) {
		this.catogery = catogery;
	}

	public ISolrKeywordService getSolrKeywordService() {
		return solrKeywordService;
	}
	public void setSolrKeywordService(ISolrKeywordService solrKeywordService) {
		this.solrKeywordService = solrKeywordService;
	}
	public ISolrSubjectService getSolrSubjectService() {
		return solrSubjectService;
	}
	@Resource
	public void setSolrSubjectService(ISolrSubjectService solrSubjectService) {
		this.solrSubjectService = solrSubjectService;
	}
	
}
