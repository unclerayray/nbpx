package com.nb.nbpx;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.junit.Rule;
import org.junit.rules.ExpectedException;
import org.junit.rules.TestName;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.TestExecutionListeners;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.support.DependencyInjectionTestExecutionListener;
import org.springframework.test.context.transaction.TransactionConfiguration;
import org.springframework.test.context.transaction.TransactionalTestExecutionListener;

/**
 * <p>
 * 测试类的基类
 * </p>
 * 创建时间：2013-4-14 上午10:44:03
 * 
 * @author leilichao
 * @version V1.0
 */
// 配置测试用例运行器
@RunWith(SpringJUnit4ClassRunner.class)
// 配置spring配置文件位置
@ContextConfiguration(locations = { "/applicationContext-common.xml" })
// 配置测试监听器，其中TransactionalTestExecutionListener用于解析和事务有关的注解，DependencyInjectionTestExecutionListener解析和spring自动装配有关的注解
@TestExecutionListeners({ TransactionalTestExecutionListener.class, DependencyInjectionTestExecutionListener.class })
// 配置事务管理器，如果不指定名字，则默认装配名字为transactionManager的bean
@TransactionConfiguration(transactionManager = "txManager", defaultRollback = true)
public class BaseServiceTest {
    protected static final int SUCCESS    = 0;
    protected static final int FAIL       = -1;

    /**
     * 用于获取当前测试用例的名称（即方法名，使用testName.getMethodName()），一定要加Rule注解且用public修饰，
     * 否则获取名称不成功
     */
    @Rule
    public TestName            testName   = new TestName();

    /**
     * 用于测试异常<br/>
     * 用法：<br/>
     * 1.expectedEx.expect(异常类);//这个表示测试方法应该抛出的异常<br/>
     * 2.expectedEx.expectMessage(异常描述信息中的某一段);//若抛出的异常描述信息中包含这个字符串，则测试通过；<br/>
     * 如果只需测试抛出的异常类而不需要测试异常信息，则这步不需要<br/>
     * 3.测试方法抛出要测试的异常即可<br/>
     * 注意：<br/>
     * 1.@Test(expected=InvalidPasswordException.class) 和测试方法中的
     * expectedEx.expectXxx() 方法是不能同时并存的<br/>
     * 2.这两个要写在被测试方法的前面，一般写在测试方法的开头即可
     */
    @Rule
    public ExpectedException   expectedEx = ExpectedException.none();

    /**
     * 根据参数中的state值返回0或-1，只适用于参数中带有state这个key的json字符串，否则直接返回-1以表示方法失败<br/>
     * 如果service方法中返回的不是上述格式的json，则自行写逻辑判断测试方法是否通过
     * 
     * @param result
     * @return
     */
    protected int getActuallByState(String result) {
        int actuall = SUCCESS;
        try {
            JSONObject jo = JSONObject.fromObject(result);
            Object stateObj = jo.get("state");
            if (null != stateObj) {
                // 这种情况是state和resultSet同级的
                actuall = jo.getInt("state");
            } else {
                // 这种情况是state属于resultSet的value的一部分
                JSONArray resultSetObj = jo.getJSONArray("resultSet");
                if (null != resultSetObj) {
                    if (resultSetObj.size() > 0) {
                        JSONObject joInResultSet = resultSetObj.getJSONObject(0);
                        Object stateObjInResultSet = joInResultSet.get("state");
                        if (null != stateObjInResultSet) {
                            actuall = joInResultSet.getInt("state");
                        } else {
                            actuall = FAIL;
                        }
                    } else {
                        // resultSet的value为空数组
                        actuall = FAIL;
                    }
                } else {
                    // 没有resultSet这个key
                    actuall = FAIL;
                }
            }
        } catch (Exception e) {
            // json转换出错或其它异常
            actuall = FAIL;
        }
        return actuall;
    }

    /**
     * 获取默认的测试不通过信息
     * 
     * @return
     */
    protected String getWrongMsg() {
        return "<-- " + testName.getMethodName() + "测试不通过（抛出异常或json中state的值为-1） -->";
    }

    /**
     * 用于要测试抛出异常时进行测试异常的配置
     * 
     * @param expectedExceptionClass
     *            期望抛出的异常，不能传入null，否则报错
     * @param subExceptionMsg
     *            期望异常描述信息中出现的某段字符串（可用正则表达式，具体请需要时自行实现）
     */
    protected void configExpectedException(Class<? extends Throwable> expectedExceptionClass, String subExceptionMsg) {
        expectedEx.expect(expectedExceptionClass);
        if (subExceptionMsg != null && !subExceptionMsg.equals("")) {
            expectedEx.expectMessage(subExceptionMsg);
        }
    }
}