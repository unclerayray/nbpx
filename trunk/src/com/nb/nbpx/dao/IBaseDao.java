package com.nb.nbpx.dao;

import java.io.Serializable;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.hibernate.Criteria;
import org.hibernate.LockMode;
import org.hibernate.criterion.DetachedCriteria;

/**
 * <p>
 * 通用DAO的接口
 * </p>
 * 创建时间：2013-3-23 上午11:00:03
 * 
 * @author leilichao
 * @version V1.0
 */
public interface IBaseDao<T extends Serializable, PK extends Serializable> {
    // -------------------- 基本检索、增加、修改、删除操作 --------------------

    /**
     * 根据主键获取实体。如果没有相应的实体，返回 null。
     */
    public T get(PK id);

    /**
     * 根据主键获取实体并加锁。如果没有相应的实体，返回 null。
     * 
     */
    public T getWithLock(PK id, LockMode lock);

    /**
     * 根据主键获取实体。如果没有相应的实体，抛出异常。
     * 
     */
    public T load(PK id);

    /**
     * 根据主键获取实体并加锁。如果没有相应的实体，抛出异常。
     * 
     */
    public T loadWithLock(PK id, LockMode lock);

    /**
     * 获取全部实体。
     * 
     */
    public List<T> loadAll();

    /**
     * 更新实体
     * 
     */
    public void update(T entity);

    /**
     * 更新实体并加锁
     * 
     */
    public void updateWithLock(T entity, LockMode lock);

    /**
     * 存储实体到数据库
     * 
     */
    public void save(T entity);

    /**
     * 增加或更新实体
     * 
     */
    public void saveOrUpdate(T entity);

    /**
     * 增加或更新集合中的全部实体
     * 
     */
    public void saveOrUpdateAll(Collection<T> entities);

    /**
     * 删除指定的实体
     * 
     */
    public void delete(T entity);

    /**
     * 加锁并删除指定的实体
     * 
     */
    public void deleteWithLock(T entity, LockMode lock);

    /**
     * 根据主键删除指定实体
     * 
     */
    public void deleteByKey(PK id);

    /**
     * 根据主键加锁并删除指定的实体
     * 
     */
    public void deleteByKeyWithLock(PK id, LockMode lock);

    /**
     * 删除集合中的全部实体
     * 
     */
    public void deleteAll(Collection<T> entities);

    // -------------------- HSQL ----------------------------------------------

    /**
     * 使用HSQL语句直接增加、更新、删除实体
     * 
     */
    public int bulkUpdate(String queryString);

    /**
     * 使用带参数的HSQL语句增加、更新、删除实体
     * 
     */
    public int bulkUpdate(String queryString, Object[] values);

    /**
     * 使用HSQL语句检索数据
     * 
     */
    public List find(String queryString);

    /**
     * 使用带参数的HSQL语句检索数据
     * 
     */
    public List find(String queryString, Object[] values);

    /**
     * 使用带命名的参数的HSQL语句检索数据
     * 
     */
    public List findByNamedParam(String queryString, String[] paramNames,
            Object[] values);

    /**
     * 使用命名的HSQL语句检索数据
     * 
     */
    public List findByNamedQuery(String queryName);

    /**
     * 使用带参数的命名HSQL语句检索数据
     * 
     */
    public List findByNamedQuery(String queryName, Object[] values);

    /**
     * 使用带命名参数的命名HSQL语句检索数据
     * 
     */
    public List findByNamedQueryAndNamedParam(String queryName,
            String[] paramNames, Object[] values);

    /**
     * 使用HSQL语句检索数据，返回 Iterator
     * 
     */
    public Iterator iterate(String queryString);

    /**
     * 使用带参数HSQL语句检索数据，返回 Iterator
     * 
     */
    public Iterator iterate(String queryString, Object[] values);

    /**
     * 关闭检索返回的 Iterator
     * 
     */
    public void closeIterator(Iterator it);

    // -------------------------------- Criteria ------------------------------

    /**
     * 创建与会话无关的检索标准对象
     * 
     */
    public DetachedCriteria createDetachedCriteria();

