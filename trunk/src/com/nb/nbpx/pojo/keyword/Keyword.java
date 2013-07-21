package com.nb.nbpx.pojo.keyword;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.nb.nbpx.pojo.BaseEntity;

/**
 * @author Roger
 * @date 2013年7月21日
 */
/**
 * @author Roger
 * @date 2013年7月21日
 */
@Entity
@Table(name = "keywords", catalog = "nbpx")
public class Keyword  extends BaseEntity  implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer keyId;
	private String keyword;
	private Boolean flag;
	private String type;
	private Integer batchNum;
	private String categoryId;
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "keyId", unique = true, nullable = false)
	public Integer getKeyId() {
		return keyId;
	}
	public void setKeyId(Integer keyId) {
		this.keyId = keyId;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public Boolean getFlag() {
		return flag;
	}
	public void setFlag(Boolean flag) {
		this.flag = flag;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public Integer getBatchNum() {
		return batchNum;
	}
	public void setBatchNum(Integer batchNum) {
		this.batchNum = batchNum;
	}
	public String getCategoryId() {
		return categoryId;
	}
	public void setCategoryId(String categoryId) {
		this.categoryId = categoryId;
	}
	public Keyword(Integer keyId, String keyword, Boolean flag, String type,
			Integer batchNum, String categoryId) {
		super();
		this.keyId = keyId;
		this.keyword = keyword;
		this.flag = flag;
		this.type = type;
		this.batchNum = batchNum;
		this.categoryId = categoryId;
	}
	public Keyword() {
		super();
	}
	
	
}
