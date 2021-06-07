<%@ page contentType="text/html;charset=GBK" %>
<%@ page import="net.acai.forum.*,
		 java.util.*"%>

<%@ include file="INC/const.jsp" %>
<%@ include file="INC/theme.jsp"%>

<%
	try{
		Vector users=SkinUtil.getTopList(request);
		int usersNum=users.size();
	String orderName;
	int orders=ParamUtil.getInt(request,"orders");
	switch(orders){
	case 1:
		orders=1;
		orderName="发贴总数Top10";
		break;
	case 2:
		orders=2;
		orderName="最新用户注册";
		break;
	case 7:
		orders=7;
		orderName="所有用户列表";
		break;
	default:
		orders=1;
		orderName="发贴总数Top10";
		break;
	}
	
	int Page;
	Page=ParamUtil.getInt(request,"Page",1);
	stats=orderName;
	out.println(headLine(forumID,forumName,forumLogo,"",1,stats));
%>
    <table width=95% bgcolor=<%=tableBackColor%>  cellspacing=0 border=0 bordercolor=<%=tableBackColor%> align=center>
    	<tr>
	        <td>
        	
<table cellpadding=6 cellspacing=1 border=0 width=100%>
<form method="POST" action="toplist.jsp"> 
<tr bgColor="<%=aTableBodyColor%>"> 
<td colspan=5 valign=top width=350>&nbsp;>> <B><%=orderName%></B> <<<BR>
<BR>
<font face=宋体>&nbsp;总注册用户数： <%=userNum%> 人 &nbsp; 发贴总数： <%=bbsNum%> 篇</font></td>
<td colspan=6 align=right> 
<select name=orders onchange='javascript:submit()'>
<option value=1 <%if (orders==1) {%>selected<%}%>>发贴总数Top10</option>
<option value=2 <%if (orders==2) {%>selected<%}%>>最新注册用户</option>
<option value=7 <%if (orders==7) {%>selected<%}%>>所有用户列表</option>
</select>
</td>
</tr></form>
<tr bgcolor=<%=tableTitleColor%> style=color:<%=tableFontColor%>> 
<td align=center><b>用户名</b></td>
<td align=center><b>Email</b></td>
<td align=center><b>OICQ</b></td>
<td align=center><b>主页</b></td>
<td align=center><b>短消息</td>
<td align=center><b>注册时间</b></td>
<td align=center><b>等级状态</b></td>
<td align=center><b>发贴总数</b></td>
<td align=center><b>
<% if (orders==4)
out.println("存款");
else if (orders==5)
out.println("百万富翁本月得分");
else if (orders==6)
out.println("百万富翁通关次数");
else
out.println("财产");

%>
</b></td>
</tr>


<%
	

		for (i=(Page-1)*20;i<Page*20;i++){
			if (i>=usersNum) break;
			User theUser=(User)users.get(i);
%>
<tr bgcolor=<%=tableBodyColor%>> 
<td>&nbsp;<a href="javascript:openScript('dispuser.jsp?name=<%=response.encodeURL(theUser.getUserName())%>',350,300)"><%=response.encodeURL(theUser.getUserName())%></a></td>
<td align=center><a href=mailto:<%=theUser.getUserEmail()%>><img border=0 src=<%=picURL%>email.gif></a></td>
<td align=center> 
<%if ("".equals(theUser.getOicq())|| theUser.getOicq()==null) {%>
没有 
<% }else{%>
<a href=http://search.tencent.com/cgi-bin/friend/user_show_info?ln=<%=theUser.getOicq()%> target=_blank><img src="<%=picURL%>oicq.gif" alt="查看 OICQ:<%=theUser.getOicq()%> 的资料" border=0 width=16 height=16></a> 
<%}%>
</td>
<td align=center> 
<%if (theUser.getHomePage()==null|| "".equals(theUser.getHomePage().trim())) {%>
没有 
<%}else{%>
<a href=<%=theUser.getHomePage()%> target=_blank><img border=0 src=<%=picURL%>homePage.gif></a> 
<%}%>
</td>
<td align=center><a href=javascript:openScript('usersms.jsp?action=new&touser=<%=response.encodeURL(theUser.getUserName())%>',600,400)><img src=<%=picURL%>message.gif border=0></a></td>
<td align=center><%=theUser.getAddDate()%></td>
<td align=center> <%=theUser.getUserClassStr()%><br>
</td>
<td align=center><%=theUser.getArticle()%></td>
<td align=center><%=theUser.getUserWealth()%></td>
</tr>
<%
		}
%>
</table>
</td></tr>
</table>
<table width=95% align="center" >
<tr><td align=right>
<%
	int totalPages=usersNum/20+1; 
if (Page==0)  Page=1;
out.println("共 "+totalPages+" 页 第 "+Page+" 页　");
if (Page==1|| totalPages==1 )
			out.println("<font color=gray>首页　前页</font>");
else
	out.println("<a href=?Page=1&orders="+orders+">首页</a>　<a href=?Page="+(Page-1)+"&orders="+orders+">前页</a>");
		
		
		if (Page==totalPages|| totalPages==1)
			out.println("　<font color=gray>后页　尾页</font>");
		else
			out.println("　<a href=?Page="+(Page+1)+"&orders="+orders+">后页</a>　<a href=?Page="+totalPages+"&orders="+orders+">尾页</a>");
		
%>
</td></tr>
<%	}
	catch(Exception e){
%>	
		<tr bgcolor=<%=tableBodyColor%>> 
<td colspan=9>　　还没有任何用户数据。</td>
</tr>
<%}	
%></table>

<%@ include file="foot.jsp"%>
<jsp:include page="INC/js.jsp"/>
