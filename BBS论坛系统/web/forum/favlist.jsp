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
			throw new Exception("您还没有<a href=login.jsp>登陆论坛</a>，不能查看收藏。如果您还没有<a href=reg.jsp>注册</a>，请先<a href=reg.jsp>注册</a>！");
		String action=ParamUtil.getString(request,"action");
%>

		
	        

	
				
<%
	if(action==null||"".equals(action.trim())){
	Vector bookMarkList=ForumBookMark.getBookMarkList(request);
	if(bookMarkList.size()==0)
		throw new Exception("您的收藏夹还没有收藏，您可以收藏论坛指定贴子，当收藏中有数据后，本信息将自动删除！");
	
%>
	<table cellpadding=0 cellspacing=0 border=0 width=<%=tableWidth%> bgcolor="<%=tableBackColor%>" align=center>
	                <tr>
	                    <td>
	                    <table cellpadding=3 cellspacing=1 border=0 width=100%>                        <tr>
	                        <td bgcolor="<%=tableTitleColor%>" align=center valign=top colspan="3"><b><font color=<%=tableFontColor%>>>> 您的收藏夹 <<</font></b></td></tr>
  <tr bgcolor="<%=tableBodyColor%>">
    <td width="70%"><font color="<%=tableContentColor%>">标题</font></td>
    <td width="20%"><font color="<%=tableContentColor%>">时间</font></td>
    <td width="10%"><font color="<%=tableContentColor%>">操作</font></td>
  </tr>
<%
		for(i=0;i<bookMarkList.size();i++){
			BookMark bookMark=(BookMark)bookMarkList.get(i);
%>
  <tr bgcolor="<%=tableBodyColor%>">
    <td width="70%"><a href="<%=bookMark.getURL()%>"><%=response.encodeURL(bookMark.getTopic())%></a></td>
    <td width="20%"><font color="<%=tableContentColor%>"><%=bookMark.getAddTime()%></font></td>
    <td width="10%"><a href="favlist.jsp?action=delete&id=<%=bookMark.getID()%>"><img src="pic/a_delete.gif" border=0></a></td>
  </tr>
  </table>
			</td></tr>
</table>
<%
		}
	}
	

	else if(action.equals("delete")){
	ForumBookMark.delBookMark(request);
%>
<table cellpadding=0 cellspacing=0 border=0 width=<%=tableWidth%> bgcolor="<%=tableBackColor%>" align=center>
	                <tr>
	                    <td>
	                    <table cellpadding=3 cellspacing=1 border=0 width=100%>
	                        <tr>
	                        <td bgcolor="<%=tableTitleColor%>" align=center valign=top><b><font color=<%=tableFontColor%>>> 操作成功 <<</font></b></td></tr>
	                        <tr>
	                            <td bgcolor="<%=tableBodyColor%>" valign=top style="LEFT: 0px; WIDTH: 100%; WORD-WRAP: break-word"><br><font color="<%=tableContentColor%>">
	                        <p><blockquote>已删除您的收藏夹中相应纪录，<a href="javascript:history.go(-1)">返回收藏</a>。
</blockquote></p></font>
	                        </td>
	                        </tr>
							</table>
			</td></tr>
</table>
<%
	}
	else
		throw new Exception("非法请求！");

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
