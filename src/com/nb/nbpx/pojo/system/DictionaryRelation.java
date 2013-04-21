package com.nb.nbpx.pojo.system;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.nb.nbpx.pojo.BaseEntity;

/**
 * <p>
 * 字典级联关系实体类
 * </p>
 * 创建时间：2013-4-20 下午01:35:35
 * 
 * @author leilichao
 * @version V1.0
 */
@SuppressWarnings("serial")
@Entity
@Table(name = "sys_dictionary_relation", catalog = "nbpx")
public class DictionaryRelation extends BaseEntity implements Serializable {
	private Integer relationId;
	private String dicType;
	private String dicCode;
	private Integer pid;
	private Integer orderNum;
	private String description;
	private String duplicateProperty;
	private String showName;

	public DictionaryRelation() {
	}

	public DictionaryRelation(Integer relationId, String dicType,
			String dicCode, Integer pid, Integer orderNum, String description,
			String duplicateProperty, String showName) {
		this.relationId = relationId;
		this.dicType = dicType;
		this.dicCode = dicCode;
		this.pid = pid;
		this.orderNum = orderNum;
		this.description = description;
		this.duplicateProperty = duplicateProperty;
		this.showName = showName;
	}

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "relationId", unique = true, nullable = false)
	public Integer getRelationId() {
		return relationId;
	}

	public void setRelationId(Integer relationId) {
		this.relationId = relationId;
	}

	@Column(name = "dicType")
	public String getDicType() {
		return dicType;
	}

	public void setDicType(String dicType) {
		this.dicType = dicType;
	}

	@Column(name = "dicCode")
	public String getDicCode() {
		return dicCode;
	}

	public void setDicCode(String dicCode) {
		this.dicCode = dicCode;
	}

	@Column(name = "pid")
	public Integer getPid() {
		return pid;
	}

	public void setPid(Integer pid) {
		this.pid = pid;
	}

	@Column(name = "orderNum")
	public Integer getOrderNum() {
		return orderNum;
	}

	public void setOrderNum(Integer orderNum) {
		this.orderNum = orderNum;
	}

	@Column(name = "description")
	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	@Column(name = "duplicateProperty")
	public String getDuplicateProperty() {
		return duplicateProperty;
	}

	public void setDuplicateProperty(String duplicateProperty) {
		this.duplicateProperty = duplicateProperty;
	}

	@Transient
	public String getShowName() {
		return showName;
	}

	public void setShowName(String showName) {
		this.showName = showName;
	}
}
