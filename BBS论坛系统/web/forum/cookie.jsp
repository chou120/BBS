<%@ page contentType="text/html;charset=GBK"%>
<%@ page import ="net.acai.util.GCookie,
		  net.acai.forum.*,
		  java.util.Hashtable"%>
<% 
	Cookie UJBBUNameCK=GCookie.getCookieValue(request,"UJBBUName");
	Cookie UJBBUPSWCK=GCookie.getCookie(request,"UJBBUPSW");
	
	if(UJBBUNameCK==null||UJBBUPSWCK==null)
	{
		out.println("转向登陆地页面");
		response.sendRedirect("login.jsp");
			
	}
	else
	{
		String username=UJBBUNameCK.getValue();
		String password=UJBBUPSWCK.getValue();
		response.sendRedirect("checklogin.jsp?username="+username+"&password="+password);
	}
	

%>
	