package com.nb.nbpx.utils.daotool;

/**
 * @author Roger
 * @date 2013年10月12日
 */
public class Equality {
	public String propName;
	public Object propValue;
	public String getPropName() {
		return propName;
	}
	public void setPropName(String propName) {
		this.propName = propName;
	}
	public Object getPropValue() {
		return propValue;
	}
	public void setPropValue(Object propValue) {
		this.propValue = propValue;
	}
	public Equality(String propName, Object propValue) {
		super();
		this.propName = propName;
		this.propValue = propValue;
	}
}
