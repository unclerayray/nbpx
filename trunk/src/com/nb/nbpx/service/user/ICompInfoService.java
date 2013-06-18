package com.nb.nbpx.service.user;

import com.nb.nbpx.service.IBaseService;
import com.nb.nbpx.pojo.user.CompInfo;

public interface ICompInfoService extends IBaseService{

	public String getCompInfoByUserId(Integer userID);
	public String saveCompInfor(CompInfo compInfor);
}
