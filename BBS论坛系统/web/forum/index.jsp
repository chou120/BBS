<%@ page language="java"  contentType="text/html; charset=gb2312"%>
<%@ page import ="net.acai.database.DBConnect,
			java.text.SimpleDateFormat,
			java.sql.*,
			java.util.Vector,
			net.acai.ip.*"%>
<%@ include file="INC/const.jsp"%>
<%
	stats="论坛首页";
	
	SkinUtil.checkUserStats(request,response,stats);
%>


<%@ include file="INC/theme.jsp"%>
<TABLE border=0 width=95% align=center><TBODY>
<TR>
	<TD align=left><a href="<%=hostURL%>"><img border=0 height="150" src=<%=forumLogo%>></a>
	</TD>
    <TD Align=right>今日贴数：<font color=red><b><%=todayNum%></b></font>
			| 主题总数：<b><%=topicNum%></b> | 帖子总数：<b><%=bbsNum%></b><br>
				注册会员<B><%=userNum%></B> | 欢迎新会员 <a href=javascript:openUser('<%=net.ds.toGBK(lastUser)%>')>
				<font color=<%=alertFontColor%>><%=lastUser%></font></a> 加入 [<a href=toplist.jsp?orders=2>新进来宾</a>]
				<p><img src=pic/time.gif>  现在时间为<%=NDate%><img src=pic/newtopic.gif> <a href=queryresult.jsp?sType=3>查看新的贴子</a> <img src=pic/userlist1.gif> 
				<a href=toplist.jsp?orders=7>用户列表</a> <img src=pic/top1.gif> <a href=toplist.jsp?orders=1>发贴排行</a>
	</TD>
</TR></TBODY>
</TABLE>
<br>

<style>
	TABLE {BORDER-TOP: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 1px; }
	TD {BORDER-RIGHT: 0px; BORDER-TOP: 0px;  }
</style>

<table cellspacing=0 border=0 width=95% bgcolor="<%=tableBackColor%>" align=center><tr><td height=1></td></tr></table>
<table cellpadding=6 cellspacing=0 width=95% align=center  bordercolor=<%=tableBackColor%> border=1>
<TR><TD bgColor="<%=tableBodyColor%>" colSpan=8>
		<IMG align=absMiddle src=pic/gb.gif>  论坛消息广播:

	<%
	
	try{
		ForumNews forumNews=ForumNewsManager.getForumNews(forumID);
		out.println("<b><a href=announcements.jsp?forumID=0><ACRONYM TITLE="+forumNews.getTitle()+">"+forumNews.getTitle()+"</ACRONYM></a></b> ("+forumNews.getAddTime()+")" );
	}
	catch(ForumNewsNotFoundException e){
		out.println("<b><a href=announcements.jsp?forumID=0 target=_blank><ACRONYM TITLE=当前没有公告>当前没有公告</ACRONYM></a></b>("+NDate+")");
	}
	
	%>
	
</TD></TR></table>
<table cellpadding=6 cellspacing=0 width=95% align=center  bordercolor=<%=tableBackColor%> border=1>
<TR bgColor="<%=tableTitleColor%>">
        <TD  width=26><B><FONT COLOR="<%=tableFontColor%>">状态</font></b></TD>
        <TD vAlign=center ><B><FONT COLOR="<%=tableFontColor%>">论坛名称</FONT></B></TD>
        <TD vAlign=center align=middle width=80><B><FONT COLOR="<%=tableFontColor%>">版主</FONT></B></TD>
        <TD vAlign=center noWrap align=middle width=38><B><FONT COLOR="<%=tableFontColor%>">主题</FONT></B> </TD>
        <TD vAlign=center noWrap align=middle width=38><B><FONT COLOR="<%=tableFontColor%>">贴子</FONT></B> </TD>
        <TD vAlign=center noWrap align=middle width=168><B><FONT COLOR="<%=tableFontColor%>">最后发表</FONT></B> </TD>
        <TD vAlign=center align=middle width=26><B><FONT COLOR="<%=tableFontColor%>">收藏</FONT></B></TD>
