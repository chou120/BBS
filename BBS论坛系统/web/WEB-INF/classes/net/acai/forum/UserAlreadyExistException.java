package net.acai.forum;
/**
 * Title:        ????????
 * Description:
 * Copyright:    Copyright (c) 2002
 * Company:      www.SuperSpace.com
 * @author:       SuperSpace
 * @version 1.0
 */
import java.io.PrintStream;
import java.io.PrintWriter;
public class UserAlreadyExistException extends Exception{
	private Throwable testThrowable=null;
	public UserAlreadyExistException(){
		super();
	}
	public UserAlreadyExistException(String msg){
		super(msg);
	}
	public UserAlreadyExistException(Throwable testThrowable){
		this.testThrowable=testThrowable;
	}
	public UserAlreadyExistException(String msg,Throwable testThrowable){
		super(msg);
		this.testThrowable=testThrowable;
	}
	public void printStackTrace(){
		super.printStackTrace();
		if(testThrowable!=null){
			testThrowable.printStackTrace();
		}
	}
	public void pirntStackTrace(PrintStream ps){
		super.printStackTrace();
		if(testThrowable!=null){
			testThrowable.printStackTrace(ps);
		}
	}
	public void printStackTrace(PrintWriter pw){
		super.printStackTrace();
		if(testThrowable!=null){
			testThrowable.printStackTrace(pw);
		}
	}
	
}
