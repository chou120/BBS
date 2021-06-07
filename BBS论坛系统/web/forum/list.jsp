<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="net.acai.util.*,
		 net.acai.forum.*,
		 net.acai.forum.util.*,
		 java.util.Vector"%>
<%@ include file="INC/const.jsp"%>
<%
	
	int perPage=ParamUtil.getInt(request,"perPage",25);
	int Page=ParamUtil.getInt(request,"Page",1);
	int startPage=((Page-1)/10)*10+1;
	int start=(Page-1)*perPage+1;
	try{
		Forum theForum=ForumFactory.getForum(request,response,session,forumID);
		stats=theForum.getForumType();
		
	%>
<%@ include file="INC/theme.jsp"%>
<script language=javascript src="INC/list.js"></script>


<%	out.println(headLine(forumID,forumName,forumLogo,theForum.getForumType(),1,stats));
	%>
	<script language="javascript">
var AutoRegStr="";
var IsRoot = false;
</script>
	<script language="javascript" src="js/Adv.js"></script>
<script language="javascript" src="js/CheckClick.js"></script>
<script language="javascript">Adv("","","","<a href=list.jsp?forumID=<%=forumID%>><img src=pic/ad.gif alt=<%=forumName%> border=0></a>","提示信息");</script>
<script language="javascript">Adv("","");</script>
<TABLE cellSpacing=0 cellPadding=0 width=95% border=0 align=center>
<TBODY><tr>
	<td align=center width=34 valign=middle> <img src='pic/gb.gif' border=0 alt=本分论坛的公告！不可不看！！ width=20 height=17> 

	</td>
	<td valign=middle align=left>
	<%
	try{
		ForumNews forumNews=ForumNewsManager.getForumNews(forumID);
		out.println("<b><a href=announcements.jsp?forumID="+forumID+"><ACRONYM TITLE="+forumNews.getTitle()+">"+forumNews.getTitle()+"</ACRONYM></a></b> ("+forumNews.getAddTime()+")" );
	}
	catch(ForumNewsNotFoundException e){
		out.println("<b><a href=announcements.jsp?forumID="+forumID+" target=_blank><ACRONYM TITLE=当前没有公告>当前没有公告</ACRONYM></a></b>("+NDate+")");
	}
	%>

	</td>
	<td align=right valign=middle><p>
		<form action=list.jsp method=get>
		<input type=hidden name=forumID value=<%=forumID%>>
		<select name=selTimeLimit onchange='javascript:submit()'>
			<option value=all>查看所有的主题
			<option value=1>查看一天内的主题
			<option value=2>查看两天内的主题
			<option value=7>查看一星期内的主题
			<option value=15>查看半个月内的主题
			<option value=30>查看一个月内的主题
			<option value=60>查看两个月内的主题
			<option value=180>查看半年内的主题
		</select>
		</form></p></td></tr></TBODY></TABLE>
<table cellspacing=0 border=0 width=95% bgcolor="<%=tableBackColor%>" align=center>
	<tr><td height=1></td></tr></table>
<TABLE border=1 cellpadding=0 cellspacing=0 width=95% align=center bordercolor=<%=tableBackColor%>>
  <TBODY><TR>
  	<TD height=27 width="95%" bgColor=<%=tableTitleColor%>><font color=<%=tableFontColor%>>目前论坛总在线<b><%=ForumFactory.getOLUsersNum()%></b>人，其中<%=theForum.getForumType()%>上共有 <b><%=theForum.getForumOLMemberUsersNum()%></b> 位会员与 <b><%=theForum.getForumOLGuestUsersNum()%></b> 位客人.今日贴子 <font color="<%=alertFontColor%>"><b><%=theForum.getTodayNum()%></b></font>
<%

if(!"online".equals(ParamUtil.getString(request,"action")))
	out.println( "[<a href=list.jsp?action=online&forumID="+forumID+"><font color="+tableFontColor+">关闭详细列表</font></a>]");
else
	out.println( "[<a href=list.jsp?forumID="+forumID+"><font color="+tableFontColor+">显示详细列表</font></a>]");


out.println( "&nbsp;[<a href=online.jsp?forumID="+forumID+"><font color="+tableFontColor+">在线用户</font></a>]</TD><TD bgColor="+tableTitleColor+" width=\"5%\" align=center><a href='list.jsp?forumID="+ forumID+"&Page=1&skin="+ParamUtil.getString(request,"skin","")+"'>"+
				"<img src='pic/refresh_1.gif' border=0 alt='刷新'></a></TD></TR>");

if (!"online".equals(ParamUtil.getString(request,"action"))){
out.println( "<tr><td colspan=2 bgcolor="+tableBodyColor+"><table cellpadding=6 cellspacing=1 border=0 width=\"100%\" style=\"word-break:break-all;\">");
		Vector OLUsers=ForumFactory.getOLUsers("member");
		for(i=0;i<OLUsers.size();i++){
			OLUser theUser=(OLUser)OLUsers.get(i);
			
			if(theUser.getStats().indexOf(theForum.getForumType())<0)
				continue;
			
			if(i%7==0) 
				out.println("<tr><td width=\"14%\">");
			else
				out.println("<td width=\"14%\">");
	
			
			if (theUser.getUserClass().equals("总版主"))
				out.println( "<img src="+picURL+picOM+" alt=总坛主 width=12 height=11>&nbsp;");
			else if (theUser.getUserClass().equals("版主"))
				out.println( "<img src="+picURL+picOB+" alt=版主 width=12 height=11>&nbsp;");
			else if (theUser.getUserClass().equals("贵宾"))
				out.println( "<img src="+picURL+picOV+" alt=贵宾 width=12 height=11>&nbsp;");
			else
				out.println( "<img src="+picURL+picOH+" width=12 height=11>&nbsp;");
			out.println( "<a href=dispuser.jsp?name="+response.encodeURL(theUser.getUserName())+" target=_blank>");
	out.println( "<ACRONYM TITLE=\"目前位置："+response.encodeURL(theUser.getStats())+"<br>来访时间："+theUser.getStartTime()+"<br>活动时间："+theUser.getLastTimeBK()+"<br>"+theUser.getUserSystem()+"<br>"+theUser.getUserBrowser());
	out.println( "<br>真实ＩＰ：");
    if(("0").equals(ipFlag)){
		if (forumMaster || master) {
			if (theUser.getUserIP()!=null)
			out.println(theUser.getUserIP());
		}
        else
		out.println( "已设置保密");
	}	
	else
		if (theUser.getUserIP()!=null)
			out.println(theUser.getUserIP());
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
	out.println(response.encodeURL(theUser.getUserName()));
	
	out.println( "</ACRONYM></a>&nbsp;");
	
	out.println( "</td>");
	if(i%7==0)  out.println( "</tr>");
	


		}

out.println( "</TABLE></tr>");
}
out.println( "</TBODY></TABLE>");

out.println( "<br><table cellpadding=0 cellspacing=0 border=0 width=95% align=center><tr>"+
			"<td align=center width=2 valign=middle> </td>"+
			"<td align=left valign=middle> <a href='announce.jsp?forumID="+ forumID +"'>"+
			"<img src='pic/post.gif' border=0 alt='发新帖'></a>"+
			"&nbsp;&nbsp;<a href='vote.jsp?forumID="+forumID+"'>"+
			"<img src='pic/newpoll.gif' border=0 alt='发起新投票'></a></td>"+
			"<td align=right> ");
			if ((forumMaster&&theForum.getForumMaster().indexOf(userName)>-1)||master)			
			out.println( "　 <b><a href='admin_boardaset.jsp?forumID="+ forumID +"'>版务管理</a>");
						
out.println( "<b><a href='elist.jsp?forumID="+forumID +"'>论坛精华</a>　 "+
			"论坛版主</b>：");
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
					out.println("</td></tr></table>");
	try{
		Vector forumTopics=theForum.getForumTopics(forumID,start,Page);

%>	
<table cellspacing=0 border=0 width=95% bgcolor="<%=tableBackColor%>" align=center><tr><td height=1></td></tr></table>
				<TABLE style=color:"&tableFontColor&"  border=1 cellPadding=0 cellSpacing=0 width=95% align=center bordercolor="<%=tableBackColor%>">
  				<TBODY>
				<TR align=middle>
				<TD height=27 width=32 bgColor="<%=tableTitleColor%>"><font color="<%=tableFontColor%>">状态</TD> 
				<TD bgColor="<%=tableTitleColor%>" width=*><font color="<%=tableFontColor%>">主 题  (点<img src=pic/plus.gif>即可展开贴子列表)</TD>
				<TD bgColor="<%=tableTitleColor%>" width=80><font color="<%=tableFontColor%>">作 者</TD>
				<TD bgColor="<%=tableTitleColor%>" width=64><font color="<%=tableFontColor%>">回复/人气</TD>
				<TD bgColor="<%=tableTitleColor%>" width=210><font color="<%=tableFontColor%>">最后更新 | 回复人</TD>
				</TR> 
				</TBODY></TABLE>
		<%
		for( i=0;i<forumTopics.size();i++){
			ForumTopic forumTopic=(ForumTopic)forumTopics.get(i);
		%>

<TABLE style=color:"<%=tableContentColor%>" border=1 cellPadding=0 cellSpacing=0 width=95% align=center bordercolor="<%=tableBackColor%>">
				<TBODY><TR align=middle>
				<TD bgColor="<%=aTableBodyColor%>" width=32 height=27>

<%
if(!forumTopic.getLockTopic()&&!forumTopic.getIsTop()&&!forumTopic.getIsVote()&&!forumTopic.getIsBest()&&!(forumTopic.getChildNum()>10))
	out.println( "<img src=\"pic//folder.gif\" alt=开放主题>");
else if(forumTopic.getIsVote())
	out.println("<img src=\"pic//closedb.gif\" alt=投票贴子>");
else if(forumTopic.getIsTop())
	out.println("<img src=\"pic//istop.gif\" alt=固顶主题>");
else if(forumTopic.getIsBest())
	out.println("<img src=\"pic//isbest.gif\" alt=精华帖子>");
else if(forumTopic.getChildNum()>10)
	out.println("<img src=\"pic//hotfolder.gif\" alt=热门主题>");
else if(forumTopic.getLockTopic())
	out.println("<img src=\"pic//lockfolder.gif\" alt=本主题已锁定>");
else
	out.println("<img src=\"pic//folder.gif\" alt=开放主题>");

%>
	</TD>
	<TD align=left bgcolor="<%=tableBodyColor%>" width=* onmouseover=javascript:this.bgColor='<%=aTableBodyColor%>' onmouseout=javascript:this.bgColor='<%=tableBodyColor%>'>
<%
if (forumTopic.getChildNum()==0)
	out.println("<img src='"+picURL +"nofollow.gif' id='followImg"+forumTopic.getRootID()+"'>");
else
	out.println("<img loaded=no src='"+picURL +"plus.gif' id='followImg"+forumTopic.getRootID()+"'   style='cursor:hand;'  onclick='loadThreadFollow("+forumTopic.getRootID()+","+forumTopic.getAnnounceID()+","+forumID+")' title=展开贴子列表>");
	

	
out.println("<a href=\"dispbbs.jsp?forumID="+forumID+"&rootID="+forumTopic.getRootID()+"&announceID="+forumTopic.getAnnounceID()+"\" title=\"《"+ forumTopic.getNoFilterTopic()+"》<br>作者："+forumTopic.getUserName()+"<br>发表于"+forumTopic.getDateAndTime()+"<br>最后跟贴："+response.encodeURL(forumTopic.getFollowMSG())+"...\">");
out.println(forumTopic.getNoFilterTopic());
out.println("</a>");

%>	</TD>
	<TD bgColor="<%=aTableBodyColor%>" width=80><a href=javascript:openUser('<%=forumTopic.getUserName()%>')><%=forumTopic.getUserName()%></a></TD>
	<TD bgColor="<%=tableBodyColor%>" width=64>
	<font color="<%=tableContentColor%>"><%=forumTopic.getChildNum()%>/<%=forumTopic.getHits()%></font>
	</TD>
	<TD align=left bgColor="<%=aTableBodyColor%>" width=210>
	&nbsp;<a href=dispbbs.jsp?forumID=<%=forumID%>&rootID=<%=forumTopic.getRootID()%>&id=<%=forumTopic.getTimes()%>>
						<%=forumTopic.getFollowDateAndTime()%>
						</a>&nbsp;<font color=#990000>|</font>&nbsp;
		
		<a href=javascript:openUser('<%=forumTopic.getFollowUser()%>')><%=forumTopic.getFollowUser()%></a>

	</TD></TR>
	<tr style=display:none id='follow<%=forumTopic.getAnnounceID()%>'><td colspan=5 id='followTd<%=forumTopic.getAnnounceID()%>' style=padding:0px><div style='width:240px;margin-left:18px;border:1px solid black;background-color:lightyellow;color:black;padding:2px' onclick=loadThreadFollow(<%=forumTopic.getAnnounceID()%>)>正在读取关于本主题的跟贴，请稍侯……</div></td></tr>
</TBODY></TABLE>
<%

		}
	}
	catch(ForumTopicNotFoundException e)
	{
	e.printStackTrace();
	out.println("没有帖子!");
	}
	int forumTopicNum=theForum.getForumTopicNum();
	int totalPage=forumTopicNum/perPage+1;
	%>
<table border=0 cellpadding=0 cellspacing=3 width=95% align=center >
	<form method=post action=list.jsp name=frmList2 >
		<input type=hidden name=selTimeLimit value="">
	<tr>
		<td valign=middle><span class=smallFont >页次：<strong><%=Page%></strong>/<strong><%=totalPage%></strong>页 每页<strong><%=perPage%></strong> 主题数<strong><%=forumTopicNum%></strong></td><td valign=middle><div align=right ><p>分页：
	<%
	if (startPage>10) 
	out.println("<a href='list.jsp?forumID="+forumID+"&Page="+(startPage-1)+"' >[<<]</a>");
	
	for(i=startPage;i<startPage+10;i++){
		if (i==Page)
		   	out.println("<font color=gray>["+i+"]</font> ");
	  	else
	      		out.println("<a href='list.jsp?forumID="+forumID+"&Page="+i+"' >["+i+"]</a>   ");
		   
		if(i==totalPage) break;
	}
	if(i<totalPage)
		out.println("<a href='list.jsp?forumID="+forumID+"&Page="+i+"'>[>>]</a>   ");

		out.println("<span class=smallFont >转到:<input type=text name=Page size=3 maxlength=10  value='"+ Page+"'><input type='submit' value=Go   id=button1 name=button1 ></span></p>"+     
					"</div></td></tr>"+
					"<input type=hidden name=forumID value='"+ forumID +"'>"+
					"</form></table>");

%>


<table border=0 cellpadding=0 cellspacing=3 width=95% align=center>
			<tr>
			<td valign=middle nowrap> <div align=right>
			<select  onchange="if(this.options[this.selectedIndex].value!=''){location=this.options[this.selectedIndex].value;}">
			<option value=''>论坛跳转至...</option>
<%
	try{
		Vector gateWayVector=GateWayFactory.getGateWays();
		for( i=0;i<gateWayVector.size();i++)
		{
    			GateWay gateWay=(GateWay)gateWayVector.get(i);
    			int gateWayID=gateWay.getGateWayID();
    			String gateWayName=gateWay.getGateWayName();
				out.println("<option style=BACKGROUND-COLOR:#99ccff>╋ "+gateWayName+"</option>");
				try{
					Vector forumVector=ForumFactory.getForums(gateWayID);
					for(int j=0;j<forumVector.size();j++){
						Forum theListForum=(Forum)forumVector.get(j);
						out.println("<option value=\"list.jsp?forumID="+theListForum.getForumID()+"\">　├"+theListForum.getForumType()+"</option>");
					}
				}
				catch(Exception e){
					e.printStackTrace();
				}
		}
	}
	catch(Exception e){
		e.printStackTrace();
	}
	%>
			

	
	</select><div></td></tr></form></table>



<table cellspacing=0 cellpadding=0 width=95% align=center bgcolor="<%=tableBackColor%>" border=0>
				<tr><td><table cellspacing=1 cellpadding=3 width=100% border=0><tr bgcolor="<%=tableTitleColor%>">
				<td width=80% ><font color="<%=tableFontColor%>"><b>　-=> <%=forumName%>图例</b></font></td>
				<td noWrap width=20% align=right><font color="<%=tableFontColor%>">所有时间均为 - 北京时间 &nbsp;</td>
				</tr><tr><td colspan=3 bgcolor="<%= tableBodyColor%>">
				<table cellspacing=4 cellpadding=0 width=92% border=0 align=center>
				<tr><td><img src=pic/folder.gif> 开放的主题</td>
				<td><img src=pic/hotfolder.gif> 回复超过10贴</td>
				<td><img src=pic/lockfolder.gif> 锁定的主题</td>
				<td><img src=pic/istop.gif> 固定顶端的主题 </td>
				<td> <img src=pic/isbest.gif> 精华帖子 </td>
				</tr><tr><td width=100% colspan=5>
<%
if (theForum.getStrAllowHTML())
	out.println( "HTML标签：<font color=#003399>ON</font>.");
else
	out.println( "HTML标签：<font color=#990000>OFF</font>.");


if (!theForum.getStrAllowForumCode())
	out.println( " UBB标签：<font color=#990000>OFF</font>.");
else
	out.println( " UBB标签：<font color=#003399>ON</font>.");


if (!theForum.getStrIcons())
	out.println( " 贴图标签：<font color=#990000>OFF</font>.");
else
	out.println( " 贴图标签：<font color=#003399>ON</font>.");


if (!theForum.getStrFlash())
	out.println( " Flash标签：<font color=#990000>OFF</font>.");
else
	out.println( " Flash标签：<font color=#003399>ON</font>.");


if (!theForum.getStrIMGInPosts())
	out.println( " 表情字符转换：<font color=#990000>OFF</font>.");
else
	out.println( " 表情字符转换：<font color=#003399>ON</font>.");


if (!"1".equals(uploadFlag)) 
	out.println( " 头像上传：<font color=#990000>OFF</font>.");
else
	out.println( " 头像上传：<font color=#003399>ON</font>.");


if (!"1".equals(titleFlag))
	out.println( " 用户头衔：<font color=#990000>OFF</font>.");
else
	out.println( " 用户头衔：<font color=#003399>ON</font>.");

%>
</td></tr></table></td></tr></table></td></tr></table><BR>
	

<% 	}
	catch(ForumNotFoundException e){
		e.printStackTrace();
	}
%>
<%@ include file="foot.jsp"%>
<iframe width=0 height=0 src="" id="hiddenframe"></iframe>
