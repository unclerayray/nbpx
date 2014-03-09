package com.nb.nbpx.server.user;

import com.google.code.jcaptcha4struts2.common.actions.JCaptchaBaseAction;

public class MyFormActionWithCaptcha extends JCaptchaBaseAction {

    private static final long serialVersionUID = 6643871470200594031L;
    
    private String message;

    public String getMessage() {
		return message;
	}


	public void setMessage(String message) {
		this.message = message;
	}


	@Override
    public String execute() throws Exception {
            // Your action code here
            return super.execute();
    }
    
    
    @Override
    public void validateInput() {
            // Validation Logic Here
            
            // Note that you cannot override validate() method (it's final).
            // Instead, the logic should be provided in this method.
    	System.out.println("message = "+message);
    }


}