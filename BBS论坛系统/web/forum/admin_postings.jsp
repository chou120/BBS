<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="INC/const.jsp"%>
<%@ page import = "java.util.Vector,
					net.acai.forum.admin.*"%>
<%
	stats=forumName+"论坛帖子管理";
	forumID=ParamUtil.getInt(request,"forumID",0);
	String errMsg=""; 
	
%>
<%@ include file="INC/theme.jsp"%>
<%
out.println(headLine(1,forumName,forumLogo,"",1,stats));
%>
<%
	if(foundUser){
		try{
			ForumMSGAdmin forumMSGAdmin=new ForumMSGAdmin(request,response);
			
			int rootID=ParamUtil.getInt(request,"rootID");
			int announceID=ParamUtil.getInt(request,"announceID");
			String action=ParamUtil.getString(request,"action");
			String tempString=ParamUtil.getString(request,"checked");
			
			if(action.equals("move")&&tempString==null)
			{
			
		%>
		<table cellpadding=0 cellspacing=0 border=0 width="<%=tableWidth%>" bgcolor=<%=tableBackColor%> align=center>
                <tr>
                    <td>
                    <table cellpadding=6 cellspacing=1 border=0 width=100%>
                        <tr>
                        <td bgcolor=<%=tableTitleColor%> valign=middle align=center colspan=2>
                        <form action="admin_postings.jsp" method="post">
                        <input type=hidden name="action" value="move">
                        <input type=hidden name="checked" value="yes">
                        <input type=hidden name="forumID" value="<%=forumID%>">
                        <input type=hidden name="rootID" value="<%=rootID%>">
                        <input type=hidden name="announceID" value="<%=announceID%>">
                        <b>移动主题</b></td></tr>

                                    <tr>
                                    <td bgcolor=<%=tableBodyColor%> valign=middle>
                                    <b>移动选项</td>
                                    <td bgcolor=<%=tableBodyColor%> valign=middle>
                                    <!--<input name="leavemessage" type="radio" value="yes"> 移动并保留一个已经锁定的主题在原论坛<br>--><input name="leavemessage" type="radio" value="no" checked> 移动并将此主题从原论坛中删除
                                    </td>
                                    </tr>

                            <tr>
                        <td bgcolor=<%=tableBodyColor%> valign=top><b>移动到：</b></td>
                        <td bgcolor=<%=tableBodyColor%> valign=top>

<select name="newForumID" size="1">
<option value="">选择一个论坛</option>
<%@include file="INC/forumList.jsp"%>
          </select>
			</td>
                        </tr>
                    <tr>
                <td bgcolor=<%=tableTitleColor%> valign=middle colspan=2 align=center><input type=submit name="submit" value="提 交"></td></tr></form></table></td></tr></table>
            </table>
            </td></tr>
            </table>
<%
			}
			else if(action.equals("copy")&&tempString==null){
				%>
				            <table cellpadding=0 cellspacing=0 border=0 width="<%=tableWidth%>" bgcolor=<%=tableBackColor%> align=center>
                <tr>
                    <td>
                    <table cellpadding=6 cellspacing=1 border=0 width=100%>
                        <tr>
                        <td bgcolor=<%=tableTitleColor%> valign=middle align=center colspan=2>
                        <form action="admin_postings.jsp" method="post">
                        <input type=hidden name="action" value="copy">
                        <input type=hidden name="checked" value="yes">
                        <input type=hidden name="forumID" value="<%=forumID%>">
                        <input type=hidden name="rootID" value="<%=rootID%>">
                        <input type=hidden name="announceID" value="<%=announceID%>">
                        <b>复制帖子</b></td></tr>

                                    <tr>
                                    <td bgcolor=<%=tableBodyColor%> valign=middle>
                                    <b>操作说明</td>
                                    <td bgcolor=<%=tableBodyColor%> valign=middle>
帖子将复制到别的论坛，成为新的帖子，并保留在原来论坛
                                    </td>
                                    </tr>
                            <tr>
                        <td bgcolor=<%=tableBodyColor%> valign=top><b>移动到：</b></td>
                        <td bgcolor=<%=tableBodyColor%> valign=top>

<select name="newForumID" size="1">
<option value="">选择一个论坛</option>
<%@include file="INC/forumList.jsp"%>      
          </select>
			</td>
                        </tr>
                    <tr>
                <td bgcolor=<%=tableTitleColor%> valign=middle colspan=2 align=center><input type=submit name="submit" value="提 交"></td></tr></form></table></td></tr></table>
            </table>
            </td></tr>
            </table>
				<%
		}
		else{
				%>

    <table cellpadding=0 cellspacing=0 border=0 width=<%=tableWidth%> bgcolor=<%=tableBackColor%> align=center>
        <tr>
            <td>
                <table cellpadding=3 cellspacing=1 border=0 width=100%>
    <tr align="center"> 
      <td width="100%" bgcolor=<%=tableTitleColor%>>成功：帖子操作</td>
    </tr>
    <tr> 
      <td width="100%" bgcolor=<%=tableBodyColor%>><li>帖子操作成功。<li>您的操作信息已经记录在案。<br>
      </td>
    </tr>
    <tr align="center"> 
      <td width="100%" bgcolor=<%=tableTitleColor%>>
<a href="list.jsp?forumID=<%=forumID%>"> << 返回论坛</a>
      </td>
    </tr>  
    </table>   </td></tr></table>
<%

	}
}

catch(Exception e){
	e.printStackTrace();
	 errMsg=e.getMessage();
	%>
	<%@include file="INC/error.jsp"%>
	<%
	}
}
else{
 errMsg="请您登陆！";
	%>
	<%@include file="INC/error.jsp"%>
<%}%>
<%@include file="foot.jsp"%>