</TR></table>
	<%
	try{
		Vector gateWayVector=GateWayFactory.getGateWays();
		for( i=0;i<gateWayVector.size();i++)
		{
    			GateWay gateWay=(GateWay)gateWayVector.get(i);
    			int gateWayID=gateWay.getGateWayID();
    			String gateWayName=gateWay.getGateWayName();
			out.println("<table cellpadding=6 cellspacing=0 width=95% align=center  bordercolor=\""+tableBackColor+"\" border=1>"+
        		"<TR><TD bgColor=\""+tableBodyColor+"\" colSpan=7><B>"+gateWayName+"</B></TD></TR>");
		
			try{
				Vector forumVector=ForumFactory.getForums(gateWayID);
				for(int j=0;j<forumVector.size();j++){
					Forum theForum=(Forum)forumVector.get(j);
					out.println("<TR><TD vAlign=top align=middle width=26 bgColor=\""+aTableBodyColor+"\">");
        				out.println(theForum.getForumIMG(lastLogin));
        				out.println("</TD><TD vAlign=top width=* bgColor=\""+tableBodyColor+"\"> <a href=\"list.jsp?forumID="+theForum.getForumID()+"\"><font color=#000066>"+theForum.getForumType()+"</font></a><br>");
					if (!theForum.getIndexIMG().equals(""))
						out.println("<table align=left><tr><td><img src="+theForum.getIndexIMG()+" align=top></td><td width=20></td></tr></table>");
					out.println(theForum.getReadMe());
					out.println("</TD><TD vAlign=center align=middle bgColor=\""+aTableBodyColor+"\" width=80>");
					String masterName=theForum.getForumMaster();
					if(masterName==null||"".equals(masterName))
						out.println("暂缺");
					else{
					String [] masterNames=theForum.getForumMaster().split("\\|");
					
					 masterName="";
					
					
					for(int k=0;k<masterNames.length;k++)
					{
						masterName=masterName+"<a href=\"javascript:openScript('dispuser.jsp?name="+masterNames[k]+"',350,300)\">"+masterNames[k]+"</a><br>" ;
						if(k>2){
							masterName=masterName + "<font color=#000066>More...</font>";
							break;
						}
					}
					out.println(masterName);
					}
					out.println("</TD>"+
					"<TD vAlign=center noWrap align=middle width=38 bgColor=\""+tableBodyColor+"\">"+theForum.getLastTopicNum()+"</TD>"+
        				"<TD vAlign=center noWrap align=middle width=38 bgColor=\""+tableBodyColor+"\">"+theForum.getLastBbsNum()+"</TD>"+
        				"<TD noWrap width=168 bgColor=\""+aTableBodyColor+"\">");
					if (theForum.getLastTopic()!=null&&!"".equals(theForum.getLastTopic())){
						out.println("<font color=#000066>主题：</font><a href='dispbbs.jsp?forumID="+theForum.getForumID()+"&rootID="+theForum.getLastRootID()+"&announceID="+theForum.getLastRootID()+"'>"+theForum.getLastTopic()+"</a><br>");
					out.println("<font color=#000066>最后发表：</font><a href=javascript:openScript('dispuser.jsp?name="+theForum.getLastPostUser()+"',350,300)>"+theForum.getLastPostUser()+"</a>   <IMG border=0 src=pic/lastpost.gif><br>"+theForum.getLastPostTime());
					}
					else
						out.println("现在还没有帖子");
					out.println("</TD><TD vAlign=center noWrap align=middle width=26 bgColor=\""+tableBodyColor+"\">"+
					"<A href=\"javascript:window.external.AddFavorite('"+forumURL+"list.jsp?forumID="+theForum.getForumClass()+"','"+forumName+"--"+theForum.getForumType()+"论坛（"+forumURL+"）')\" target=_self><img src=pic/fav.gif border=0></A>"+
					"</TD></TR>");
				}
			}
			catch(Exception e){
			}
			out.println("</table>");
		}
	}
	catch(Exception e){
	}
	out.println("<BR>");
	try{
		Vector forumLinkVector=new Vector();
		forumLinkVector=ForumLinkFactory.getForumLinks();
		if(!forumLinkVector.isEmpty()){
			out.println("<table cellspacing=0 border=0 width=95% bgcolor=\""+tableBackColor+"\" align=center><tr><td height=1></td></tr></table>"+
				"<table cellpadding=6 cellspacing=0 width=95% align=center  bordercolor=\""+tableBackColor+"\" border=1>"+
        			"<TR><TD bgColor=\""+tableTitleColor+"\" colSpan=2><b><FONT COLOR="+ tableFontColor +">友情论坛</font></b></TD></TR>");

			for( i=0;i<forumLinkVector.size();i++){
				ForumLink forumLink=(ForumLink)forumLinkVector.get(i);
				out.println("<TR>"+
        				"<TD vAlign=top align=middle width=26 bgColor=\""+aTableBodyColor+"\"><IMG src=pic/shareforum.gif> </TD>"+
        				"<TD vAlign=top bgColor=\""+tableBodyColor+"\">"+
					"<a href="+forumLink.getForumURL()+" target=_blank>"+forumLink.getForumName()+"</a><br>"+
					forumLink.getReadMe()+"</TD></TR>");
			}
	out.println("</table>");	
		}
	}
	catch(ForumLinkNotFoundException e)
	{
		e.printStackTrace();
	}
	

	out.println("<BR>"+
		"<table cellspacing=0 border=0 width=95% bgcolor=\""+tableBackColor+"\" align=center><tr><td height=1></td></tr></table>"+
		"<table cellpadding=6 cellspacing=0 width=95% align=center  bordercolor=\""+tableBackColor+"\" border=1>"+
	        "<TR><TD bgColor=\""+tableTitleColor+"\" colSpan=2><b><FONT COLOR="+ tableFontColor +">用户来访信息</font></b></TD></TR>"+
        	"<TR><TD vAlign=top align=middle width=26 bgColor=\""+aTableBodyColor+"\"><IMG align=absMiddle src=pic/inboxnonew.gif> </TD>"+
        	"<TD vAlign=top bgColor=\""+tableBodyColor+"\">");
		String ip=request.getRemoteAddr();
		String[] addr=IPLocalizer.search(request);
		out.println("您的ＩＰ 是："+ip+"，来自："+addr[0]+addr[1]+"，"+OLUser.getUserSystem(request.getHeader("User-Agent"))+", "+OLUser.getUserBrowser(request.getHeader("User-Agent")));
	out.println("</TD></TR></TABLE><br>");
      out.println("<table cellpadding=6 cellspacing=0 width=95% align=center  bordercolor=\""+tableBackColor+"\" border=1 style=\"word-break:break-all;\">"+
        "<TR><TD bgColor=\""+tableTitleColor+"\" colSpan=2><b><FONT COLOR="+ tableFontColor +">论坛在线统计</font></b>");
	if(!"online".equals(ParamUtil.getString(request,"action")))
		out.println("<FONT COLOR="+ tableFontColor +">[<a href=index.jsp?action=online><font color="+tableFontColor+">关闭详细列表</font></a>]</font>");
	else
		out.println("<FONT COLOR="+ tableFontColor +">[<a href=index.jsp><font color="+tableFontColor+">显示详细列表</font></a>]</font>");
	out.println("<FONT COLOR="+ tableFontColor +">[<a href=online.jsp><font color="+tableFontColor+">在线用户</font></a>]</font></TD></TR>"+
        "<TR><TD vAlign=top align=middle width=26 bgColor=\""+aTableBodyColor+"\"><IMG align=absMiddle src=pic/pmlogin.gif> </TD>"+
        "<TD vAlign=top bgColor=\""+tableBodyColor+"\">现在论坛上共有 <b>"+ForumFactory.getOLMemberUsersNum()+"</b> 位会员与 <b>"+ForumFactory.getOLGuestUsersNum()+"</b> 位客人，同时在线峰值<b>"+maxOnline  +"</b>，发生时刻<b>"+maxOnlineDate+"</b>。<br>");
