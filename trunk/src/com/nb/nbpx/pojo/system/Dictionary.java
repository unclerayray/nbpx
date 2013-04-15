package com.nb.nbpx.pojo.system;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.nb.nbpx.pojo.BaseEntity;

/**
 * 字典 表 pojo 创建时间：2012-2-28下午03:04:13
 * 
 * @author: leilichao
 * 
 */
@SuppressWarnings("serial")
@Entity
@Table(name = "sys_dictionary", catalog = "nbpx")
public class Dictionary extends BaseEntity implements Serializable {
    private Integer dicId;
    private String  dicType;
    private String  codeName;
    private String  showName;
    private Integer orderNum;
    private String  attribute1;
    private String  attribute2;
    private String  attribute3;
    private Integer flag;
    private String  discription;

    public Dictionary(){
    }
    
    @Id
	@GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "dicId", unique = true, nullable = false)
    public Integer getDicId() {
        return dicId;
    }

    public void setDicId(Integer dicId) {
        this.dicId = dicId;
    }

    public String getDicType() {
        return dicType;
    }

    public void setDicType(String dicType) {
        this.dicType = dicType;
    }

    public String getCodeName() {
        return codeName;
    }

    public void setCodeName(String codeName) {
        this.codeName = codeName;
    }

    public String getShowName() {
        return showName;
    }

    public void setShowName(String showName) {
        this.showName = showName;
    }

    public Integer getOrderNum() {
        return orderNum;
    }

    public void setOrderNum(Integer orderNum) {
        this.orderNum = orderNum;
    }

    public String getAttribute1() {
		return attribute1;
	}

	public void setAttribute1(String attribute1) {
		this.attribute1 = attribute1;
	}

	public String getAttribute2() {
		return attribute2;
	}

	public void setAttribute2(String attribute2) {
		this.attribute2 = attribute2;
	}

	public String getAttribute3() {
		return attribute3;
	}

	public void setAttribute3(String attribute3) {
		this.attribute3 = attribute3;
	}

	public Integer getFlag() {
        return flag;
    }

    public void setFlag(Integer flag) {
        this.flag = flag;
    }

    public void setDiscription(String discription) {
        this.discription = discription;
    }

    public String getDiscription() {
        return discription;
    }
}