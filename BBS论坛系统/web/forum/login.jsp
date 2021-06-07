<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="INC/const.jsp"%>
<%
	stats="登陆";
%>
<%@ include file="INC/theme.jsp"%>
<%
	out.println(headLine(forumID,forumName,forumLogo,"",1,stats));
%>
<form action="chklogin.jsp" method="post"> 
<table cellpadding=0 cellspacing=0 border=0 width=95% bgcolor=<%=aTableBackColor%> align=center>
    <tr>    
        <td>
        <table cellpadding=6 cellspacing=1 border=0 width=100%>

    <tr>
    <td bgcolor=<%=aTableTitleColor%> valign=middle colspan=2 align=center>
    <b>请输入您的用户名、密码登陆</b></font></td></tr>
    <tr>
    <td bgcolor=<%=tableBodyColor%> valign=middle>请输入您的用户名</td>
    <td bgcolor=<%=tableBodyColor%> valign=middle><INPUT name=userName type=text> &nbsp; <a href="reg.jsp">没有注册？</a></td></tr>
    <tr>
    <td bgcolor=<%=tableBodyColor%> valign=middle>请输入您的密码</td>
    <td bgcolor=<%=tableBodyColor%> valign=middle><INPUT name=userPassword type=password> &nbsp; <a href="lostpass.jsp">忘记密码？</a></td></tr>
    <tr>
    <td bgcolor=<%=tableBodyColor%> valign=top width=30%><b>Cookie 选项</b><BR> 请选择你的 Cookie 保存时间，下次访问可以方便输入。</font></td>
    <td bgcolor=<%=tableBodyColor%> valign=middle>
                <input type="radio" name="cookieDate" value="0" checked>不保存，关闭浏览器就失效<br>
                <input type="radio" name="cookieDate" value="1">保存一天<br>
                <input type="radio" name="cookieDate" value="2">保存一月<br>
                <input type="radio" name="cookieDate" value="3">保存一年<br>
                </td></tr>
	<input type=hidden name=comeURL value="<%=request.getHeader("REFERER")%>">
    <tr>
    <td bgcolor=<%=aTableTitleColor%> valign=middle colspan=2 align=center><input type=submit name="submit" value="登 陆"></td></tr></table></td></tr></table>
</form>

<%@ include  file="foot.jsp"%>

