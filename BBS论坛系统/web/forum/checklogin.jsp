<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="net.acai.forum.*,
		 net.acai.forum.util.*"%>
<%
String username=ParamUtil.getString(request,"username");
String password=ParamUtil.getString(request,"password");
String erroMsg="";
if(username!=null&&password!=null)
	try
	{
		SkinUtil.login(request,response,username,password);
		response.sendRedirect("index.jsp");
	}
	catch(UserNotFoundException e)
	{
		erroMsg="错误的用户名和密码";
		response.sendRedirect("login.jsp?"+response.encodeURL(erroMsg));
	}
else{
	out.println("请填写好你的个人信息!");
}
%>