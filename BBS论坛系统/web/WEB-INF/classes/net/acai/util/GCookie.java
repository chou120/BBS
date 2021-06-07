// created on 2002-2-26 at 14:42
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

public class GCookie
{
	
	public static String getCookieValue(HttpServletRequest request,String cookieName,String defaultValue)
	{		
		Cookie cookieList[]=request.getCookies();
		if(cookieList==null||cookieName==null)
			return "";
		for(int i= 0;i<cookieList.length;i++)
		{
			try{
			if(cookieList[i].getName().equals(cookieName))
				return java.net.URLDecoder.decode(cookieList[i].getValue(),"GBK");
			}
			catch(Exception e){
				e.printStackTrace();
			}
				
		}
		return "";
	}
	public static void setCookie(HttpServletResponse response,String cookieName,String cookieValue)
	{
		Cookie theCookie=new Cookie(java.net.URLEncoder.encode(cookieName),java.net.URLEncoder.encode(cookieValue));
		
		response.addCookie(theCookie);
	}
	public static void setCookie(HttpServletResponse response,String cookieName,String cookieValue,int cookieMaxage)
	{
		Cookie theCookie=new Cookie(java.net.URLEncoder.encode(cookieName),java.net.URLEncoder.encode(cookieValue));
		theCookie.setMaxAge(cookieMaxage);
		response.addCookie(theCookie);
	}
}
