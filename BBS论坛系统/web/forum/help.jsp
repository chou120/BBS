<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="INC/const.jsp"%>
<%@ page import = "java.util.Vector"%>
<%
	stats=forumName+"论坛帮助";
	forumID=ParamUtil.getInt(request,"forumID",0);
	
	
%>
<%@ include file="INC/theme.jsp"%>
<%
out.println(headLine(1,forumName,forumLogo,"",1,stats));
%>



 <table cellpadding=0 cellspacing=0 border=0 width="<%=tableWidth%>" bgcolor="<%=tableBackColor%>" align=center>
    <tr><td>
    <table cellpadding=5 cellspacing=1 border=0 width=100%>
    
						<tr>
						<td bgcolor="<%=tableTitleColor%>" valign=middle colspan=2 align="center">
						<p><form action="queryresult.jsp" method="post">
						<font color="<%=tableFontColor%>"><b>论坛说明</b></font></td></tr>
						<tr>
						<td bgcolor="<%=tableBodyColor%>" colspan=2 align="left" valign="middle"><font  color="<%=tableContentColor%>">
						 1. 用户注册：只有在接受论坛条款并填写注册信息的用户能在论坛中发表贴子，新用户注册系统会自动给用户一个提示信息，用户可以自由定制自己的头像信息和签名(支持ubb标签)。

<br><br>2. 用户登陆：可以选择在登陆页面登陆或者直接在发表贴子处登陆，系统自动纪录用户登陆信息，只有登陆用户才能发表贴子。

<br><br>3. 修改资料：登陆用户可以对自己的原始注册信息进行修改。

<br><br>4. 短信息：登陆用户可以对任何在论坛中注册的用户发送短消息，用户可以对信息进行阅读和删除等操作，当收到短信息的时候系统会自动提醒。

<br><br>5. 论坛排行：目前支持对论坛的注册用户按照发贴数量和注册时间进行排行

<br><br>6. 论坛搜索：支持对论坛的标题、内容、发言人、贴子id、最新贴子、最热门贴子等多种查询.

<br><br>7. 发表贴子：登陆(注册)用户可以自由在没有锁定的论坛内发表贴子，论坛目前支持多种UBB语法，贴图，连接，插入Flash等，并且可以进行调试html的操作，可以选择引用回复和直接回复，具体uub使用请查看论坛帮助的ubb相关。

<br><br>8. 回复贴子：登陆(注册)用户可以对没有锁定的主题进行回复，发言格式同上。

<br><br>9. 编辑贴子：发贴用户可以对自己发表的文章进行修改，版主和管理员有权限对所有贴子进行编辑，同等级用户不能互相编辑。

<br><br>10.在线用户：详细准确统计用户在线信息，可以列出用户的浏览器、系统、来源、活动时间等信息。

<br><br>11.贴子收藏：登陆用户可以选择自己喜爱的贴子收藏到论坛的收藏夹，可以随时翻阅和进行删除的操作。

<br><br>12.文本信息：将一个主题的内容按照打印的格式在浏览器输出，方便用户直接打印贴子。

<br><br>13.贴子显示：可以按照用户需求按照某条件进行贴子显示(前一天、一周等)

<br><br>14.用户等级：用户按照发表文章多少分为六个等级，具体请看帮助


<br><br>15.更多信息请看论坛帮助文件。
						
						
						</font></td>
						</tr>
						<tr>
						<td bgcolor="<%=tableTitleColor%>" valign=middle colspan=2 align=center>&nbsp;
						</td></form></tr></table></td></tr></table>

<%@include file="foot.jsp"%>
