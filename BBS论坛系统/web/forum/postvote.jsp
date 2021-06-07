<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="INC/const.jsp" %>
<%@ include file="INC/theme.jsp"%>


<%
	
	try{
		Forum theForum=new Forum(forumID);
		String forumType=theForum.getForumType();
		String url=theForum.addVoteNum(request,response);
		stats=forumType + "投票成功";
		out.println(headLine(forumID,forumName,forumLogo,forumType,2,stats));
		
		
		

%>
<meta http-equiv=refresh content="4;URL=<%=url%>">

	<br><table cellpadding=0 cellspacing=0 border=0 width=95% bgcolor=<%=tableBackColor%> align=center>
		<tr><td><table cellpadding=3 cellspacing=1 border=0 width="100%">
		<tr align=center><td width="100%" bgcolor=<%=tableTitleColor%>><b><FONT COLOR=<%=tableFontColor%>>状态：您发表帖子成功</font></b></td>
		</tr><tr><td width="100%" bgcolor=<%=tableBodyColor%>>
		<FONT COLOR="<%=tableContentColor%>">本页面将在3秒后自动返回您所发表的帖子页面，<b>您可以选择以下操作：</b><br><ul>
		<li><a href="index.jsp"><font color="<%=tableContentColor%>">返回首页</font></a></li>
		<li><a href="list.jsp?forumID=<%=forumID%>><font color="<%=tableContentColor%>"><%=forumType%></font></a></li>
		<li><a href="<%=url%>"><font color=<%=tableContentColor%>>发表的帖子</font></a></li>
		</ul></td></tr></table></td></tr></table>
<%
	}
	catch(Exception e){
		e.printStackTrace();
		out.println(e.getMessage());
	}
%>
<%@ include file="foot.jsp"%>