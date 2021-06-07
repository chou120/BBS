<% option explicit%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="INC/const.jsp"%>
<%
try{

   	String action=ParamUtil.getString(request,"action");
	if(action!=null&&action.equals("chklogin")){
		userName=ParamUtil.getString(request,"userName");
		userPassword=ParamUtil.getString(request,"userPassword");
		if(userName==null||userPassword==null||userPassword.trim().equals("")||userName.trim().equals(""))
			throw new Exception("请输入您的用户名或密码。");
		User adminUser=SkinUtil.userLogin(userName,userPassword,4);
		if(adminUser.getUserClass()<20)
			throw new Exception("您不是系统管理员");

		session.setAttribute("adminFlag","online");
		response.sendRedirect("admin_main.jsp");

		Errmsg=Errmsg+"<br>"+"<li>请输入管理员密码。"
		founderr=true
	end if
	if founderr=true then
		call error()
	else
	set ars=server.createobject("adodb.recordset")
	asql="select * from admin where password='"&masterpass&"' and username='"&masterName&"' and flag=1"
	ars.open asql,conn,1,1
 	if not(ars.bof and ars.eof) then
 		if masterpass=ars("password") then
	  		session("masterlogin")="superadmin"
	  		session("mastername")=ars("username")
          		session("manageboard")=boardID
			Response.Redirect "admin_main.jsp"
   			ars.close
			set ars=nothing
 		else
			Errmsg=Errmsg+"<br>"+"<li>您输入的管理员名称和密码不正确。"
			call error()
 		end if
	else
			Errmsg=Errmsg+"<br>"+"<li>您输入的管理员名称和密码不正确。"
			call error()
	end if
	end if
%>
