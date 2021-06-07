// created on 2002-2-26 at 20:41
package net.acai.util;
/**
 * Title:        ÇåÇåÍøÂç
 * Description:
 * Copyright:    Copyright (c) 2002
 * Company:      www.SuperSpace.com
 * @author:       SuperSpace
 * @version 1.0
 */
import javax.servlet.http.*;
public class ParamUtil
{
	public static String getString(HttpServletRequest request,String paramName)
	{
		String temp=request.getParameter(paramName);
		if(temp!=null&&!temp.equals(""))
			return temp;
		else
			return null;
	}
	public static String getString(HttpServletRequest request,String paramName,String defaultString){
		String temp=getString(request,paramName);
		if(temp==null)
			temp=defaultString;
		return temp;
	}
	public static int getInt(HttpServletRequest request,String paramName) throws NumberFormatException{
			return Integer.parseInt(getString(request,paramName));
	}
	public static int getInt(HttpServletRequest request,String paramName,int defaultInt){
		try{
			String temp=getString(request,paramName);
			if(temp==null)
				return defaultInt;
			else
				return Integer.parseInt(temp);
		}
		catch(NumberFormatException e){
			e.printStackTrace();
			return 0;
		}
	}






}
