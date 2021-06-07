<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="INC/const.jsp"%>
<%@ page import="net.acai.forum.*"%>
<%@ include file="INC/theme.jsp"%>
<%
	userName=ParamUtil.getString(request,"userName","");
	userPassword=ParamUtil.getString(request,"userPassword","");
	int cookieDate=ParamUtil.getInt(request,"cookieDate",0);
	String comeURL=ParamUtil.getString(request,"comeURL","");
	
	try{
		SkinUtil.userLogin(request,response,1);
		stats="登陆成功";
		out.println(headLine(forumID,forumName,forumLogo,"",1,stats));
%>
	<meta HTTP-EQUIV=REFRESH CONTENT='4; URL=index.jsp'>

    <table cellpadding=0 cellspacing=0 border=0 width=95% bgcolor=<%=aTableBackColor%> align=center>
        <tr>
            <td>
                <table cellpadding=3 cellspacing=1 border=0 width=100%>
	     <tr>
	      <td bgcolor="<%=tableTitleColor%>"><font color="<%=tableFontColor%>"><b>状态：您已经登录成功</b></font></td>
	    </tr>
	     <tr><td bgcolor="<%=tableBodyColor%>"><br><ul><li><a href="index.jsp"><font color="<%=tableContentColor%>">进入讨论区</font></a></li></ul></td></tr>
	  </table>   </td></tr></table>
<%
	}
	catch(Exception e)
	{
		stats="登陆失败";
		out.println(headLine(forumID,forumName,forumLogo,"",1,stats));
		String errMsg=e.getMessage();

%>
	<%@include file="INC/error.jsp"%>
<%
		
	}
%>
<%@ include file="foot.jsp"%>