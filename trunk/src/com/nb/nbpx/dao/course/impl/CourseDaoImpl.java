package com.nb.nbpx.dao.course.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.transform.Transformers;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.stereotype.Component;

import com.nb.nbpx.dao.course.ICourseDao;
import com.nb.nbpx.dao.impl.BaseDaoImpl;
import com.nb.nbpx.dto.course.CourseAllInfoDto;
import com.nb.nbpx.pojo.course.Course;
import com.nb.nbpx.pojo.course.CourseInfo;
import com.nb.nbpx.pojo.system.Dictionary;
import com.nb.nbpx.pojo.user.TeacherInfo;

@Component("courseDao")
@SuppressWarnings({ "unchecked", "rawtypes", "unused" })
public class CourseDaoImpl extends BaseDaoImpl<Course, Integer> implements
		ICourseDao {
	private JdbcTemplate jdbcTemplate;

	public JdbcTemplate getJdbcTemplate() {
		return jdbcTemplate;
	}

	@Resource
	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	@Override
	public List<Course> queryCourses(final String category,
			final Integer courseId, final Integer rows, final Integer start, final String sort, final String order, final Boolean isInner) {
		List<Course> list = new ArrayList<Course>();
		list = getHibernateTemplate().executeFind(new HibernateCallback() {

			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				int i = 0;
				StringBuffer hql = new StringBuffer(
						"select new com.nb.nbpx.pojo.course.Course"
								+ " (c.courseId, c.title,c.isInner, c.teacherId, "
								+ "ti.realName, c.category, fd.showName, c.lastUpdateDate, "
								+ " c.state, c.hits , c.price, c.recommanded, c.classic) from Course c, Dictionary fd, TeacherInfo ti"
								+ " where 1 = 1 ");
				if (category != null && !category.isEmpty()) {
					hql.append(" and category = ? ");
				}

				if (courseId != null) {
					hql.append(" and courseId = ? ");
				}
				
				if (isInner != null) {
					hql.append(" and isInner = ? ");
				}
				hql.append(" and c.category = fd.codeName ");
				hql.append(" and ti.teacherId = c.teacherId");

				if (sort != null && !sort.isEmpty()) {
					if("teacherName".equals(sort)){
						hql.append(" order by c.teacherId");
					}else{
						hql.append(" order by c." + sort);
					}
					if (order != null && !order.isEmpty()) {
						hql.append(" " + order);
					}
				}else{
					hql.append(" order by c.lastUpdateDate desc ");
				}
				Query query = session.createQuery(hql.toString());

				if (category != null && !category.isEmpty()) {
					query.setString(i++, category);
				}

				if (courseId != null) {
					query.setInteger(i++, courseId);
				}
				
				if (isInner != null) {
					query.setBoolean(i++, isInner);
				}

				if (start != null && rows != null) {
					query.setFirstResult(start);
					query.setMaxResults(rows);
				}

				return query.list();
			}
		});
		return list;
	}

	@Override
	public Long queryCourseCount(final String category, final Integer courseId) {
		List list = new ArrayList();
		list = getHibernateTemplate().executeFind(new HibernateCallback() {

			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				int i = 0;
				StringBuffer hql = new StringBuffer(
						"select count(c) from Course c where 1 = 1");
				if (category != null && !category.isEmpty()) {
					hql.append(" and category = ? ");
				}

				if (courseId != null) {
					hql.append(" and courseId = ? ");
				}
				Query query = session.createQuery(hql.toString());

				if (category != null && !category.isEmpty()) {
					query.setString(i++, category);
				}

				if (courseId != null) {
					query.setInteger(i++, courseId);
				}

				return query.list();
			}
		});
		return (Long) list.get(0);
	}

	@Override
	public List<Dictionary> queryCourseType() {
		List<Dictionary> list = new ArrayList<Dictionary>();
		list = getHibernateTemplate().executeFind(new HibernateCallback() {

			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				StringBuffer hql = new StringBuffer(
						"select new Dictionary(d.codeName,d.showName) from Dictionary d where dicType = '003'");
				Query query = session.createQuery(hql.toString());
				return query.list();
			}

		});
		return list;
	}

	@Override
	public List<TeacherInfo> queryTeachers() {
		List<TeacherInfo> list = new ArrayList<TeacherInfo>();
		list = getHibernateTemplate().executeFind(new HibernateCallback() {

			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				StringBuffer hql = new StringBuffer(
						"select new com.nb.nbpx.pojo.user.TeacherInfo(teacherId,realName) from TeacherInfo ");
				Query query = session.createQuery(hql.toString());
				return query.list();
			}

		});
		return list;
	}

	@Override
	public boolean checkDuplicateProp(final Course course) {
		List list = new ArrayList();
		list = getHibernateTemplate().executeFind(new HibernateCallback() {

			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				StringBuffer hql = new StringBuffer(
						"select count(d) from Course d where 1 = 1 ");
				hql.append(" and title = '" + course.getTitle()
						+ "' and teacherId = '" + course.getTeacherId() + "'");
				if(course.getIsInner()){
					hql.append(" and isInner = '1'");
				}else{
					hql.append(" and isInner = '0'");
				}
				Query query = session.createQuery(hql.toString());
				return query.list();
			}
		});
		Long countL = (Long) list.get(0);
		if (countL.intValue() > 0) {
			return true;
		} else {
			return false;
		}
	}

	// 按照点击率来选取
	public List<Course> getHotCourse(final Boolean ifInner, final String type,
			final Integer rows, final Integer start) {
		List<Course> list = new ArrayList<Course>();
		list = getHibernateTemplate().executeFind(new HibernateCallback() {

			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				int i = 0;
				StringBuffer hql = new StringBuffer(
						"select new com.nb.nbpx.pojo.course.Course(c.courseId, c.title,"
								+ "c.teacherId, '', c.category,"
								+ "'',c.state,c.hits,c.price,c.recommanded,c.classic) from Course c ,CourseInfo b where c.courseId = b.courseId and 1=1 ");
				if (type != null && !"".equals(type))
					hql.append(" and c.category = '" + type + "'");
				if (ifInner != null) {// 区分内训和培训
					if (ifInner) 
						hql.append(" and c.isInner = 1");
					else
						hql.append(" and c.isInner = 0");
				}

				// 取向后的有效的日期
				hql.append("and TO_DAYS(NOW())-TO_DAYS(b.startDate)<0 order by c.hits desc");

				Query query = session.createQuery(hql.toString());

				if (start != null && rows != null) {
					query.setFirstResult(start);
					query.setMaxResults(rows);
				}
				return query.list();
			}
		});
		return list;
	}

	// 获取最新的课程信息
	public List<Course> getLastedCourse(final Boolean ifInner,
			final String type, final Boolean ifRecommand,
			final Boolean ifClassic, final Integer rows, final Integer start) {
		List<Course> list = new ArrayList<Course>();
		list = getHibernateTemplate().executeFind(new HibernateCallback() {

			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				int i = 0;
				StringBuffer hql = new StringBuffer(
						"select new com.nb.nbpx.pojo.course.Course(c.courseId, c.title,"
								+ "c.teacherId, '', c.category,"
								+ "'',c.state,c.hits,c.price,c.recommanded,c.classic) from Course c,CourseInfo b where c.courseId = b.courseId and c.state=1 and 1=1 ");
				if (type != null && !"".equals(type))
					hql.append(" and c.category = '" + type + "'");
				if (ifInner != null) {// 区分内训和培训
					if (ifInner)
						hql.append(" and c.isInner = 1");
					else
						hql.append(" and c.isInner = 0");
				}

				if (ifRecommand)
					hql.append(" and c.recommanded = 1 ");
				if (ifClassic)
					hql.append(" and c.classic = 1 ");
				hql.append("and TO_DAYS(NOW())-TO_DAYS(b.startDate)<0 order by b.startDate asc");
				// 取向后的有效的日期
				// hql.append(" and c.courseId in (select b.courseId from CourseInfo b where TO_DAYS(NOW())-TO_DAYS(b.startDate)<0) order by c.courseId desc");
				Query query = session.createQuery(hql.toString());

				if (start != null && rows != null) {
					query.setFirstResult(start);
					query.setMaxResults(rows);
				}
				return query.list();
			}
		});
		return list;
	}
	
	public Integer CountCourseByCity(final String cityName,final String year,final String month,final String flag,final Integer rows,final Integer start){
		List list = new ArrayList();
		list = getHibernateTemplate().executeFind(new HibernateCallback() {
			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				StringBuffer hql = new StringBuffer("select count(*) as val from courseInfo a,sys_dictionary b where a.city = b.codeName ");
				if(cityName != null)
					hql.append(" and b.showName='"+cityName+"'");
				if(year != null)
					hql.append(" and year(a.startDate) ='"+year+"'");
				if(month != null)
					hql.append(" and month(a.startDate) ='"+month+"'");
				if("1".equals(flag))
					hql.append(" order by a.startDate asc");
				else
					hql.append(" order by a.startDate desc");
				Query query = session.createSQLQuery(hql.toString()).addScalar("val",Hibernate.INTEGER);
				
				return query.list();
			}
		});
		return (Integer)list.get(0);
	}
	
	public List<CourseInfo> getCourseInfoByCity(final String cityName,final String year,final String month,final String flag,final Integer rows,final Integer start){
		List<CourseInfo> list = new ArrayList<CourseInfo>();
		list = getHibernateTemplate().executeFind(new HibernateCallback() {
			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				StringBuffer hql = new StringBuffer("select a.* from courseInfo a,sys_dictionary b,courses c where a.city = b.codeName and a.courseId = c.courseId and c.state=1 ");
				if(cityName != null)
					hql.append(" and b.showName='"+cityName+"'");
				if(year != null)
					hql.append(" and year(a.startDate) ='"+year+"'");
				if(month != null)
					hql.append(" and month(a.startDate) ='"+month+"'");
				hql.append(" and TO_DAYS(NOW())-TO_DAYS(a.startDate)<0 ");
				if("1".equals(flag))
					hql.append(" order by a.startDate asc");
				else
					hql.append(" order by a.startDate desc");
				Query query = session.createSQLQuery(hql.toString()).addEntity(CourseInfo.class);
				
				if (start != null && rows != null) {
					query.setFirstResult(start);
					query.setMaxResults(rows);
				}
				return query.list();
			}
		});
		
		return list;
	}
	// 根据城市获取课程信息
	public List<Course> getCourseByCity(final String city, final Integer rows,
			final Integer start) {
		List<Course> list = new ArrayList<Course>();
		list = getHibernateTemplate().executeFind(new HibernateCallback() {

			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				int i = 0;
				StringBuffer hql = new StringBuffer(
						"select new com.nb.nbpx.pojo.course.Course(c.courseId, c.title,"
								+ "c.teacherId, '', c.category,"
								+ "c.shortName,c.state,c.hits,c.price,c.recommanded,c.classic) from Course c where c.courseId in (select b.courseId from CourseInfo b where b.city = (select d.codeName from Dictionary d where d.showName='"
								+ city
								+ "') and TO_DAYS(NOW())-TO_DAYS(b.startDate)<0) order by c.courseId desc");

				Query query = session.createQuery(hql.toString());

				if (start != null && rows != null) {
					query.setFirstResult(start);
					query.setMaxResults(rows);
				}
				return query.list();
			}
		});
		return list;
	}

	// 根据课程和开课地点获取课程信息
	public List<CourseInfo> getCourseInfoByCity(final String city,
			final Integer courseId, final Integer flag) {
		List<CourseInfo> list = new ArrayList<CourseInfo>();
		list = getHibernateTemplate().executeFind(new HibernateCallback() {
			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				int i = 0;
				StringBuffer hql = new StringBuffer(
						"select new com.nb.nbpx.pojo.course.CourseInfo(c.courseInfoId, c.courseId, c.startDate,"
								+ "c.endDate, c.city,'') from CourseInfo c where 1=1");
				if (city != null && !"".equals(city))
					hql.append("and c.city = (select d.codeName from Dictionary d where d.showName='"
							+ city + "')");
				if (courseId != null)
					hql.append("and c.courseId = " + courseId);
				if (flag == 1)
					hql.append(" order by c.startDate desc");
				else
					hql.append(" order by c.startDate asc");
				Query query = session.createQuery(hql.toString());

				return query.list();
			}
		});
		return list;

	}

	// 根据课程ID获取课程信息
	public Course getCourseById(final Integer courseId) {
		List<Course> result = new ArrayList<Course>();
		result = getHibernateTemplate().executeFind(new HibernateCallback() {
			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				int i = 0;
				StringBuffer hql = new StringBuffer(
						"select new com.nb.nbpx.pojo.course.Course(c.courseId, c.title,c.price,"
								+ "c.teacherId,'',"
								+ "c.category,c.content,c.blockedContent,"
								+ "c.isInner,c.state, c.hasVideo,c.hits,"
								+ "c.createdBy,c.lastUpdatedBy,c.creationDate,"
								+ "c.lastUpdateDate,'',c.recommanded,"
								+ "c.classic) from Course c where  c.courseId ="
								+ courseId);
				Query query = session.createQuery(hql.toString());
				return query.list();
			}
		});
		if (result == null || result.size() == 0)
			return null;
		return (Course) result.get(0);
	}

	@Override
	public void deleteAllOtherInfosCourse(Integer courseId,
			Boolean deleteCourseInfo) {
		String sql1 = "delete from courseinfo where courseId = " + courseId;
		String sql2 = "delete from coursekeywords where courseId = " + courseId;
		String sql3 = "delete from coursemajor where courseId = " + courseId;
		String sql4 = "delete from coursetarget where courseId = " + courseId;
		String sql5 = "delete from courseindustry where courseId = " + courseId;
		String sql7 = "delete from coursesubjects where courseId = " + courseId;
		String sql6 = "delete from courseproduct where courseId = " + courseId;
		if (deleteCourseInfo) {
			String[] sqlArr = { sql1, sql2, sql3, sql4, sql5, sql6, sql7 };
			int i[] = jdbcTemplate.batchUpdate(sqlArr);
		} else {
			String[] sqlArr = { sql2, sql3, sql4, sql5, sql6, sql7 };
			int i[] = jdbcTemplate.batchUpdate(sqlArr);
		}
	}

	@Override
	public void addAllCourseInfo(CourseAllInfoDto courseDto) {
		Integer courseId = courseDto.getCourseId();
		List<String> list = new ArrayList<String>();
		String[] coursekeywords = courseDto.getKeywords().split(",");
		String[] coursesubjects = courseDto.getSubject().split(",");
		String[] coursemajors = courseDto.getMajor().split(",");
		String[] coursetargets = courseDto.getTargets().split(",");
		String[] courseindustry = courseDto.getIndustry().split(",");
		String[] courseproduct = courseDto.getIndustry().split(",");
		for (String str : coursekeywords) {
			StringBuffer sql = new StringBuffer(
					"insert into coursekeywords (courseId,keyword) values ");
			// 在这里保存keyword实体
			sql.append("(").append(courseId).append(",'").append(str)
					.append("');");
			list.add(sql.toString());
		}

		for (String str : coursesubjects) {
			StringBuffer sql = new StringBuffer(
					"insert into coursesubjects (courseId,subject) values ");
			// 在这里保存keyword实体
			sql.append("(").append(courseId).append(",'").append(str)
					.append("');");
			list.add(sql.toString());
		}

		for (String str : coursemajors) {
			StringBuffer sql = new StringBuffer(
					"insert into coursemajor (courseId,major) values ");
			sql.append("(").append(courseId).append(",'").append(str)
					.append("');");
			list.add(sql.toString());
		}

		for (String str : coursetargets) {
			StringBuffer sql = new StringBuffer(
					"insert into coursetargets (courseId,target) values ");
			sql.append("(").append(courseId).append(",'").append(str)
					.append("');");
			list.add(sql.toString());
		}

		for (String str : courseindustry) {
			StringBuffer sql = new StringBuffer(
					"insert into courseindustry (courseId,industry) values ");
			sql.append("(").append(courseId).append(",'").append(str)
					.append("');");
			list.add(sql.toString());
		}
		
		for (String str : courseproduct) {
			StringBuffer sql = new StringBuffer(
					"insert into courseproduct (courseId,product) values ");
			sql.append("(").append(courseId).append(",'").append(str)
					.append("');");
			list.add(sql.toString());
		}

		String[] sqlArr = list.toArray(new String[list.size()]);
		jdbcTemplate.batchUpdate(sqlArr);

	}

	@Override
	public void addAllOtherCourseInfo(Integer courseId,
			Map<String, String> industryMap, Map<String, String> tagetMap,
			Map<String, String> majorMap, Map<Integer, String> keywordMap,
			Map<Integer, String> subjectMap, Map<String, String> productMap) {
		List<String> list = new ArrayList<String>();
		Iterator industryIter = industryMap.entrySet().iterator();
		Iterator tagetIter = tagetMap.entrySet().iterator();
		Iterator majorIter = majorMap.entrySet().iterator();
		Iterator keywordIter = keywordMap.entrySet().iterator();
		Iterator subjectIter = subjectMap.entrySet().iterator();
		Iterator productIter = productMap.entrySet().iterator();
		while (industryIter.hasNext()) {
			Map.Entry entry = (Map.Entry) industryIter.next();
			String code = entry.getKey().toString();
			String value = entry.getValue().toString();
			StringBuffer sql = new StringBuffer(
					"insert into courseindustry (courseId,industry,industryCode) values ");
			sql.append("(").append(courseId).append(",'").append(value)
					.append("','").append(code).append("');");
			list.add(sql.toString());
		}

		while (tagetIter.hasNext()) {
			Map.Entry entry = (Map.Entry) tagetIter.next();
			String code = entry.getKey().toString();
			String value = entry.getValue().toString();
			StringBuffer sql = new StringBuffer(
					"insert into coursetarget (courseId,target,targetCode) values ");
			sql.append("(").append(courseId).append(",'").append(value)
					.append("','").append(code).append("');");
			list.add(sql.toString());
		}
		
		while (productIter.hasNext()) {
			Map.Entry entry = (Map.Entry) productIter.next();
			String code = entry.getKey().toString();
			String value = entry.getValue().toString();
			StringBuffer sql = new StringBuffer(
					"insert into courseproduct (courseId,product,productCode) values ");
			sql.append("(").append(courseId).append(",'").append(value)
					.append("','").append(code).append("');");
			list.add(sql.toString());
		}

		while (majorIter.hasNext()) {
			Map.Entry entry = (Map.Entry) majorIter.next();
			String code = entry.getKey().toString();
			String value = entry.getValue().toString();
			StringBuffer sql = new StringBuffer(
					"insert into coursemajor (courseId,major,majorCode) values ");
			sql.append("(").append(courseId).append(",'").append(value)
					.append("','").append(code).append("');");
			list.add(sql.toString());
		}

		while (keywordIter.hasNext()) {
			Map.Entry entry = (Map.Entry) keywordIter.next();
			Integer wordId = (Integer) (entry.getKey());
			String value = entry.getValue().toString();
			StringBuffer sql = new StringBuffer(
					"insert into coursekeywords (courseId,keyword,keywordId) values ");
			sql.append("(").append(courseId).append(",'").append(value)
					.append("','").append(wordId).append("');");
			list.add(sql.toString());
		}

		while (subjectIter.hasNext()) {
			Map.Entry entry = (Map.Entry) subjectIter.next();
			Integer subjectId = (Integer) (entry.getKey());
			String value = entry.getValue().toString();
			StringBuffer sql = new StringBuffer(
					"insert into coursesubjects (courseId,subject,subjectId) values ");
			sql.append("(").append(courseId).append(",'").append(value)
					.append("','").append(subjectId).append("');");
			list.add(sql.toString());
		}

		String[] sqlArr = list.toArray(new String[list.size()]);
		jdbcTemplate.batchUpdate(sqlArr);
	}

	@Override
	public Course updateCourse(Course course) {
		String sql = "update Course SET title = ?,teacherId = ?  ,category = ? ,isInner = ?  ,price = ?  ,content = ?  ,"
				+ "blockedContent = ?  ,hasVideo = ? ,lastUpdateDate = ?  ,"
				+ "recommanded = ? ,state = ? ,classic = ?, links = ? WHERE courseId = ?";
		Object[] values = { course.getTitle(), course.getTeacherId(),
				course.getCategory(), course.getIsInner(), course.getPrice(),
				course.getContent(), course.getBlockedContent(),
				course.getHasVideo(), course.getLastUpdateDate(),
				course.getRecommanded(), course.getState(),
				course.getClassic(), course.getLinks() , course.getCourseId() };
		getHibernateTemplate().bulkUpdate(sql, values);
		return null;
	}
	
	//flag:0为一个星期，1,2,3...为月份,cityName不为空时查找的是改城市下最热的课程
	@Override
	public List<Course> selectTimeTopCourse(final String flag,final String cityName,final Boolean isInner,final Integer start,final Integer rows) {
		List<Course> result = new ArrayList<Course>();
		result = getHibernateTemplate().executeFind(new HibernateCallback() {
			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
					StringBuffer sql = new StringBuffer("select distinct a.* from courses a,courseinfo b,sys_dictionary c where a.courseId = b.courseId and b.city = c.codeName and a.state=1");
					if(cityName != null && !"".equals(cityName))
						sql.append(" and c.showName='"+cityName+"'");
					if(isInner)
						sql.append(" and a.isInner = 1");
					if("".equals(flag))
						sql.append(" and TO_DAYS(NOW())-TO_DAYS(b.startDate) between 0 and 7 order by a.hits desc");
					else
						sql.append(" and month(b.startDate) ='"+flag+"'");
					
					Query query = session.createSQLQuery(sql.toString()).addEntity(Course.class);
					
					if (start != null && rows != null) {
						query.setFirstResult(start);
						query.setMaxResults(rows);
					}
					
					return query.list();
			}
		});
	
		return result;
	}
	//根据地点获取最热的课程
	public List<Course> getHotCourseByPlace(final Boolean ifInner, final String cityName,final Integer rows, final Integer start){
		List<Course> list = new ArrayList<Course>();
		list = getHibernateTemplate().executeFind(new HibernateCallback() {
			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				int i = 0;
				StringBuffer hql = new StringBuffer(
						"select new com.nb.nbpx.pojo.course.Course(c.courseId, c.title,"
								+ "c.teacherId, '', c.category,"
								+ "'',c.state,c.hits,c.price,c.recommanded,c.classic) from Course c ,CourseInfo b,Dictionary d where c.courseId = b.courseId and b.city = d.codeName and 1=1 ");
				if (ifInner != null) {// 区分内训和培训
					if (ifInner)
						hql.append(" and c.isInner = 1");
					else
						hql.append(" and c.isInner = 0");
				}
				if(cityName != null && !"".equals(cityName))
					hql.append(" and d.showName = '"+cityName+"'");
				// 取向后的有效的日期
				hql.append(" and TO_DAYS(NOW())-TO_DAYS(b.startDate)<0 order by c.hits desc");

				Query query = session.createQuery(hql.toString());

				if (start != null && rows != null) {
					query.setFirstResult(start);
					query.setMaxResults(rows);
				}
				return query.list();
			}
		});
		return list;
	}

	//根据行业、专业、产品、职位获取(flag:1-行业，2-专业，3-产品，4-职位),按照热度排行
	public List<Course> getHotCourseByType(final Boolean isInner,final String type,
			final String flag, final Integer start, final Integer rows) {
		List<Course> list = new ArrayList<Course>();
		list = getHibernateTemplate().executeFind(new HibernateCallback() {

			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				int i = 0;
				StringBuffer hql = new StringBuffer(
						"select new com.nb.nbpx.pojo.course.Course(c.courseId, c.title,"
								+ "c.teacherId, '', c.category,"
								+ "'',c.state,c.hits,c.price,c.recommanded,c.classic) from Course c ,CourseInfo b where c.courseId = b.courseId and 1=1 ");
				if (type != null && !"".equals(type))
					hql.append(" and c.category = '" + type + "'");
				if (isInner != null) {// 区分内训和培训
					if (isInner)
						hql.append(" and c.isInner = 1");
					else
						hql.append(" and c.isInner = 0");
				}
				String tableName = "";
				if("1".equals(flag))
					tableName = "CourseIndustry";
				else if("2".equals(flag))
					tableName = "CourseMajor";
				else if("3".equals(flag))
					tableName = "CourseTarget";
				else
					tableName = "CourseProduct";
				
				// 取向后的有效的日期
				hql.append(" and c.state = 1 ");
				hql.append("and TO_DAYS(NOW())-TO_DAYS(b.startDate)<0");
				hql.append(" and exists( select 1 from  "+tableName+" s where c.courseId=s.courseId)");
				hql.append(" order by c.hits desc");
				Query query = session.createQuery(hql.toString());

				if (start != null && rows != null) {
					query.setFirstResult(start);
					query.setMaxResults(rows);
				}
				return query.list();
			}
		});
		return list;
		
	}

	@Override
	public List<Course> getCourseByPrice(final Boolean isInner, final String type,
			final Integer start, final Integer rows) {
		
		List<Course> list = new ArrayList<Course>();
		list = getHibernateTemplate().executeFind(new HibernateCallback() {

			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				int i = 0;
				StringBuffer hql = new StringBuffer(
						"select new com.nb.nbpx.pojo.course.Course(c.courseId, c.title,"
								+ "c.teacherId, '', c.category,"
								+ "'',c.state,c.hits,c.price,c.recommanded,c.classic) from Course c ,CourseInfo b where c.courseId = b.courseId and 1=1 ");
				if (type != null && !"".equals(type))
					hql.append(" and c.category = '" + type + "'");
				if (isInner != null) {// 区分内训和培训
					if (isInner)
						hql.append(" and c.isInner = 1");
					else
						hql.append(" and c.isInner = 0");
				}

				hql.append(" and c.state = 1 ");
				// 取向后的有效的日期
				hql.append(" and TO_DAYS(NOW())-TO_DAYS(b.startDate)<0 order by c.price desc");
				Query query = session.createQuery(hql.toString());

				if (start != null && rows != null) {
					query.setFirstResult(start);
					query.setMaxResults(rows);
				}
				return query.list();
			}
		});
		return list;
		
	}
	//获取金牌课程
	@Override
	public List<Course> getGoldCourse(final Boolean isInner,final String type, final Integer start,
			final Integer rows,final Integer price) {
		List<Course> list = new ArrayList<Course>();
		list = getHibernateTemplate().executeFind(new HibernateCallback() {

			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				int i = 0;
				StringBuffer hql = new StringBuffer(
						"select new com.nb.nbpx.pojo.course.Course(c.courseId, c.title,"
								+ "c.teacherId, '', c.category,"
								+ "'',c.state,c.hits,c.price,c.recommanded,c.classic) from Course c ,CourseInfo b where c.courseId = b.courseId and 1=1 ");
				if (type != null && !"".equals(type))
					hql.append(" and c.category = '" + type + "'");
				if (isInner != null) {// 区分内训和培训
					if (isInner)
						hql.append(" and c.isInner = 1");
					else
						hql.append(" and c.isInner = 0");
				}

				hql.append(" and c.classic = 1 ");
				hql.append(" and c.state = 1 ");
				hql.append(" and c.price > "+price);
				// 取向后的有效的日期
				hql.append(" and TO_DAYS(NOW())-TO_DAYS(b.startDate)<0 order by c.hits desc");
				Query query = session.createQuery(hql.toString());

				if (start != null && rows != null) {
					query.setFirstResult(start);
					query.setMaxResults(rows);
				}
				return query.list();
			}
		});
		return list;
	}
	
	@Override
	public List<Course> getClassicCourse(final Boolean isInner,final String type, final Integer start,
			final Integer rows) {
		List<Course> list = new ArrayList<Course>();
		list = getHibernateTemplate().executeFind(new HibernateCallback() {

			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				int i = 0;
				StringBuffer hql = new StringBuffer(
						"select new com.nb.nbpx.pojo.course.Course(c.courseId, c.title,"
								+ "c.teacherId, '', c.category,"
								+ "'',c.state,c.hits,c.price,c.recommanded,c.classic) from Course c ,CourseInfo b where c.courseId = b.courseId and 1=1 ");
				if (type != null && !"".equals(type))
					hql.append(" and c.category = '" + type + "'");
				if (isInner != null) {// 区分内训和培训
					if (isInner)
						hql.append(" and c.isInner = 1");
					else
						hql.append(" and c.isInner = 0");
				}

				hql.append(" and c.classic = 1 ");
				hql.append(" and c.state = 1 ");
				// 取向后的有效的日期
				hql.append("and TO_DAYS(NOW())-TO_DAYS(b.startDate)<0 order by c.hits desc");
				Query query = session.createQuery(hql.toString());

				if (start != null && rows != null) {
					query.setFirstResult(start);
					query.setMaxResults(rows);
				}
				return query.list();
			}
		});
		return list;
	}
	//获取推荐的老师
	public List<TeacherInfo> getTeacherRecommand(final Boolean isInner,final String type,final Integer start,final Integer rows){
		List<TeacherInfo> list = new ArrayList<TeacherInfo>();
		list = getHibernateTemplate().executeFind(new HibernateCallback() {

			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				int i = 0;
				StringBuffer hql = new StringBuffer(
						"select distinct t.*  from courses c,courseinfo b,teacher_info t where t.teacherId = c.teacherId ");
				if (type != null && !"".equals(type))
					hql.append(" and c.category = '" + type + "'");
				if (isInner != null) {//区分内训和培训
					if (isInner)
						hql.append(" and c.isInner = 1");
					else
						hql.append(" and c.isInner = 0");
				}

				hql.append(" and c.state = 1 ");
				// 取向后的有效的日期
				hql.append(" and TO_DAYS(NOW())-TO_DAYS(b.startDate)<0 order by c.hits desc");
				Query query = session.createSQLQuery(hql.toString()).addEntity(TeacherInfo.class);

				if (start != null && rows != null) {
					query.setFirstResult(start);
					query.setMaxResults(rows);
				}
				return query.list();
			}
		});
		return list;
		
	}
	
	//根据年分和月份获取当月的培训计划
	public List<Course> getTrainPlanByMonth(final String year,final String month,final Integer start,final Integer rows){
		List<Course> list = new ArrayList<Course>();
		list = getHibernateTemplate().executeFind(new HibernateCallback() {

			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				int i = 0;
				StringBuffer hql = new StringBuffer(
						"select distinct c.*  from courses c,courseinfo b where c.courseid = b.courseid ");
				
				hql.append(" and c.state = 1 ");
				hql.append(" and year(b.startDate)='"+year+"' and   month(b.startDate) ='"+month+"'  ");
				
				// 取向后的有效的日期
				hql.append(" and TO_DAYS(NOW())-TO_DAYS(b.startDate)<0 order by b.startDate desc");
				System.out.println(hql.toString());
				Query query = session.createSQLQuery(hql.toString()).addEntity(Course.class);

				if (start != null && rows != null) {
					query.setFirstResult(start);
					query.setMaxResults(rows);
				}
				return query.list();
			}
		});
		return list;
	}
	
	//获得指定时间之后，有培训计划的月数总数
	public List<String> getTrainPlanMonth(final Integer start,final Integer rows){
		List<String> list = new ArrayList<String>();
		list = getHibernateTemplate().executeFind(new HibernateCallback() {

			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				int i = 0;
				StringBuffer hql = new StringBuffer(
						"select distinct concat(year(b.startdate),'-',month(b.startdate)) value from courses c,courseinfo b  where");
				
				hql.append(" c.state = 1 ");
				// 取向后的有效的日期
				hql.append(" and TO_DAYS(NOW())-TO_DAYS(b.startDate)<0");
				Query query = session.createSQLQuery(hql.toString()).addScalar("value",Hibernate.STRING).setResultTransformer(Transformers.ALIAS_TO_ENTITY_MAP);
				if (start != null && rows != null) {
					query.setFirstResult(start);
					query.setMaxResults(rows);
				}
				List temp = query.list();
				System.out.println(temp.size());
				List result = new ArrayList();
				for(Object tempMap : temp){
					result.add(((Map)tempMap).get("value"));
					System.out.println(((Map)tempMap).get("value"));
				}
				return result;
			}
		});
		return list;
	}

	@Override
	public List<Course> queryCoursesWithTitle(final String category, final String courseTitle,
			final Integer rows, final Integer start, final String sort, final String order, final Boolean isInner) {
		List<Course> list = new ArrayList<Course>();
		list = getHibernateTemplate().executeFind(new HibernateCallback() {

			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				int i = 0;
				StringBuffer hql = new StringBuffer(
						"select new com.nb.nbpx.pojo.course.Course"
								+ " (c.courseId, c.title,c.isInner, c.teacherId, "
								+ "ti.realName, c.category, fd.showName, c.lastUpdateDate, "
								+ " c.state, c.hits , c.price, c.recommanded, c.classic) from Course c, Dictionary fd, TeacherInfo ti"
								+ " where 1 = 1 ");
				if (category != null && !category.isEmpty()) {
					hql.append(" and category = ? ");
				}

				if (courseTitle != null) {
					hql.append(" and c.title like ? ");
				}
				hql.append(" and c.category = fd.codeName ");
				hql.append(" and ti.teacherId = c.teacherId");

				if (sort != null && !sort.isEmpty()) {
					if("teacherName".equals(sort)){
						hql.append(" order by c.teacherId");
					}else{
						hql.append(" order by c." + sort);
					}
					if (order != null && !order.isEmpty()) {
						hql.append(" " + order);
					}
				}else{
					hql.append(" order by c.lastUpdateDate desc ");
				}
				Query query = session.createQuery(hql.toString());

				if (category != null && !category.isEmpty()) {
					query.setString(i++, category);
				}

				if (courseTitle != null) {
					query.setString(i++, "%"+courseTitle+"%");
				}

				if (start != null && rows != null) {
					query.setFirstResult(start);
					query.setMaxResults(rows);
				}

				return query.list();
			}
		});
		return list;
	}

	@Override
	public Long queryCourseCount(final String category, final String courseTitle) {
		List list = new ArrayList();
		list = getHibernateTemplate().executeFind(new HibernateCallback() {

			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				int i = 0;
				StringBuffer hql = new StringBuffer(
						"select count(c) from Course c where 1 = 1");
				if (category != null && !category.isEmpty()) {
					hql.append(" and category = ? ");
				}

				if (courseTitle != null) {
					hql.append(" and title like ? ");
				}
				Query query = session.createQuery(hql.toString());

				if (category != null && !category.isEmpty()) {
					query.setString(i++, category);
				}

				if (courseTitle != null) {
					query.setString(i++, "%"+courseTitle+"%");
				}

				return query.list();
			}
		});
		return (Long) list.get(0);
	}
}
