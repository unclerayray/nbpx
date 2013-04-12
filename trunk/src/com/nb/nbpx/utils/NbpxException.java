package com.nb.nbpx.utils;


/**
 * <p>
 * 自定义异常类
 * </p>
 * 创建时间：2013-4-9 22:33:04
 * 
 * @author leilichao
 * @version V1.0
 */

public class NbpxException extends Exception {

    private static final long serialVersionUID = 1L;
    
    public NbpxException(){
        
    }
    
    public NbpxException(String msg){
        super(msg);
    }
    
    public NbpxException(Exception cause){
        super(cause);
    }
    
    public NbpxException(String msg, Exception cause) {
        super(msg, cause);
    }
}
