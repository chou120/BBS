<%@ page language="java"  contentType="text/html; charset=gb2312"%><%@ include file="INC/const.jsp"%><%@ page import = "java.util.Vector"%><html><head><title><%=forumName%>--管理页面</title><link rel="stylesheet" type="text/css" href="forum.css"></head><BODY bgcolor="#ffffff" alink="#333333" vlink="#333333" link="#333333" topmargin="20"><%try{	if(session.getAttribute("adminFlag")==null||"".equals(session.getAttribute("adminFlag")))		throw new Exception("本页面为版主专用，请<a href=elogin.jsp>登陆管理</a>后进入。");	%><table cellpadding=0 cellspacing=0 border=0 width=95% bgcolor=<%=aTableBackColor%> align=center>  <tr>    <td>      <table cellpadding=3 cellspacing=1 border=0 width=100%>        <tr bgcolor='<%=aTableTitleColor%>'>        <td align=center colspan="2">欢迎<b><%=session.getAttribute("adminName")%></b>进入管理页面        </td>        </tr>            <tr bgcolor=<%=tableBodyColor%>>              <td width="20%" valign=top><%@ include file="admin_left.jsp"%>	      </td>              <td width="80%" valign=top>&nbsp; </td>            </tr>        </table>        </td>    </tr></table><%}catch(Exception e){	e.printStackTrace();	String errMsg=e.getMessage();	%>	<%@include file="INC/error.jsp"%>	<%}%><%@ include file="foot.jsp"%>