package com.nb.nbpx.server.course;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.nb.nbpx.server.BaseAction;
import com.nb.nbpx.service.article.IArticleService;
import com.nb.nbpx.service.course.ICourseService;
import com.nb.nbpx.service.keyword.IKeywordService;
import com.nb.nbpx.service.subject.ISubjectService;

@Component("MainAction")
@Scope("prototype")
public class MainAction extends BaseAction{
	private static final long serialVersionUID = 1L;
	private ICourseService courseService;
	private IKeywordService keywordService;
	private ISubjectService subjectService;
	private IArticleService articleService;

	public String flag;//标记top Course的三种属性(1-推荐，2-精品，3-排行)||关键词(1-点击，2-推荐，3-热搜)
	public String isInner;//标记是内训还是培训
	public String type;//课程类别/文章类别
	

	public String getCourseByCity(){
		String city = "";
		if("1".equals(flag))
			city = "北京";
		else if("2".equals(flag))
			city = "上海";
		else if("3".equals(flag))
			city = "深圳";
		else if("4".equals(flag))
			city = "广州";
		else
			city = "苏州";
		String result = courseService.getCoursesByCity(city, 8, 0);
		this.inputStream = castToInputStream(result);
	
		return SUCCESS;
	}
	
	//首页30行推荐
	public String getTopCourse(){
		String result = courseService.getTopCourse(Integer.parseInt(flag), null);
		//System.out.println(result);
		this.inputStream = castToInputStream(result);
	
		return SUCCESS;
	}
	
	//获得培训的课程
	public String getPeiXun(){
		String typeCode = "003_0"+type;//(01-财务管理,02-物流管理,03-人力资源,04-生产管理,05-营销培训,06-综合战略)
		
		String result = courseService.getPXCourse(typeCode, Integer.parseInt(flag));
		this.inputStream = castToInputStream(result);

		return SUCCESS;
	}
	
	//获得内训的课程
	public String getNeiXun(){
		String typeCode = "003_0"+type;//(01-财务管理,02-物流管理,03-人力资源,04-生产管理,05-营销培训,06-综合战略)
		String result  = "";
		if(!"7".equals(type) && !"8".equals(type))
			result = courseService.getNXCourse(typeCode, Integer.parseInt(flag));
		else
			result = "[]";
		this.inputStream = castToInputStream(result);
		
		return SUCCESS;
	}
	
	//获取内训关键词或者培训关键词排行
	public String getKeywords(){
		int start = 0;
		int rows =0;
		Boolean ifInner = false;
		if("0".equals(isInner))//培训是10行
			rows = 11;
		else{//内训是12行
			rows = 12;
			ifInner = true;
		}	
		String result = keywordService.getKeyWordsList(ifInner, Integer.parseInt(flag),null, start, rows);
		
		this.inputStream = castToInputStream(result);
		return SUCCESS;
	}
	
	//获取培训专题或者内训专题排行
	public String getSubjects(){
		int start = 0;
		int rows = 0;
		Boolean ifInner = false;
		if("0".equals(isInner))//培训是10行
			rows = 11;
		else{//内训是12行
			rows = 12;
			ifInner = true;
		}
		
		String result = subjectService.getSubjectsList(ifInner, null, Integer.parseInt(flag), start, rows);
		
		this.inputStream = castToInputStream(result);
		return SUCCESS;
	}
	
	//获取本周最热或者本月最热的培训课程
	public String getTimeTopCourse(){
		int start = 0;
		int rows = 10;
		System.out.println(flag);
		String result = courseService.selectTimeTopCourse(flag,null,start,rows);
		
		this.inputStream = castToInputStream(result);
		return SUCCESS;
	}
	
	//获取文章内容(10个)
	public String getArticle(){
		int start = 0;
		int rows = 10;
		int currIndex = Integer.parseInt(flag)+(Integer.parseInt(type)-1)*2;
		String typeCode = "004_0"+currIndex;//(01-人力资源新闻,02-人力资源文章,03-职业生涯规划,04-市场营销管理,05-案例管理文章,06-经理人文章,07-生产管理文章,08-财务管理文章)
		
		String result = articleService.getArticleList(typeCode, rows, start);
		
		this.inputStream = castToInputStream(result);
		return SUCCESS;
	}
	
	
	public IArticleService getArticleService() {
		return articleService;
	}
	@Resource
	public void setArticleService(IArticleService articleService) {
		this.articleService = articleService;
	}
	public ISubjectService getSubjectService() {
		return subjectService;
	}
	@Resource
	public void setSubjectService(ISubjectService subjectService) {
		this.subjectService = subjectService;
	}
	public IKeywordService getKeywordService() {
		return keywordService;
	}
	@Resource
	public void setKeywordService(IKeywordService keywordService) {
		this.keywordService = keywordService;
	}
	
	public ICourseService getCourseService() {
		return courseService;
	}
	
	@Resource
	public void setCourseService(ICourseService courseService) {
		this.courseService = courseService;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getFlag() {
		return flag;
	}
	public void setFlag(String flag) {
		this.flag = flag;
	}
	public String getIsInner() {
		return isInner;
	}
	public void setIsInner(String isInner) {
		this.isInner = isInner;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
}
