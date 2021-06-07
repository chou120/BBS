<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="net.acai.util.*,
		 net.acai.forum.*,
		 net.acai.forum.util.*,
		 java.util.Vector"%>
<%@ include file="INC/const.jsp"%>
<HTML><HEAD><TITLE><%=forumName%>--显示贴子</TITLE>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>
<link rel="stylesheet" type="text/css" href="forum.css">
<META content="Microsoft FrontPage 4.0" name=GENERATOR></HEAD>
<BODY bgcolor="#ffffff" alink="#333333" vlink="#333333" link="#333333" topmargin="10" leftmargin="10">
<%
try{

	Vector forumMSGs=Forum.getForumTextMSGs(request);
	if(forumMSGs.size()==0)
		throw new Exception("没有此类帖子！");
	forumID=ParamUtil.getInt(request,"forumID");
	int rootID=ParamUtil.getInt(request,"rootID");
	ForumMSG theTopicMSG=(ForumMSG)forumMSGs.get(0);
	Forum theForum=new Forum(forumID);
%>

<TABLE border=0 width="<%=tableWidth%>" align=center>
  <TBODY>
  <TR>
    <TD valign=middle align=top>
<b>以文本方式查看主题</b><br><br>
-&nbsp;&nbsp;<b><%=forumName%></b>&nbsp;&nbsp;(<%=hostURL%><%=forumURL%>index.jsp)<br>
--&nbsp;&nbsp;<b><%=theForum.getForumType()%></b>&nbsp;&nbsp;(<%=hostURL%><%=forumURL%>list.jsp?forumID=<%=forumID%>)<br>
----&nbsp;&nbsp;<b><%=theTopicMSG.getNoFilterTopic()%></b>&nbsp;&nbsp;(<%=hostURL%><%=forumURL%>dispbbs.jsp?forumID=<%=forumID%>&rootID=<%=rootID%>&announceID=<%=rootID%>)
      </TD></TR></TBODY></TABLE> 
<br>
<hr>
<%
	for(i=0;i<forumMSGs.size();i++){
		ForumMSG theMSG=(ForumMSG)forumMSGs.get(i);
%>
<TABLE border=0 width="750" align=center>
  <TBODY>
  <TR>
    <TD valign=middle align=top>
--&nbsp;&nbsp;作者：<%=theMSG.getUserName()%><br>
--&nbsp;&nbsp;发布时间：<%=theMSG.getDateAndTime()%><br><br>
--&nbsp;&nbsp;<%=theMSG.getTopic()%><br>
<%=theMSG.getBody()%>
	<hr>
    </TD></TR></TBODY></TABLE> 
<%
	}
%>
<%
}
catch(Exception e){
	e.printStackTrace();
	String errMsg=e.getMessage();
	%>
	<%@include file="INC/error.jsp"%>
	<%
}%>

<%@ include file="foot.jsp"%>