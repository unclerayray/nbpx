package com.nb.nbpx.service;

import java.util.Map;

import com.nb.nbpx.common.QueryCriteria;
import com.nb.nbpx.utils.daotool.Equality;

/**
 * <p>
 * 类的简介说明
 * </p>
 * 创建时间：2013-4-10 9:49:31
 * 
 * @author leilichao
 * @version V1.0
 */
public interface IBaseService {
	Map<String, Object> createPropMap(Equality... equs);
	
	//public Object getEntityByPK(Integer Id, Class s);
	public String queryWithCriteria(QueryCriteria qc);
}
