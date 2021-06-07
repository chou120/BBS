<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="INC/const.jsp"%>
<%@ page import = "java.util.Vector"%>
<%
	stats=forumName+"论坛下载.";
	forumID=ParamUtil.getInt(request,"forumID",0);
	
	
%>
<%@ include file="INC/theme.jsp"%>
<%
out.println(headLine(1,forumName,forumLogo,"",1,stats));
%>
<%
	try{
		if(!foundUser)
			throw new Exception("请您登陆之后才能下载！");
		%>
		<br><table cellpadding=0 cellspacing=0 border=0 width="<%=tableWidth%>" bgcolor="<%=tableBackColor%>" align=center>
		<tr><td><table cellpadding=3 cellspacing=1 border=0 width="100%"><tr align=center>
		<td width="100%" bgcolor="<%=tableTitleColor%>"><font color="<%=tableFontColor%>"><b>论坛下载信息</b></font></td>
		</tr><tr><td width="100%" bgcolor="<%=tableBodyColor%>">
		<font color="<%=tableContentColor%>"><b>下载地址：</b><br><br>
		<a href=http://www.SuperSpace.com/forum/SuperSpace.zip>清清论坛下载</a>
		</font></td></tr><tr align=center><td width="100%" bgcolor="<%=tableTitleColor%>">
		<a href=javascript:history.go(-1)><font color="<%=tableFontColor%>"> << 返回上一页</font></a>
		</td></tr>   </table>   </td></tr></table>
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