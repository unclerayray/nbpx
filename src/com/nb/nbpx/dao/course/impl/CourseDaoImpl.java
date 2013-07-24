package com.nb.nbpx.dao.course.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
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
			final String courseCode, final Integer rows, final Integer start) {
		List<Course> list = new ArrayList<Course>();
		list = getHibernateTemplate().executeFind(new HibernateCallback() {

			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				int i = 0;
				StringBuffer hql = new StringBuffer(
						"select new com.nb.nbpx.pojo.course.Course"
								+ " (c.courseId, c.title,c.isInner, c.courseCode, c.teacherId, "
								+ "ti.realName, c.category, fd.showName,"
								+ " c.state, c.hits , c.price, c.recommanded, c.classic) from Course c, Dictionary fd, TeacherInfo ti"
								+ " where 1 = 1 ");
				if (category != null && !category.isEmpty()) {
					hql.append(" and category = ? ");
				}

				if (courseCode != null && !courseCode.isEmpty()) {
					hql.append(" and courseCode = ? ");
				}
				hql.append(" and c.category = fd.codeName ");
				hql.append(" and ti.teacherId = c.teacherId");
				Query query = session.createQuery(hql.toString());

				if (category != null && !category.isEmpty()) {
					query.setString(i++, category);
				}

				if (courseCode != null && !courseCode.isEmpty()) {
					query.setString(i++, courseCode);
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
	public Long queryCourseCount(final String category, final String courseCode) {
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

				if (courseCode != null && !courseCode.isEmpty()) {
					hql.append(" and courseCode = ? ");
				}
				Query query = session.createQuery(hql.toString());

				if (category != null && !category.isEmpty()) {
					query.setString(i++, category);
				}

				if (courseCode != null && !courseCode.isEmpty()) {
					query.setString(i++, courseCode);
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
				hql.append(" and courseCode = '" + course.getCourseCode()
						+ "' ");
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

	public List<Course> getHotCourse(final Boolean ifInner, final String type,
			final Integer rows, final Integer start) {
		List<Course> list = new ArrayList<Course>();
		list = getHibernateTemplate().executeFind(new HibernateCallback() {

			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				int i = 0;
				StringBuffer hql = new StringBuffer(
						"select new com.nb.nbpx.pojo.course.Course(c.courseId, c.title,c.courseCode,"
								+ "c.teacherId, '', c.category,"
								+ "'',c.state,c.hits,c.price,c.recommanded,c.classic) from Course c where 1=1 ");
				if (type != null && !"".equals(type))
					hql.append(" and c.category = '" + type + "'");
				if (ifInner != null) {// 区分内训和培训
					if (ifInner)
						hql.append(" and c.isInner = 1");
					else
						hql.append(" and c.isInner = 0");
				}
				// 取向后的有效的日期
				hql.append(" and c.courseId in (select b.courseId from CourseInfo b where TO_DAYS(NOW())-TO_DAYS(b.startDate)<0) order by c.hits desc");
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
						"select new com.nb.nbpx.pojo.course.Course(c.courseId, c.title,c.courseCode,"
								+ "c.teacherId, '', c.category,"
								+ "'',c.state,c.hits,c.price,c.recommanded,c.classic) from Course c,CourseInfo b where c.courseId = b.courseId and 1=1 ");
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
				hql.append("and TO_DAYS(NOW())-TO_DAYS(b.startDate)<0 order by b.startDate desc");
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
						"select new com.nb.nbpx.pojo.course.Course(c.courseId, c.title,c.courseCode,"
								+ "c.teacherId, '', c.category,"
								+ "'',c.state,c.hits,c.price,c.recommanded,c.classic) from Course c where c.courseId in (select b.courseId from CourseInfo b where b.city = (select d.codeName from Dictionary d where d.showName='"
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

	@Override
	public void deleteAllOtherInfosCourse(Integer courseId) {
		String sql1 = "delete from courseinfo where courseId =" + courseId;
		String sql2 = "delete from coursekeywords where courseId =" + courseId;
		String sql3 = "delete from coursemajor where courseId =" + courseId;
		String sql4 = "delete from coursetarget where courseId =" + courseId;
		String sql5 = "delete from courseindustry where courseId =" + courseId;
		String[] sqlArr = { sql1, sql2, sql3, sql4, sql5 };
		jdbcTemplate.batchUpdate(sqlArr);
	}

	@Override
	public void addAllCourseInfo(CourseAllInfoDto courseDto) {
		Integer courseId = courseDto.getCourseId();
		List<String> list = new ArrayList<String>();
		String[] courseKeywords = courseDto.getKeywords().split(",");
		String[] courseMajors = courseDto.getMajor().split(",");
		String[] courseTargets = courseDto.getTargets().split(",");
		String[] courseIndustry = courseDto.getIndustry().split(",");
		for (String str : courseKeywords) {
			StringBuffer sql = new StringBuffer(
					"insert into coursekeywords (courseId,keyword) values ");
			// 在这里保存keyword实体
			sql.append("(").append(courseId).append(",'").append(str)
					.append("');");
			list.add(sql.toString());
		}

		for (String str : courseMajors) {
			StringBuffer sql = new StringBuffer(
					"insert into coursemajor (courseId,major) values ");
			sql.append("(").append(courseId).append(",'").append(str)
					.append("');");
			list.add(sql.toString());
		}

		for (String str : courseTargets) {
			StringBuffer sql = new StringBuffer(
					"insert into coursetargets (courseId,target) values ");
			sql.append("(").append(courseId).append(",'").append(str)
					.append("');");
			list.add(sql.toString());
		}

		for (String str : courseIndustry) {
			StringBuffer sql = new StringBuffer(
					"insert into courseIndustry (courseId,industry) values ");
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
			Map<String, String> majorMap, Map<Integer, String> keywordMap) {
		List<String> list = new ArrayList<String>();
		Iterator industryIter = industryMap.entrySet().iterator();
		Iterator tagetIter = tagetMap.entrySet().iterator();
		Iterator majorIter = majorMap.entrySet().iterator();
		Iterator keywordIter = keywordMap.entrySet().iterator();
		while (industryIter.hasNext()) {
			Map.Entry entry = (Map.Entry) industryIter.next();
			String code = entry.getKey().toString();
			String value = entry.getValue().toString();
			StringBuffer sql = new StringBuffer(
					"insert into courseIndustry (courseId,industry,industryCode) values ");
			sql.append("(").append(courseId).append(",'").append(value)
					.append("','").append(code).append("');");
			list.add(sql.toString());
		}

		while (tagetIter.hasNext()) {
			Map.Entry entry = (Map.Entry) tagetIter.next();
			String code = entry.getKey().toString();
			String value = entry.getValue().toString();
			StringBuffer sql = new StringBuffer(
					"insert into courseTarget (courseId,target,targetCode) values ");
			sql.append("(").append(courseId).append(",'").append(value)
					.append("','").append(code).append("');");
			list.add(sql.toString());
		}

		while (majorIter.hasNext()) {
			Map.Entry entry = (Map.Entry) majorIter.next();
			String code = entry.getKey().toString();
			String value = entry.getValue().toString();
			StringBuffer sql = new StringBuffer(
					"insert into courseMajor (courseId,major,majorCode) values ");
			sql.append("(").append(courseId).append(",'").append(value)
					.append("','").append(code).append("');");
			list.add(sql.toString());
		}
		
		while (keywordIter.hasNext()) {
			Map.Entry entry = (Map.Entry) keywordIter.next();
			Integer wordId = (Integer)(entry.getKey());
			String value = entry.getValue().toString();
			StringBuffer sql = new StringBuffer(
					"insert into courseKeywords (courseId,keyword,keywordId) values ");
			sql.append("(").append(courseId).append(",'").append(value)
					.append("','").append(wordId).append("');");
			list.add(sql.toString());
		}
		
		String[] sqlArr = list.toArray(new String[list.size()]);
		jdbcTemplate.batchUpdate(sqlArr);
	}

	@Override
	public Course updateCourse(Course course) {
		String sql = "update Course SET title = ?,courseCode = ?,teacherId = ?  ,category = ?  ,isInner = ?  ,price = ?  ,content = ?  ,"
				+ "blockedContent = ?  ,videoUrl = ? ,lastUpdateDate = ?  ,"
				+ "recommanded = ? ,state = ? ,classic = ? WHERE courseId = ?";
		Object[] values = {course.getTitle(),course.getCourseCode(),course.getTeacherId(),course.getCategory(),course.getIsInner(),course.getPrice(),course.getContent(),
				course.getBlockedContent(),course.getVideoUrl(),course.getLastUpdateDate(),course.getRecommanded(),course.getState(),course.getClassic(),course.getCourseId()};
		getHibernateTemplate().bulkUpdate(sql, values);
		return null;
	}
}