out.println("<font color="+alertFontColor+">在线名单图例</font>：<img src="+picURL+picOM+"> 总坛主   ‖　<img src="+picURL+picOB+"> 论坛坛主   ‖   <img src="+picURL+picOV+"> 论坛贵宾   ‖   <img src="+picURL+picOH+"> 普通会员   ‖   <img src="+picURL+picOU+"> 客人或隐身会员<hr size=1><table width=100% border=0 cellspacing=0 cellpadding=0>");
	if(!"online".equals(ParamUtil.getString(request,"action"))){
		Vector OLUsers=ForumFactory.getOLUsers("member");
		for(i=0;i<OLUsers.size();i++){
			if(i%7==0) 
				out.println("<tr><td width=\"14%\">");
			else
				out.println("<td width=\"14%\">");
	
			
			OLUser theUser=(OLUser)OLUsers.get(i);
			System.out.println("+++++++++++++"+theUser.getStats());
			if (theUser.getUserClass().equals("总版主"))
				out.println( "<img src="+picURL+picOM+" alt=总坛主 width=12 height=11>&nbsp;");
			else if (theUser.getUserClass().equals("版主"))
				out.println( "<img src="+picURL+picOB+" alt=版主 width=12 height=11>&nbsp;");
			else if (theUser.getUserClass().equals("贵宾"))
				out.println( "<img src="+picURL+picOV+" alt=贵宾 width=12 height=11>&nbsp;");
			else
				out.println( "<img src="+picURL+picOH+" width=12 height=11>&nbsp;");
			out.println( "<a href=dispuser.jsp?name="+response.encodeURL(theUser.getUserName())+" target=_blank>");
	out.println( "<ACRONYM TITLE=\"目前位置："+theUser.getStats()+"<br>来访时间："+theUser.getStartTime()+"<br>活动时间："+theUser.getLastTimeBK()+"<br>"+theUser.getUserSystem()+"<br>"+theUser.getUserBrowser());
	out.println( "<br>真 实 IP：");
	if(("0").equals(ipFlag)){
		if (forumMaster || master){ 
			if (theUser.getUserIP()!=null)
			out.println(theUser.getUserIP().trim());
		}
        else
		out.println( "已设置保密");
	}	
	else
		if (theUser.getUserIP()!=null)
			out.println(theUser.getUserIP().trim());
    out.println( "<br>来源鉴定：");
	if (fromFlag.equals("0")){
		if (forumMaster || master){ 
			if (theUser.getComeFrom()!=null)
			out.println(theUser.getComeFrom());
		}
        else
		out.println( "已设置保密");
	}
	else
		if (theUser.getComeFrom()!=null)
			out.println(theUser.getComeFrom());
	out.println( "\">");
	out.println(theUser.getUserName());
	
	out.println( "</ACRONYM></a>&nbsp;");
	
	out.println( "</td>");
	if((i+1)%7==0&&i!=0)  out.println( "</tr>");
	


		}
	OLUsers=ForumFactory.getOLUsers("guest");
		for(i=0;i<OLUsers.size();i++){
			if(i%7==0) 
				out.println("<tr><td width=\"14%\">");
			else
				out.println("<td width=\"14%\">");
	
			
			OLUser theUser=(OLUser)OLUsers.get(i);
				out.println( "<img src="+picURL+picOU+" width=12 height=11>&nbsp;");
			out.println( "<a href=dispuser.jsp?name="+response.encodeURL(theUser.getUserName())+" target=_blank>");
	out.println( "<ACRONYM TITLE=\"目前位置："+theUser.getStats()+"<br>来访时间："+theUser.getStartTime()+"<br>活动时间："+theUser.getLastTimeBK()+"<br>"+theUser.getUserSystem()+"<br>"+theUser.getUserBrowser());
	out.println( "<br>真 实 IP：");
    if(("0").equals(ipFlag)){
		if (forumMaster || master){ 
			if (theUser.getUserIP()!=null)
			out.println(theUser.getUserIP().trim());
		}
        else
		out.println( "已设置保密");
	}	
	else
		if (theUser.getUserIP()!=null)
			out.println(theUser.getUserIP().trim());
    out.println( "<br>来源鉴定：");
	if (fromFlag.equals("0")){
		if (forumMaster || master) {
			if (theUser.getComeFrom()!=null)
			out.println(theUser.getComeFrom());
		}
        else
		out.println( "已设置保密");
	}
	else
		if (theUser.getComeFrom()!=null)
			out.println(theUser.getComeFrom());
	out.println( "\">");
	out.println(theUser.getUserName());
	
	out.println( "</ACRONYM></a>&nbsp;");
	
	out.println( "</td>");
	if((i+1)%7==0&&i!=0)  out.println( "</tr>");
	


		}

	}
	else
		out.println("[<a href=index.jsp>显示详细列表</a>]");
	
		