    /**
     * 创建与会话绑定的检索标准对象
     * 
     */
    public Criteria createCriteria();

    /**
     * 使用指定的检索标准检索数据
     * 
     */
    public List findByCriteria(DetachedCriteria criteria);

    /**
     * 使用指定的检索标准检索数据，返回部分记录
     * 
     */
    public List findByCriteria(DetachedCriteria criteria, int firstResult,
            int maxResults);

    /**
     * 使用指定的实体及属性检索（满足除主键外属性＝实体值）数据
     * 
     */
    public List<T> findEqualByEntity(T entity, String[] propertyNames);

    /**
     * 使用指定的实体及属性(非主键)检索（满足属性 like 串实体值）数据
     * 
     */
    public List<T> findLikeByEntity(T entity, String[] propertyNames);

    /**
     * 使用指定的检索标准检索数据，返回指定范围的记录
     * 
     */
    public Integer getRowCount(DetachedCriteria criteria);

    /**
     * 使用指定的检索标准检索数据，返回指定统计值
     * 
     */
    public Object getStatValue(DetachedCriteria criteria, String propertyName,
            String StatName);

    // -------------------------------- Others --------------------------------

    /**
     * 加锁指定的实体
     * 
     */
    public void lock(T entity, LockMode lockMode);

    /**
     * 强制初始化指定的实体
     * 
     */
    public void initialize(Object proxy);

    /**
     * 强制立即更新缓冲数据到数据库（否则仅在事务提交时才更新）
     * 
     */
    public void flush();
    
    /**
     * 立即清除session中缓存
     */
    public void clear();
    
    /**
     * 根据id删除指定实体
     * @param entityName 实体名称
     * @param id 实体ID标志
     */
    public void deleteEntityById(String entityName, int id);
    
    /**
     * 根据id删除指定实体
     * @param entityName 实体名称
     * @param idName 对应表的ID名称
     * @param id 实体ID标志
     */
    public void deleteEntityById(String entityName, String idName, int id);
    
    /**
     * 根据id获取实体
     * @param <T>
     * @param entityClass
     * @param id
     * @return
     */
    public T getById(Class<T> entityClass, int id);
    
    /**
	 * 根据实体类及其属性查询实体对象列表
	 * 
	 * @param entityClass
	 *            实体对象
	 * @param limit
	 *            页面最大显示长度
	 * @param start
	 *            查询其实位置
	 * @param propsMap
	 *            实体属性Map
	 *            <p>
	 *            eg：MaterialApply实体<br />
	 *            propsMap则可以用其属性<b>baseNumber</b>作为Key值<br />
	 *            propsMap.put("baseNumber","64001");
	 *            </p>
	 * @return
	 */
	public List<T> queryEntityListByProperties(Class<T> entityClass, Integer limit,
			Integer start, Map<String, Object> propsMap);

	/**
	 * 根据实体对象及其属性查询实体总数
	 * 
	 * @param entityClass
	 *            实体对象
	 * @param propsMap
	 *            实体属性Map
	 *            <p>
	 *            eg：MaterialApply实体<br />
	 *            propsMap则可以用其属性<b>baseNumber</b>作为Key值<br />
	 *            propsMap.put("baseNumber","64001");
	 *            </p>
	 * @return
	 */
	public Long queryTotalCount(Class<T> entityClass, Map<String, Object> propertyMap);
	
	
	/**
	 * 根据实体对象及其属性查询实体
	 * 
	 * @param entityClass
	 *            实体对象
	 * @param limit
	 *            页面最大显示长度
	 * @param start
	 *            查询其实位置
	 * @param propsMap
	 *            实体属性Map
	 *            <p>
	 *            eg：MaterialApply实体<br />
	 *            propsMap则可以用其属性<b>baseNumber</b>作为Key值<br />
	 *            propsMap.put("baseNumber","64001");
	 *            </p>
	 * @return
	 */
	public T queryEntityByProperties(Class<T> entityClass,
			Map<String, Object> propsMap);
}
