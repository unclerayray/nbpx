package com.nb.nbpx.dao.impl;

import java.io.Serializable;
import java.lang.reflect.Field;
import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.sql.SQLException;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;
import javax.persistence.Id;

import org.apache.commons.beanutils.PropertyUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.LockMode;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Example;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.stereotype.Component;

import com.nb.nbpx.dao.IBaseDao;
import com.nb.nbpx.utils.MapUtil;

/**
 * <p>
 * 通用DAO接口的实现类
 * </p>
 * 创建时间：2013-4-9 22:28:54
 * 
 * @author leilichao
 * @version V1.0
 */
@Component("BaseDao")
@SuppressWarnings({ "rawtypes", "unchecked" })
public class BaseDaoImpl<T extends Serializable, PK extends Serializable>
		implements IBaseDao<T, PK> {
	// 实体类类型(由构造方法自动赋值)
	private Class<T> entityClass;
	private HibernateTemplate hibernateTemplate;
	public static Logger logger = LogManager.getLogger(BaseDaoImpl.class);

	public HibernateTemplate getHibernateTemplate() {
		return hibernateTemplate;
	}

	@Resource
	public void setHibernateTemplate(HibernateTemplate hibernateTemplate) {
		this.hibernateTemplate = hibernateTemplate;
	}

	// 构造方法，根据实例类自动获取实体类类型
	public BaseDaoImpl() {
		this.entityClass = null;
		Class c = getClass();
		Type t = c.getGenericSuperclass();
		if (t instanceof ParameterizedType) {
			Type[] p = ((ParameterizedType) t).getActualTypeArguments();
			this.entityClass = (Class<T>) p[0];
		}
	}

	// -------------------- 基本检索、增加、修改、删除操作 --------------------

	// 根据主键获取实体。如果没有相应的实体，返回 null。
	public T get(PK id) {
		return (T) getHibernateTemplate().get(entityClass, id);
	}

	// 根据主键获取实体并加锁。如果没有相应的实体，返回 null。
	public T getWithLock(PK id, LockMode lock) {
		T t = (T) getHibernateTemplate().get(entityClass, id, lock);
		if (t != null) {
			this.flush(); // 立即刷新，否则锁不会生效。
		}
		return t;
	}

	// 根据主键获取实体。如果没有相应的实体，抛出异常。
	public T load(PK id) {
		return (T) getHibernateTemplate().load(entityClass, id);
	}

	// 根据主键获取实体并加锁。如果没有相应的实体，抛出异常。
	public T loadWithLock(PK id, LockMode lock) {
		T t = (T) getHibernateTemplate().load(entityClass, id, lock);
		if (t != null) {
			this.flush(); // 立即刷新，否则锁不会生效。
		}
		return t;
	}

	// 获取全部实体。
	public List<T> loadAll() {
		return (List<T>) getHibernateTemplate().loadAll(entityClass);
	}

	// loadAllWithLock() ?

	// 更新实体
	public void update(T entity) {
		getHibernateTemplate().update(entity);
	}

	// 更新实体并加锁
	public void updateWithLock(T entity, LockMode lock) {
		getHibernateTemplate().update(entity, lock);
		this.flush(); // 立即刷新，否则锁不会生效。
	}

	// 存储实体到数据库
	public void save(T entity) {
		getHibernateTemplate().save(entity);
	}

	// saveWithLock()？

	// 增加或更新实体
	public void saveOrUpdate(T entity) {
		getHibernateTemplate().saveOrUpdate(entity);
	}

	// 增加或更新集合中的全部实体
	public void saveOrUpdateAll(Collection<T> entities) {
		getHibernateTemplate().saveOrUpdateAll(entities);
	}

	// 删除指定的实体
	public void delete(T entity) {
		getHibernateTemplate().delete(entity);
	}

	// 加锁并删除指定的实体
	public void deleteWithLock(T entity, LockMode lock) {
		getHibernateTemplate().delete(entity, lock);
		this.flush(); // 立即刷新，否则锁不会生效。
	}

	// 根据主键删除指定实体
	public void deleteByKey(PK id) {
		this.delete(this.load(id));
	}

	// 根据主键加锁并删除指定的实体
	public void deleteByKeyWithLock(PK id, LockMode lock) {
		this.deleteWithLock(this.load(id), lock);
	}

	// 删除集合中的全部实体
	public void deleteAll(Collection<T> entities) {
		getHibernateTemplate().deleteAll(entities);
	}

	// -------------------- HSQL ----------------------------------------------

	// 使用HSQL语句直接增加、更新、删除实体
	public int bulkUpdate(String queryString) {
		return getHibernateTemplate().bulkUpdate(queryString);
	}

	// 使用带参数的HSQL语句增加、更新、删除实体
	public int bulkUpdate(String queryString, Object[] values) {
		return getHibernateTemplate().bulkUpdate(queryString, values);
	}

	// 使用HSQL语句检索数据
	public List find(String queryString) {
		return getHibernateTemplate().find(queryString);
	}

	// 使用带参数的HSQL语句检索数据
	public List find(String queryString, Object[] values) {
		return getHibernateTemplate().find(queryString, values);
	}

	// 使用带命名的参数的HSQL语句检索数据
	public List findByNamedParam(String queryString, String[] paramNames,
			Object[] values) {
		return getHibernateTemplate().findByNamedParam(queryString, paramNames,
				values);
	}

	// 使用命名的HSQL语句检索数据
	public List findByNamedQuery(String queryName) {
		return getHibernateTemplate().findByNamedQuery(queryName);
	}

	// 使用带参数的命名HSQL语句检索数据
	public List findByNamedQuery(String queryName, Object[] values) {
		return getHibernateTemplate().findByNamedQuery(queryName, values);
	}

	// 使用带命名参数的命名HSQL语句检索数据
	public List findByNamedQueryAndNamedParam(String queryName,
			String[] paramNames, Object[] values) {
		return getHibernateTemplate().findByNamedQueryAndNamedParam(queryName,
				paramNames, values);
	}

	// 使用HSQL语句检索数据，返回 Iterator
	public Iterator iterate(String queryString) {
		return getHibernateTemplate().iterate(queryString);
	}

	// 使用带参数HSQL语句检索数据，返回 Iterator
	public Iterator iterate(String queryString, Object[] values) {
		return getHibernateTemplate().iterate(queryString, values);
	}

	// 关闭检索返回的 Iterator
	public void closeIterator(Iterator it) {
		getHibernateTemplate().closeIterator(it);
	}

	// -------------------------------- Criteria ------------------------------

	// 创建与会话无关的检索标准
	public DetachedCriteria createDetachedCriteria() {
		return DetachedCriteria.forClass(this.entityClass);
	}

	// 创建与会话绑定的检索标准
	public Criteria createCriteria() {
		return this.createDetachedCriteria().getExecutableCriteria(
				this.getHibernateTemplate().getSessionFactory()
						.getCurrentSession());
	}

	// 检索满足标准的数据
	public List findByCriteria(DetachedCriteria criteria) {
		return getHibernateTemplate().findByCriteria(criteria);
	}

	// 检索满足标准的数据，返回指定范围的记录
	public List findByCriteria(DetachedCriteria criteria, int firstResult,
			int maxResults) {
		return getHibernateTemplate().findByCriteria(criteria, firstResult,
				maxResults);
	}

	// 使用指定的实体及属性检索（满足除主键外属性＝实体值）数据

	public List<T> findEqualByEntity(T entity, String[] propertyNames) {
		Criteria criteria = this.createCriteria();
		Example exam = Example.create(entity);
		exam.excludeZeroes();
		String[] defPropertys = this.getHibernateTemplate().getSessionFactory()
				.getClassMetadata(entityClass).getPropertyNames();
		for (String defProperty : defPropertys) {
			int ii = 0;
			for (ii = 0; ii < propertyNames.length; ++ii) {
				if (defProperty.equals(propertyNames[ii])) {
					criteria.addOrder(Order.asc(defProperty));
					break;
				}
			}
			if (ii == propertyNames.length) {
				exam.excludeProperty(defProperty);
			}
		}
		criteria.add(exam);
		return (List<T>) criteria.list();
	}

	// 使用指定的实体及属性检索（满足属性 like 串实体值）数据
	public List<T> findLikeByEntity(T entity, String[] propertyNames) {
		Criteria criteria = this.createCriteria();
		for (String property : propertyNames) {
			try {
				Object value = PropertyUtils.getProperty(entity, property);
				if (value instanceof String) {
					criteria.add(Restrictions.like(property, (String) value,
							MatchMode.ANYWHERE));
					criteria.addOrder(Order.asc(property));
				} else {
					criteria.add(Restrictions.eq(property, value));
					criteria.addOrder(Order.asc(property));
				}
			} catch (Exception ex) {
				// 忽略无效的检索参考数据。
			}
		}
		return (List<T>) criteria.list();
	}

	// 使用指定的检索标准获取满足标准的记录数
	public Integer getRowCount(DetachedCriteria criteria) {
		criteria.setProjection(Projections.rowCount());
		List list = this.findByCriteria(criteria, 0, 1);
		return (Integer) list.get(0);
	}

	// 使用指定的检索标准检索数据，返回指定统计值(max,min,avg,sum)
	public Object getStatValue(DetachedCriteria criteria, String propertyName,
			String StatName) {
		if (StatName.toLowerCase().equals("max"))
			criteria.setProjection(Projections.max(propertyName));
		else if (StatName.toLowerCase().equals("min"))
			criteria.setProjection(Projections.min(propertyName));
		else if (StatName.toLowerCase().equals("avg"))
			criteria.setProjection(Projections.avg(propertyName));
		else if (StatName.toLowerCase().equals("sum"))
			criteria.setProjection(Projections.sum(propertyName));
		else
			return null;
		List list = this.findByCriteria(criteria, 0, 1);
		return list.get(0);
	}

	// -------------------------------- Others --------------------------------

	// 加锁指定的实体
	public void lock(T entity, LockMode lock) {
		getHibernateTemplate().lock(entity, lock);
	}

	// 强制初始化指定的实体
	public void initialize(Object proxy) {
		getHibernateTemplate().initialize(proxy);
	}

	// 强制立即更新缓冲数据到数据库（否则仅在事务提交时才更新）
	public void flush() {
		getHibernateTemplate().flush();
	}

	// 立即清除session中缓存
	public void clear() {
		getHibernateTemplate().clear();
	}

	// 根据搜索条件查询实体List
	public List queryEntityListByConditions(final String hql,
			final Integer rows, final Integer start,
			final Object... conditions) {
		List list = this.getHibernateTemplate().executeFind(
				new HibernateCallback() {
					@Override
					public Object doInHibernate(Session session)
							throws HibernateException, SQLException {
						Query query = session.createQuery(hql);
						for (int i = 0; i < conditions.length; i++) {
							query.setParameter(i, conditions[i]);
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
	

	// 根据搜索条件查询实体List
	public List queryEntityListByConditionsAndLike(final String hql,
			final Integer rows, final Integer start, final Object[] likeConditions,
			final Object... conditions) {
		List list = this.getHibernateTemplate().executeFind(
				new HibernateCallback() {
					@Override
					public Object doInHibernate(Session session)
							throws HibernateException, SQLException {
						Query query = session.createQuery(hql);
						int i = 0;
						for (; i < conditions.length; i++) {
							query.setParameter(i, conditions[i]);
						}
						for (; i < likeConditions.length+conditions.length; i++) {
							query.setString(i, "%"+likeConditions[i-conditions.length].toString().trim()+"%");
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

	// 根据id值删除指定实体
	public void deleteEntityById(final String entityName, final int id) {
		this.getHibernateTemplate().execute(new HibernateCallback<T>() {

			@Override
			public T doInHibernate(Session session) throws HibernateException,
					SQLException {
				Query query = session.createQuery("delete from " + entityName
						+ " as o where o.=?");
				query.setParameter(0, id);
				query.executeUpdate();
				return null;
			}
		});
	}

	// 根据id值删除指定实体
	public void deleteEntityById(final String entityName, final String idName,
			final int id) {
		this.getHibernateTemplate().execute(new HibernateCallback<T>() {

			@Override
			public T doInHibernate(Session session) throws HibernateException,
					SQLException {
				Query query = session.createQuery("delete from " + entityName
						+ " as o where o." + idName + "=?");
				query.setParameter(0, id);
				query.executeUpdate();
				return null;
			}
		});
	}

	// 根据id查询实体
	@Override
	public T getById(Class<T> entityClass, int id) {
		return this.getHibernateTemplate().get(entityClass, id);
	}

	// 根据装载实体属性的Map查询实体列表
	@Override
	public List<T> queryEntityListByProperties(Class<T> entityClass,
			Integer rows, Integer start, String sort, String order,
			Map<String, Object> propertyMap) {
		Map<String, Object> propsMap = MapUtil.removeNullValue(propertyMap);
		String hql = createHqlFromProtitiesMapWithOrder(entityClass, propsMap,
				sort, order);
		Object[] conditions = propsMap.values().toArray();
		List<T> entityList = queryEntityListByConditions(hql, rows, start,
				conditions);
		return entityList;
	}

	// 根据装载实体属性的Map查询实体
	@Override
	public T queryEntityByProperties(Class<T> entityClass,
			Map<String, Object> propertyMap) {
		List<T> entityList = null;
		Map<String, Object> propsMap = MapUtil.removeNullValue(propertyMap);
		String hql = createHqlFromProtitiesMap(entityClass, propsMap);
		Object[] conditions = propsMap.values().toArray();
		entityList = this.find(hql, conditions);
		if (entityList.size() > 0) {
			return entityList.get(0);
		} else {
			return null;
		}
	}


	// 根据属性Map查询实体总数
	public Long queryTotalCount(Class<T> entityClass,
			Map<String, Object> propertyMap) {
		Map<String, Object> propsMap = MapUtil.removeNullValue(propertyMap);
		StringBuilder hqlBuilder = new StringBuilder("select count(o) ");
		hqlBuilder.append(createHqlFromProtitiesMap(entityClass, propsMap));
		String hql = hqlBuilder.toString();
		Object[] conditions = propsMap.values().toArray();
		List<Long> totalCounterList = this.find(hql, conditions);
		return (Long) totalCounterList.get(0);
	}
	
	// 根据属性Map查询实体总数
	public Long queryLikeTotalCount(Class<T> entityClass,
			Map<String, Object> propertyMap,
			Map<String, Object> likeMap) {
		Map<String, Object> propsMap = MapUtil.removeNullValue(propertyMap);
		StringBuilder hqlBuilder = new StringBuilder("select count(o) ");
		hqlBuilder.append(createHqlFromProtsAndLikeMap(entityClass, propsMap,likeMap));
		final String hql = hqlBuilder.toString();
		final Object[] conditions = propsMap.values().toArray();
		final Object[] likeConditions = likeMap.values().toArray();
		List<Long> totalCounterList = this.getHibernateTemplate().executeFind(
				new HibernateCallback() {
					@Override
					public Object doInHibernate(Session session)
							throws HibernateException, SQLException {
						Query query = session.createQuery(hql);
						int i = 0;
						for (; i < conditions.length; i++) {
							query.setParameter(i, conditions[i]);
						}
						for (; i < likeConditions.length+conditions.length; i++) {
							query.setString(i, "%"+likeConditions[i-conditions.length]+"%");
						}
						return query.list();
					}
				});
		return (Long) totalCounterList.get(0);
	}

	// 根据属性Map更新实体
	@Override
	public int updateWithPK(Class<T> entityClass,Integer id,
			Map<String, Object> propertyMap) throws Exception {
		Map<String, Object> propsMap = MapUtil.removeNullValue(propertyMap);
		String hql = createHqlForUpdate(entityClass, id,
				propsMap);
		Object[] conditions = propsMap.values().toArray();
		return this.bulkUpdate(hql, conditions);
	}
	
	private String getPrimeryKeyFieldName(Class entityClass) throws Exception {
		String primeryKeyFieldName = null;
		Field[] fields = entityClass.getDeclaredFields();
		for (Field field : fields) {
			Id anno = field.getAnnotation(Id.class);
			if (anno != null) {
				primeryKeyFieldName = field.getName();
				break;
			}
		}
		if (primeryKeyFieldName == null) {
			throw new Exception("No primary key defined in class "
					+ entityClass.getName());
		}
		return primeryKeyFieldName;
	}

	private String createHqlForUpdate(Class entityClass, Integer id,
			Map<String, Object> propsMap) throws Exception {
		StringBuilder hqlBuilder = new StringBuilder("update ");
		String entityName = entityClass.getSimpleName();
		hqlBuilder.append(entityName);
		hqlBuilder.append(" o set ");
		Set<String> propsKeies = propsMap.keySet();
		Object[] propsArray = propsKeies.toArray();
		if (!propsMap.isEmpty()) {
			for (int i = 0; i < propsArray.length; i++) {
				if (i != 0) {
					hqlBuilder.append(" and ");
				}
				String props = propsArray[i].toString();
				String realProps = null;
				if (props.contains(".")) {
					String fun = props.substring(0, props.indexOf('.'));
					realProps = " " + fun + "(o."
							+ props.substring(props.indexOf('.') + 1) + ")";
				} else {
					realProps = " o." + props;
				}
				hqlBuilder.append(realProps);
				hqlBuilder.append("=?");
			}
		}
		hqlBuilder.append(" where " + getPrimeryKeyFieldName(entityClass)
				+ " = " + id);
		String hql = hqlBuilder.toString();
		return hql;
	}

	// 构造hql查询语句
	private String createHqlFromProtitiesMap(Class entityClass,
			Map<String, Object> propsMap) {
		StringBuilder hqlBuilder = new StringBuilder("from ");
		String entityName = entityClass.getSimpleName();
		hqlBuilder.append(entityName);
		hqlBuilder.append(" as o where 1=1 ");
		Set<String> propsKeies = propsMap.keySet();
		Object[] propsArray = propsKeies.toArray();
		if (!propsMap.isEmpty()) {
			for (int i = 0; i < propsArray.length; i++) {
				hqlBuilder.append(" and");
				String props = propsArray[i].toString();
				String realProps = null;
				if (props.contains(".")) {
					String fun = props.substring(0, props.indexOf('.'));
					realProps = " " + fun + "(o."
							+ props.substring(props.indexOf('.') + 1) + ")";
				} else {
					realProps = " o." + props;
				}
				hqlBuilder.append(realProps);
				hqlBuilder.append("=?");
			}
		}
		String hql = hqlBuilder.toString();
		return hql;
	}
	

	// 构造hql查询语句
	private String createHqlFromProtsAndLikeMap(Class entityClass,
			Map<String, Object> propsMap,Map<String, Object> likeMap) {
		StringBuilder hqlBuilder = new StringBuilder("from ");
		String entityName = entityClass.getSimpleName();
		hqlBuilder.append(entityName);
		hqlBuilder.append(" as o where 1=1 ");
		Set<String> propsKeies = propsMap.keySet();
		Object[] propsArray = propsKeies.toArray();
		if (!propsMap.isEmpty()) {
			for (int i = 0; i < propsArray.length; i++) {
				hqlBuilder.append(" and");
				String props = propsArray[i].toString();
				String realProps = null;
				if (props.contains(".")) {
					String fun = props.substring(0, props.indexOf('.'));
					realProps = " " + fun + "(o."
							+ props.substring(props.indexOf('.') + 1) + ")";
				} else {
					realProps = " o." + props;
				}
				hqlBuilder.append(realProps);
				hqlBuilder.append("=?");
			}
		}
		
		Set<String> likeKeies = likeMap.keySet();
		Object[] likeArray = likeKeies.toArray();
		if (!propsMap.isEmpty()) {
			for (int i = 0; i < likeArray.length; i++) {
				hqlBuilder.append(" and");
				String props = likeArray[i].toString();
				String realProps = null;
				if (props.contains(".")) {
					String fun = props.substring(0, props.indexOf('.'));
					realProps = " " + fun + "(o."
							+ props.substring(props.indexOf('.') + 1) + ")";
				} else {
					realProps = " o." + props;
				}
				hqlBuilder.append(realProps);
				hqlBuilder.append(" like ?");
			}
		}
		String hql = hqlBuilder.toString();
		return hql;
	}
	

	// 构造hql查询语句
	public String createNormalHql(Class entityClass,
			Map<String, Object> propsMap) {
		StringBuilder hqlBuilder = new StringBuilder("");
		Set<String> propsKeies = propsMap.keySet();
		Object[] propsArray = propsKeies.toArray();
		if (!propsMap.isEmpty()) {
			for (int i = 0; i < propsArray.length; i++) {
				hqlBuilder.append(" and");
				String props = propsArray[i].toString();
				String realProps = null;
				if (props.contains(".")) {
					String fun = props.substring(0, props.indexOf('.'));
					realProps = " " + fun + "("
							+ props.substring(props.indexOf('.') + 1) + ")";
				} else {
					realProps = " " + props;
				}
				hqlBuilder.append(realProps);
				hqlBuilder.append("='"+propsMap.get(props)+"'");
			}
		}
		String hql = hqlBuilder.toString();
		return hql;
	}

	private String createHqlFromProtitiesMapWithOrder(Class entityClass,
			Map<String, Object> propsMap, String sort, String order) {
		String hql = createHqlFromProtitiesMap(entityClass, propsMap);
		if (sort != null && !sort.isEmpty()) {
			hql += " order by o." + sort;
			if (order != null && !order.isEmpty()) {
				hql += " " + order;
			}
		}
		return hql;
	}
	

	private String createHqlFromProtitiesMapWithOrderAndLike(Class entityClass,
			Map<String, Object> propsMap, String sort, String order, Map<String, Object> likeMap) {
		String hql = createHqlFromProtsAndLikeMap(entityClass, propsMap, likeMap);
		if (sort != null && !sort.isEmpty()) {
			hql += " order by o." + sort;
			if (order != null && !order.isEmpty()) {
				hql += " " + order;
			}
		}
		return hql;
	}

	@Override
	public List<T> queryListByPropAndLike(Class<T> entityClass, Integer rows,
			Integer start, String sort, String order,
			Map<String, Object> propMap, Map<String, Object> likeMap) {
		Map<String, Object> propsMap = MapUtil.removeNullValue(propMap);
		String hql = createHqlFromProtitiesMapWithOrderAndLike(entityClass, propsMap,
				sort, order, likeMap);
		Object[] conditions = propsMap.values().toArray();
		Object[] likeArray = likeMap.values().toArray();
		List<T> entityList = queryEntityListByConditionsAndLike(hql, rows, start,likeArray,
				conditions);
		return entityList;
	}

	@Override
	public <T> T merge(T entity) {
		return getHibernateTemplate().merge(entity);
	}
}
