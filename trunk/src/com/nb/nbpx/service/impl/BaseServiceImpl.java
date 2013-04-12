package com.nb.nbpx.service.impl;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Component;

import com.nb.nbpx.service.IBaseService;

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
    public static Logger logger = LogManager.getLogger(BaseServiceImpl.class);

}