out.println("</table></TD></TR></TABLE><br>");
stats="论坛首页";

out.println("<table cellspacing=0 cellpadding=0 width=95% bgcolor=\""+tableBackColor+"\" align=center border=0>"+
	"<tr><td><table cellspacing=1 cellpadding=3 width=100% border=0>"+
	"<tr><td width=75%  bgcolor="+ tableTitleColor +"><font color="+ tableFontColor +">"+
	"<b>　-=> "+ forumName +"图例</b></font></td>"+
	"<td align=right noWrap bgcolor="+ tableTitleColor +" width=\"25%\"><FONT COLOR="+ tableFontColor +">所有时间均为 - 北京时间  </font.</td></tr>"+
	"<tr><td bgcolor="+ tableBodyColor +" colspan=3>"+
	"<table cellspacing=4 cellpadding=0 width=92% border=0 align=center>"+
	"<tr><td colspan=6>论坛图例仅当你登陆并且上次访问后才显示  （您必须登陆才能查看详情，否则只显示该论坛的无新贴图例）</font></div></td>"+
	"<td align=center rowspan=2><img src=pic/logo_1.gif border=0></td></tr>"+
	"<tr><td><font color="+ alertFontColor +" TITLE=允许注册会员发言和回复>常规论坛</font></td>"+
	"<td><font color="+ alertFontColor +" TITLE=只允许登陆用户浏览发言和回复>正规论坛</font></td>"+
	"<td><font color="+ alertFontColor +" TITLE=允许任何人发言和回复>开放论坛</font></td>"+
	"<td><font color="+ alertFontColor +" TITLE=允许坛主和版主发言，其他注册用户只能回复>评论论坛</font></td>"+
	"<td><font color="+ alertFontColor +" TITLE=允许拥有访问密码或已经经过认证的注册会员发言>认证论坛</font></td>"+
	"<td><font color="+ alertFontColor +">特殊论坛</font></td></tr>"+
	"<tr><td><img src=pic/foldernew.gif width=13 height=16> 有新的贴子</td>"+
	"<td><img src=pic/foldernew.gif width=13 height=16> 有新的贴子</td>"+
	"<td><img src=pic/folderallnew.gif width=13 height=16> 有新的贴子</td>"+
	"<td><img src=pic/follownew.gif width=13 height=16> 有新的贴子</td>"+
	"<td><img src=pic/lock_l.gif width=13 height=16> 有新的贴子</td>"+
	"<td><img src=pic/jinghua.gif width=13 height=16 TITLE=只允许坛主和版主发言和操作> 只读精华区</td>"+
	"<td align=center valign=top rowspan=2><a href=http://SuperSpace.yeah.net target=_blank "+
	"title=\"---------------------    ☆☆☆☆☆    ---------------------&#13;&#10;"+
	" UJBB论坛由 SuperSpace.java制作&#13;&#10;"+
	" 正版标示： Powered By SuperSpace.yeah.net &#13;&#10;"+
	" 感谢您采用我们的论坛，让我们做的更好！&#13;&#10;"+
	"---------------------    ☆☆☆☆☆    ---------------------\"><img src=pic/logo_2.gif border=0></a></td></tr>"+
	"<tr><td><img src=pic/ifolder.gif width=13 height=16> 没有新贴子</td>"+
	"<td><img src=pic/ifolder.gif width=13 height=16> 没有新贴子</td>"+
	"<td><img src=pic/folderall.gif width=13 height=16> 没有新贴子</td>"+
	"<td><img src=pic/follow.gif width=13 height=16> 没有新贴子</td>"+
	"<td><img src=pic/lock_b.gif width=13 height=16> 没有新贴子</td>"+
	"<td><img src=pic/shareforum.gif width=16 height=16 TITLE=和本论坛友情链接的联盟论坛> 联盟论坛区</td></tr>"+
	"</table></td></tr></table></td></tr></table></CENTER>");



%>
<jsp:include page="INC/js.jsp"/>
<%@ include file="foot.jsp"%>
