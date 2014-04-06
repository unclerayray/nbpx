package com.nb.nbpx.service.impl;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Component;

import com.nb.nbpx.dao.IBaseDao;
import com.nb.nbpx.dao.user.impl.CompInfoDaoImpl;
import com.nb.nbpx.service.IBaseService;
import com.nb.nbpx.utils.daotool.Equality;

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
public class BaseServiceImpl implements IBaseService {
    
	@Override
    public Map<String, Object> createPropMap(Equality... equs){
    	Map<String, Object> map = new HashMap<String, Object>();
    	for(Equality equ:equs){
			if(equ.propValue!=null){
				map.put(equ.getPropName(), equ.getPropValue());
			}
		}
    	return map;
    }
}
