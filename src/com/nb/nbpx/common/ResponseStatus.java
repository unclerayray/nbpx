package com.nb.nbpx.common;

/**
 * <p>
 * 封装后台返回状态的类
 * </p>
 * 创建时间：2011-11-9 下午05:03:15
 * 
 * @author huangjinfang
 * @version V1.0
 */
public class ResponseStatus {
	public static final int CONFIRM_REMOVE = -1001;

	public static final int LOGIN_REQUIRED = -1002;

	public static final int ACCESS_DENY = -1010;

	public static final int BEANUTILS_ERROR = -103;

	public static int JPA_ERROR = -102;

	public static int DUPLICATE_RECORD = -1011;

	public static int SUCCESS = 0;

	public static int FAIL = -1;

	/**
	 * 添加成功
	 */
	public static final String ADD_SUCCESS = "添加成功!";

	/**
	 * 添加失败
	 */
	public static final String ADD_FAILED = "添加失败!";

	/**
	 * 修改成功
	 */
	public static final String UPDATE_SUCCESS = "修改成功!";

	/**
	 * 修改失败
	 */
	public static final String UPDATE_FAILED = "修改失败!";

	/**
	 * 删除成功
	 */
	public static final String DELETE_SUCCESS = "删除成功!";

	/**
	 * 删除失败
	 */
	public static final String DELETE_FAILED = "删除失败!";

	/**
	 * 查询成功
	 */
	public static final String QUERY_SUCCESS = "查询成功!";

	/**
	 * 查询失败
	 */
	public static final String QUERY_FAILED = "查询失败!";

	/**
	 * 数据库异常
	 */
	public static final String DB_EXCEPTION = "数据库异常!";

	/**
	 * 数据已存在
	 */
	public static final String EXISTRECORD = "数据已存在!";

	/**
	 * 操作成功
	 */
	public static final String OPERATION_SUCCESS = "操作成功!";

	/**
	 * 操作失败
	 */
	public static final String OPERATION_FAILED = "操作失败!";
	
	/**
	 * 操作成功
	 */
	public static final String FETCH_SUCCESS = "已采集成功!";

	/**
	 * 操作失败
	 */
	public static final String FETCH_FAILED = "采集程序遇到意外错误!";
	
	/**
	 * 验证失败
	 */
	public static final String CHECK_FAILED = "该字典类型编码已存在，请重新填写类型编码!";
	/**
	 * 验证字典编码失败
	 */
	public static final String CHECK_CODENAME_FAILED = "该字典编码已存在，请重新填写字典编码!";
	/**
	 * 验证字典类型值失败
	 */
	public static final String CHECK_SHOWNAME_FAILED = "该字典类型项值已经存在，请重新填写字典类型项值！";
	/**
	 * 验证产品标识号失败
	 */
	public static final String CHECK_PRODUCT_FAILED = "该产品已存在，请重新填写产品信息！";
}
