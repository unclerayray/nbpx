package com.nb.nbpx.common;

import java.util.Map;

public class QueryCriteria {
	public Integer           rows;
	public Integer			 start;
	public String			 sort;
	public String			 order;
	public Map<String,Object> equalParamMap;
	public Map<String,String> likeParamMap;
	public Integer getRows() {
		return rows;
	}
	public void setRows(Integer rows) {
		this.rows = rows;
	}
	public Integer getStart() {
		return start;
	}
	public void setStart(Integer start) {
		this.start = start;
	}
	public String getSort() {
		return sort;
	}
	public void setSort(String sort) {
		this.sort = sort;
	}
	public String getOrder() {
		return order;
	}
	public void setOrder(String order) {
		this.order = order;
	}
	public Map<String, Object> getEqualParamMap() {
		return equalParamMap;
	}
	public void setEqualParamMap(Map<String, Object> equalParamMap) {
		this.equalParamMap = equalParamMap;
	}
	public Map<String, String> getLikeParamMap() {
		return likeParamMap;
	}
	public void setLikeParamMap(Map<String, String> likeParamMap) {
		this.likeParamMap = likeParamMap;
	}
	public QueryCriteria(Integer rows, Integer start, String sort,
			String order, Map<String, Object> equalParamMap,
			Map<String, String> likeParamMap) {
		super();
		this.rows = rows;
		this.start = start;
		this.sort = sort;
		this.order = order;
		this.equalParamMap = equalParamMap;
		this.likeParamMap = likeParamMap;
	}
	
	public QueryCriteria() {
		super();
	}
	public QueryCriteria(Integer rows, Integer start, String sort, String order) {
		super();
		this.rows = rows;
		this.start = start;
		this.sort = sort;
		this.order = order;
	}
	
	
}
