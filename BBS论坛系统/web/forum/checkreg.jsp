<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="net.acai.forum.*,
		 net.acai.forum.util.*"%>
<%
String username=ParamUtil.getString(request,"username");
String password=ParamUtil.getString(request,"password");
String psw=ParamUtil.getString(request,"psw");
if(username!=null&&password.equals(psw)){
	try{
		UserManager.createUser(username,password);
		response.sendRedirect("login.jsp");
	}
	catch(UserAlreadyExistException e)
	{
		out.println("对不起，已经有人使用了改用户名<BR>");
		response.sendRedirect("reg.jsp");
	}
	
}
else
{
	out.println("你填写完整资料");
}
	
%>