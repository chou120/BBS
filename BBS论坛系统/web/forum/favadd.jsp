<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="INC/const.jsp"%>
<%@ page import = "java.util.Vector"%>
<%
	stats=forumName+"论坛收藏夹.";
	forumID=ParamUtil.getInt(request,"forumID",0);
	
	
%>
<%@ include file="INC/theme.jsp"%>
<%
out.println(headLine(1,forumName,forumLogo,"",1,stats));
%>
<%
	try{
		if(!foundUser)
			throw new Exception("您还没有<a href=login.jsp>登录</a>。");
		ForumBookMark.addFav(request);
	
		

	
%>
    <table cellpadding=0 cellspacing=0 border=0 width=<%=tableWidth%> bgcolor=<%=tableBackColor%> align=center>
        <tr>
            <td>
                <table cellpadding=3 cellspacing=1 border=0 width=100%>
    <tr align="center"> 
      <td width="100%" bgcolor=<%=tableTitleColor%>><font color="<%=tableFontColor%>">成功：帖子收藏</font></td>
    </tr>
    <tr> 
      <td width="100%" bgcolor=<%=tableBodyColor%>><font color="<%=tableContentColor%>"><b>本帖子已经收入您在论坛的<a href=favlist.jsp>收藏夹</a></b><br><br></font>
      </td>
    </tr>
    <tr align="center"> 
      <td width="100%" bgcolor=<%=tableTitleColor%>>
<a href="javascript:history.go(-1)"> << 返回上一页</a>
      </td>
    </tr>  
    </table>   </td></tr></table>
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
