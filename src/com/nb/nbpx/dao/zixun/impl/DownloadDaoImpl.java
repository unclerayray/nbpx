package com.nb.nbpx.dao.zixun.impl;

import org.springframework.stereotype.Component;

import com.nb.nbpx.dao.impl.BaseDaoImpl;
import com.nb.nbpx.dao.zixun.IDownloadDao;
import com.nb.nbpx.pojo.zixun.Download;

@Component("DownloadDao")
public class DownloadDaoImpl extends BaseDaoImpl<Download, Integer> implements
		IDownloadDao {

}
