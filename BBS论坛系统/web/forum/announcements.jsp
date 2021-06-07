<%@ page contentType="text/html;charset=GBK"%>
<%@include file="INC/const.jsp"%>
<%@ page import = "java.util.Vector"%>
<%
	stats="浏览论坛公告";
 %>
 <%@ include file="INC/theme.jsp"%>
 <%
	out.println(headLine(forumID,forumName,forumLogo,"",1,stats));
 %>
 
	        <table cellpadding=0 cellspacing=0 border=0 width="<%=tableWidth%>" bgcolor="<%=tableBackColor%>" align=center>
<%
	try{
		Vector forumNewsVector=ForumNewsManager.getForumNewsVector(forumID);
		for(i=0;i<forumNewsVector.size();i++){
		ForumNews forumNews=(ForumNews)forumNewsVector.get(i);

 %>
 	                        <tr>
	                        <td bgcolor="<%=tableTitleColor%>" align=center valign=top><font color="<%=tableFontColor%>"><b>>> <%=response.encodeURL(forumNews.getTitle())%> <<</b></font></td></tr>
	                        <tr>
	                            <td bgcolor="<%=tableBodyColor%>" valign=top style="LEFT: 0px; WIDTH: 100%; WORD-WRAP: break-word"><font color="<%=tableContentColor%>"><br>
	                        <p><blockquote><%=new MyFilter(forumNews.getContent()).getFilterString()%>
</blockquote></p></font>
	                        </td>
	                        </tr>
	                        <tr>
	                            <td bgcolor="<%=tableBodyColor%>" valign=middle>
	                        <table width=100% border="0" cellpadding="0" cellspacing="0">
	                        <tr><td align=left><font color="<%=tableContentColor%>">&nbsp;&nbsp;&nbsp;<b>发布人</b>： <%=response.encodeURL(forumNews.getUserName())%></font>
	                        </td><td align=right><font color="<%=tableContentColor%>"><b>发布时间</b>： <%=forumNews.getAddTime()%>&nbsp;&nbsp;&nbsp;</font>
	                        </tr>
	                        </table>
	                        </td>
	                        </tr>
<%
			}
		}

		catch(Exception e){
					e.printStackTrace();
									%>
	                <tr>
	                    <td>
	                    <table cellpadding=3 cellspacing=1 border=0 width=100%>

	                        <tr>
	                        <td bgcolor="<%=tableTitleColor%>" align=center valign=top><font color="<%=tableFontColor%>"><b>>> 当前没有任何公告 <<</b></font></td></tr>
	                        <tr>
	                            <td bgcolor="<%=tableBodyColor%>" valign=top style="LEFT: 0px; WIDTH: 100%; WORD-WRAP: break-word"><font color="<%=tableContentColor%>"><br>
	                        <p><blockquote>请进入论坛管理页面来发布一个公告(必须是管理员或者版主)。 <br>当你发布一次公告后，本公告就会自动消失，无需你手动删除！
</blockquote></p></font>
	                        </td>
	                        </tr>
	                        <tr>
	                            <td bgcolor="<%=tableBodyColor%>" valign=middle>
	                        <table width=100% border="0" cellpadding="0" cellspacing="0">
	                        <tr><td align=left><font color="<%=tableContentColor%>">&nbsp;&nbsp;&nbsp;<b>发布人</b>： 本站的默认公告</font>
	                        </td><td align=right><font color="<%=tableContentColor%>"><b>发布时间</b>： <%=NDate%>&nbsp;&nbsp;&nbsp;</font>
	                        </tr>
	                        </table>
	                        </td>
	                        </tr>



<%
		}
	
%>
				</table>
			</td></tr></table>
<%@ include file="foot.jsp"%>
