package com.nb.nbpx.service.impl;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Component;

import com.nb.nbpx.common.QueryCriteria;
import com.nb.nbpx.service.IBaseService;
import com.nb.nbpx.utils.daotool.Equality;
import com.nb.nbpx.utils.daotool.NotEmptyEquality;

/**
 * <p>
 * 类的简介说明
 * </p>
 * 创建时间：2013-4-10 9:46:51
 * 
 * @author leilichao
 * @version V1.0
 */
@Component("BaseService")
public abstract class BaseServiceImpl implements IBaseService {
    
	@Override
    public Map<String, Object> createPropMap(Equality... equs){
    	Map<String, Object> map = new HashMap<String, Object>();
    	for(Equality equ:equs){
			if(equ.propValue!=null){
				if(!(equ instanceof NotEmptyEquality)){
					map.put(equ.getPropName(), equ.getPropValue());
				}else{
					if(!equ.propValue.toString().isEmpty()){
						map.put(equ.getPropName(), equ.getPropValue());
					}
				}
			}
		}
    	return map;
    }
	
	@Override
	public String queryWithCriteria(QueryCriteria qc) {
		return null;
	}
}
