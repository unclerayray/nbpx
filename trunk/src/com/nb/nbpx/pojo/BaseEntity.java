package com.nb.nbpx.pojo;

import javax.persistence.Transient;

/**
 * <p>
 * POJO的基类,主要封装一些额外的信息,例如报表数据、分页用的记录总数等等
 * </p>
 * 创建时间：2013-4-9 22:17:34
 * 
 * @author leilichao
 * @version V1.0
 */
public class BaseEntity {
	private static final long serialVersionUID = 1L;

    private Integer           totalCount;

    @Transient
    public Integer getTotalCount() {
        return totalCount;
    }

    public void setTotalCount(Integer totalCount) {
        this.totalCount = totalCount;
    }
}
