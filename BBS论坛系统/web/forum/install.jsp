<%@ page contentType="text/html;charset=GBK" %>
<%@ page import="net.acai.forum.*,
				net.acai.database.*,
		 net.acai.util.*"%>
<html>
<head>
<title>清清论坛安装论坛</title></head>
<link rel="stylesheet" type="text/css" href="forum.css">

<BODY bgcolor="#ffffff" alink="#333333" vlink="#333333" link="#333333" topmargin="20">
<%
	String action=ParamUtil.getString(request,"action","1");
	if(action.equals("1")){
%>

请您先启动SQLServer2000的服务，然后安装数据库bbs,建立用户bbs,密码bbs<br>
其次修改web-inf/classes/db.properties文件，红色部分为您要修改的<br>
当您重新修改了db.properties请您注意要<font color=red size=4>重新启动Tomcat 5.0服务器</font>！！！！<br>
 <font color=green>//////////////////////////////////////////////////////////////////////////</font><br>
 <br>
drivers=com.microsoft.jdbc.sqlserver.SQLServerDriver<br>
logfile=<font color=red>c:\\log.txt</font> <br>
#修改数据库名称<br>
mysql.url=jdbc:microsoft:sqlserver://localhost:1433;DatabaseName=<font color="red">bbs</font><br>
#修改数据库的最大连接数量<br>
mysql.maxconn=<font color=red>100</font><br>
#修改数据库的用户名称<br>
mysql.user=<font color="red">bbs</font><br>
#修改数据库的用户的密码<br>
mysql.password=<font color=red>bbs</font><br>
<font color=green>//////////////////////////////////////////////////////////////////////////</font>

<form action="">
<input type="hidden" name="action" value="2">
<input type=submit value="测试数据源">
</form>
<%
	}
	else if(action.equals("2")){
		try{
			DBConnect dbc=new DBConnect();
			out.println("数据库连接成功！");
			%>
				<form action="">
				<input type="hidden" name="action" value="3">
				<input type="submit" value="现在创建数据表!">
				</form>
				<%
		}
		catch(Exception e){
			out.print("数据库连接失败，具体错误，请您查看您的日志文件！(log.txt)");
			return;
		}
	}
	else if(action.equals("3")){
		try{
			DBConnect dbc=new DBConnect();
			String sql;
			sql="if exists (select * from dbo.sysobjects where id = object_id(N'[bbs].[config]') and OBJECTPROPERTY(id,N'IsUserTable') = 1)\ndrop table [bbs].[config]\n";
			out.println("正在删除数据表格config<br>");
			dbc.executeUpdate(sql);
			out.println("删除成功<br>");
			sql="CREATE TABLE bbs.config (\n  ForumName varchar(20) NOT NULL default '',\n  ForumURL varchar(100) NOT NULL default '',\n  CompanyName varchar(40) NOT NULL default '',\n  HostUrl varchar(100) NOT NULL default '',\n  SMTPServer varchar(100) NOT NULL default '',\n  SystemEmail varchar(50) NOT NULL default '',\n  TimeAdjust varchar(10) NOT NULL default '',\n  ScriptTimeOut varchar(10) NOT NULL default '',\n  Logo varchar(100) NOT NULL default '',\n  Picurl varchar(50) NOT NULL default '',\n  Faceurl varchar(50) NOT NULL default '',\n  EmailFlag numeric(11,0) NOT NULL default '0',\n  Uploadpic numeric(11,0) NOT NULL default '0',\n  IpFlag numeric(11,0) NOT NULL default '0',\n  FromFlag numeric(11,0) NOT NULL default '0',\n  guestuser numeric(11,0) NOT NULL default '0',\n  guestlogin numeric(11,0) NOT NULL default '0',\n  openmsg varchar(20) NOT NULL default '',\n  badwords varchar(255) NOT NULL default '',\n  AnnounceMaxBytes varchar(20) NOT NULL default '',\n  MaxAnnouncePerPage varchar(15) NOT NULL default '',\n  Maxtitlelist varchar(15) NOT NULL default '',\n  Tablebackcolor varchar(15) NOT NULL default '',\n  aTablebackcolor varchar(15) NOT NULL default '',\n  Tabletitlecolor varchar(15) NOT NULL default '',\n  aTabletitlecolor varchar(15) NOT NULL default '',\n  Tablebodycolor varchar(15) NOT NULL default '',\n  aTablebodycolor varchar(15) NOT NULL default '',\n  TableFontcolor varchar(15) NOT NULL default '',\n  TableContentcolor varchar(15) NOT NULL default '',\n  AlertFontColor varchar(15) NOT NULL default '',\n  ContentTitle varchar(15) NOT NULL default '',\n  ads1 varchar(2000) NOT NULL,\n  ads2 varchar(2000) NOT NULL,\n  Copyright varchar(255) NOT NULL default '',\n  Version varchar(255) NOT NULL default '',\n  TitleFlag numeric(3,0)  NOT NULL default '0',\n  uploadFlag numeric(3,0)  NOT NULL default '0',\n  wealthReg numeric(11,0) NOT NULL default '0',\n  wealthAnnounce numeric(11,0) NOT NULL default '0',\n  wealthReannounce numeric(11,0) NOT NULL default '0',\n  wealthDel numeric(11,0) NOT NULL default '0',\n  wealthLogin numeric(11,0) NOT NULL default '0',\n  epReg numeric(11,0) NOT NULL default '0',\n  epAnnounce numeric(11,0) NOT NULL default '0',\n  epReannounce numeric(11,0) NOT NULL default '0',\n  epDel numeric(11,0) NOT NULL default '0',\n  epLogin numeric(11,0) NOT NULL default '0',\n  cpReg numeric(11,0) NOT NULL default '0',\n  cpAnnounce numeric(11,0) NOT NULL default '0',\n  cpReannounce numeric(11,0) NOT NULL default '0',\n  cpDel numeric(11,0) NOT NULL default '0',\n  cpLogin numeric(11,0) NOT NULL default '0',\n  TopicNum numeric(11,0) NOT NULL default '0',\n  BbsNum numeric(11,0) NOT NULL default '0',\n  TodayNum numeric(11,0) NOT NULL default '0',\n  UserNum numeric(11,0) NOT NULL default '0',\n  lastUser varchar(50) NOT NULL default '',\n  cookiepath varchar(50) NOT NULL default '',\n  Maxonline numeric(11,0) NOT NULL default '0',\n  MaxonlineDate varchar(50) NOT NULL default ''\n)  ON [PRIMARY]\n";
			out.println("正在创建数据表config!<br>");
			dbc.executeUpdate(sql);
			out.println("创建成功！<br>");
			sql="if exists (select * from dbo.sysobjects where id = object_id(N'[bbs].[bbs1]') and OBJECTPROPERTY(id,N'IsUserTable') = 1)\ndrop table [bbs].[bbs1]\n";
			
			out.println("正在删除论坛的文章表bbs1<br>");
			dbc.executeUpdate(sql);
			out.println("删除成功<br>");
			sql="\nCREATE TABLE bbs.bbs1 (\n  AnnounceID numeric(11,0) IDENTITY (1, 1) NOT NULL,\n  ParentID numeric(11,0) NOT NULL default '0',\n  Child numeric(11,0) NOT NULL default '0',\n  BoardID numeric(11,0) NOT NULL default '0',\n  UserName varchar(50) NOT NULL default '',\n  UserEmail varchar(255) NOT NULL default '',\n  Topic varchar(255) NOT NULL default '',\n  Body varchar(2000) NOT NULL,\n  DateAndTime datetime NOT NULL default '0000-00-00 00:00:00',\n  hits numeric(11,0) NOT NULL default '0',\n  length numeric(11,0) NOT NULL default '0',\n  RootID numeric(11,0) NOT NULL default '0',\n  layer numeric(11,0) NOT NULL default '0',\n  orders numeric(11,0) NOT NULL default '0',\n  isbest numeric(11,0) NOT NULL default '0',\n  ip varchar(20) NOT NULL default '',\n  Expression varchar(255) NOT NULL default '',\n  times numeric(11,0) NOT NULL default '0',\n  locktopic numeric(11,0) NOT NULL default '0',\n  signflag numeric(11,0) NOT NULL default '0',\n  emailflag numeric(11,0) NOT NULL default '0',\n  istop numeric(11,0) NOT NULL default '0',\n  isvote numeric(11,0) NOT NULL default '0'\n)  ON [PRIMARY]\n";
			out.println("正在创建论坛文章表格bbs1<br>");
			dbc.executeUpdate(sql);
			out.println("创建数据表格bbs1成功！<br>");

			sql="if exists (select * from dbo.sysobjects where id = object_id(N'[bbs].[bbslink]') and OBJECTPROPERTY(id,N'IsUserTable') = 1)\ndrop table [bbs].[bbslink]\n";
			out.println("正在删除数据表格bbslink<br>");
			dbc.executeUpdate(sql);
			out.println("删除成功<br>");
			sql="cREATE TABLE bbs.bbslink (\n  id numeric(11,0) IDENTITY (1, 1) NOT NULL,\n  boardname char(50) NOT NULL default '',\n  readme char(255) NOT NULL default '',\n  url char(150) NOT NULL default ''\n)  ON [PRIMARY]";
			out.println("正在创建数据表格bblink<br>");
			dbc.executeUpdate(sql);
			out.println("创建成功！<br>");

			sql="if exists (select * from dbo.sysobjects where id = object_id(N'[bbs].[bbsnews]') and OBJECTPROPERTY(id,N'IsUserTable') = 1)\ndrop table [bbs].[bbsnews]\n";
			out.println("正在删除数据表格bbsnews<br>");
			dbc.executeUpdate(sql);
			out.println("删除成功！<br>");
			sql="CREATE TABLE bbs.bbsnews (\n  id numeric(11,0) IDENTITY (1, 1) NOT NULL,\n  boardid numeric(11,0) NOT NULL default '0',\n  title varchar(50) NOT NULL default '',\n  content varchar(2000) NOT NULL,\n  username varchar(50) NOT NULL default '',\n  addtime datetime NOT NULL default '0000-00-00 00:00:00'\n)  ON [PRIMARY]\n";
			out.println("正在创建数据表格bbsnews<br>");
			dbc.executeUpdate(sql);
			out.println("创建成功！<br>");

			
			sql="if exists (select * from dbo.sysobjects where id = object_id(N'[bbs].[board]') and OBJECTPROPERTY(id,N'IsUserTable') = 1)\ndrop table [bbs].[board]\n";
			out.println("正在删除数据表格board!<br>");
			dbc.executeUpdate(sql);
			out.println("删除成功！<br>");
			sql="CREATE TABLE bbs.board (\n  boardid numeric(11,0) IDENTITY (1, 1) NOT NULL,\n  BoardType varchar(50) NOT NULL default '',\n  class numeric(11,0) NOT NULL default '0',\n  readme varchar(255) NOT NULL default '',\n  BoardMaster varchar(50) NOT NULL default '',\n  lockboard numeric(11,0) NOT NULL default '0',\n  boardskin numeric(11,0) NOT NULL default '1',\n  Tableback varchar(50) NOT NULL default '',\n  Tabletitle varchar(50) NOT NULL default '',\n  Tablebody varchar(50) NOT NULL default '',\n  aTablebody varchar(50) NOT NULL default '',\n  TableFont varchar(50) NOT NULL default '',\n  TableContent varchar(50) NOT NULL default '',\n  AlertFont varchar(50) NOT NULL default '',\n  lastpostuser varchar(50) NOT NULL default '',\n  lastposttime datetime NOT NULL default '0000-00-00 00:00:00',\n  lastbbsnum numeric(11,0) NOT NULL default '0',\n  lasttopicnum numeric(11,0) NOT NULL default '0',\n  strAllowForumCode numeric(11,0) NOT NULL default '0',\n  strAllowHTML numeric(11,0) NOT NULL default '0',\n  strIMGInPosts numeric(11,0) NOT NULL default '0',\n  strIcons numeric(11,0) NOT NULL default '0',\n  strflash numeric(11,0) NOT NULL default '0',\n  Forumlogo varchar(255) NOT NULL default '',\n  indexIMG varchar(255) NOT NULL default '',\n  lastrootid numeric(11,0) NOT NULL default '0',\n  lasttopic varchar(255) NOT NULL default '',\n  todayNum numeric(11,0) NOT NULL default '0',\n  boarduser varchar(2000) NOT NULL default ''\n)  ON [PRIMARY]\n";
			out.println("正在创建数据表格board!<br>");
			dbc.executeUpdate(sql);
			out.println("创建成功！<br>");
			
			sql="if exists (select * from dbo.sysobjects where id = object_id(N'[bbs].[bookmark]') and OBJECTPROPERTY(id,N'IsUserTable') = 1)\ndrop table [bbs].[bookmark]\n";
			out.println("正在删除数据表格bookmark!<br>");
			dbc.executeUpdate(sql);
			out.println("删除成功！<br>");
			sql="CREATE TABLE bbs.bookmark (\n  id numeric(11,0) IDENTITY (1, 1) NOT NULL,\n  username varchar(50) NOT NULL default '',\n  url varchar(100) default NULL,\n  topic varchar(100) default NULL,\n  addtime varchar(19) default NULL\n)  ON [PRIMARY]\n";
			out.println("正在创建数据表格bookmark<br>");
			dbc.executeUpdate(sql);
			out.println("创建成功！<br>");
			
			sql="if exists (select * from dbo.sysobjects where id = object_id(N'[bbs].[class]') and OBJECTPROPERTY(id,N'IsUserTable') = 1)\ndrop table [bbs].[class]\n";
			out.println("正在删除数据表格class!<br>");
			dbc.executeUpdate(sql);
			out.println("删除成功！<br>");
			sql="CREATE TABLE bbs.class (\n  id numeric(11,0) IDENTITY (1, 1) NOT NULL,\n  class char(50) NOT NULL default '')  ON [PRIMARY]\n";
			out.println("正在创建数据表格class<br>");
			dbc.executeUpdate(sql);
			out.println("创建成功！<br>");
			
			sql="if exists (select * from dbo.sysobjects where id = object_id(N'[bbs].[friend]') and OBJECTPROPERTY(id,N'IsUserTable') = 1)\ndrop table [bbs].[friend]\n";
			out.println("正在删除数据表格friend<br>");
			dbc.executeUpdate(sql);
			out.println("删除成功！");
			sql="CREATE TABLE bbs.friend (\n  F_id numeric(11,0) IDENTITY (1, 1) NOT NULL,\n  F_username varchar(50) default NULL,\n  F_friend varchar(50) default NULL,\n  F_addtime varchar(19) default NULL\n )  ON [PRIMARY]\n";
			out.println("创建数据表格friend<br>");
			dbc.executeUpdate(sql);
			out.println("创建成功！<br>");

			
			sql="if exists (select * from dbo.sysobjects where id = object_id(N'[bbs].[log]') and OBJECTPROPERTY(id,N'IsUserTable') = 1)\ndrop table [bbs].[log]\n";
			out.println("删除数据表格table成功！<br>");
			dbc.executeUpdate(sql);
			out.println("删除成功！<br>");
			sql="CREATE TABLE bbs.log (\n  l_id numeric(11,0) IDENTITY (1, 1) NOT NULL,\n  l_username varchar(50) default NULL,\n  l_content varchar(50) default NULL,\n  l_url varchar(255) default NULL,\n  l_addtime varchar(19) default NULL\n)  ON [PRIMARY]\n";
			out.println("正在创建数据表格log<br>");
			dbc.executeUpdate(sql);
			out.println("创建成功！");

			
			sql="if exists (select * from dbo.sysobjects where id = object_id(N'[bbs].[message]') and OBJECTPROPERTY(id,N'IsUserTable') = 1)\ndrop table [bbs].[message]\n";
			out.println("删除数据表格message!<br>");
			dbc.executeUpdate(sql);
			out.println("删除成功！<br>");
			sql="CREATE TABLE bbs.message (\n  id numeric(11,0) IDENTITY (1, 1) NOT NULL,\n  sender varchar(50) default NULL,\n  incept varchar(50) default NULL,\n  title varchar(100) default NULL,\n  content varchar(2000),\n  flag numeric(11,0) default '0',\n  sendtime varchar(19) default NULL,\n  delR numeric(11,0) default '0',\n  delS numeric(11,0) default '0',\n  isSend numeric(11,0) default '0'\n)  ON [PRIMARY]\n";
			out.println("正在创建数据表格message!<br>");
			dbc.executeUpdate(sql);
			out.println("创建成功！<br>");

			sql="if exists (select * from dbo.sysobjects where id = object_id(N'[bbs].[online]') and OBJECTPROPERTY(id,N'IsUserTable') = 1)\ndrop table [bbs].[online]\n";
			out.println("正在删除数据表格online<br>");
			dbc.executeUpdate(sql);
			out.println("删除成功！<br>");
			sql="CREATE TABLE bbs.online (\n  id numeric(11,0) NOT NULL,\n  username char(50) NOT NULL default '',\n  userclass char(50) NOT NULL default '',\n  stats char(250) NOT NULL default '',\n  ip char(50) NOT NULL default '',\n  startime datetime NOT NULL default '0000-00-00 00:00:00',\n  lastimebk datetime NOT NULL default '0000-00-00 00:00:00',\n  lastime char(50) NOT NULL default '',\n  browser char(100) NOT NULL default '',\n  actforip char(50) default NULL,\n  ComeFrom char(50) NOT NULL default '',\n  actCome char(50) default NULL\n)  ON [PRIMARY]\n";
			out.println("正在创建数据表格online<br>");
			dbc.executeUpdate(sql);
			out.println("创建成功！<br>");
			
			sql="if exists (select * from dbo.sysobjects where id = object_id(N'[bbs].[myuser]') and OBJECTPROPERTY(id,N'IsUserTable') = 1)\ndrop table [bbs].[myuser]\n";
			out.println("正在删除表格myuser<br>");
			dbc.executeUpdate(sql);
			out.println("删除成功！<br>");
			sql="CREATE TABLE bbs.myuser (\n  UserID numeric(11,0) IDENTITY (1, 1) NOT NULL,\n  UserName varchar(50) NOT NULL default '',\n  UserEmail varchar(255) default NULL,\n  Article numeric(11,0) default '0',\n  UserPassword varchar(11) NOT NULL default '',\n  sign varchar(2000),\n  Sex varchar(10) default NULL,\n  homepage varchar(255) default NULL,\n  addDate datetime default '0000-00-00 00:00:00',\n  logins numeric(11,0) default '0',\n  face varchar(255) default NULL,\n  width numeric(11,0) default '0',\n  height numeric(11,0) default '0',\n  Oicq varchar(50) default NULL,\n  lastlogin datetime default '0000-00-00 00:00:00',\n  bbstype numeric(11,0) default '0',\n  lockuser numeric(11,0) default '0',\n  userclass numeric(11,0) default '0',\n  UserGroup varchar(50) default NULL,\n  userWealth numeric(11,0) default '0',\n  userEP numeric(11,0) default '0',\n  userCP numeric(11,0) default '0',\n  title varchar(50) default NULL,\n  showre numeric(3,0)  default '0',\n  reann varchar(50) default NULL\n)  ON [PRIMARY]\n";
			out.println("正在创建数据表格myuser<br>");
			dbc.executeUpdate(sql);
			out.println("创建成功！<br>");
			
			sql="if exists (select * from dbo.sysobjects where id = object_id(N'[bbs].[vote]') and OBJECTPROPERTY(id,N'IsUserTable') = 1)\ndrop table [bbs].[vote]\n";
			out.println("正在删除数据表格vote<br>");
			dbc.executeUpdate(sql);
			out.println("删除成功！<br>");
			sql="CREATE TABLE bbs.vote (\n  voteid numeric(11,0) IDENTITY (1, 1) NOT NULL,\n  announceid numeric(11,0) NOT NULL default '0',\n  vote varchar(2000) NOT NULL,\n  votenum varchar(50) NOT NULL default '',\n  voteuser varchar(2000) NOT NULL,\n  votetype numeric(11,0) NOT NULL default '0'\n)  ON [PRIMARY]\n\n";
			out.println("正在创建数据表格vote<br>");
			dbc.executeUpdate(sql);
			out.println("创建成功！<br>");
			sql="INSERT INTO bbs.config VALUES (?, 'http://www.bbs.com/forum/', ?,\n 'http://www.bbs.com/', 'smtp.21cn.com', 'bitiboy@msn.com', '0', '300', 'pic/LOGO.GIF',\n 'pic/', 'face/', 1, 1, 0, 0, 1, 1, '0', ?, '16384',\n '20', '10', '#0099cc', '#777777', '#99ccff', '#e8f4ff', '#f2f8ff', '#e8f4ff', '#000000', \n'#000000', '#ff0000', '#00008b', '', '', ?, ?, '1', '1', 100, 3, 1, 5, 2, 0, 2,\n 1, 3, 1, 30, 2, 1, 3, 1, 0, 0, 0, 0, '', '/', 1, getdate())";
			out.println("正在初始化数据库<br>");
			dbc.prepareStatement(sql);
			dbc.setBytes(1,"清清一色论坛".getBytes("GBK"));
			dbc.setBytes(2,"清清".getBytes("GBK"));
			dbc.setBytes(3,"操|妈妈的|我靠|fuck|bitch|变态|奶奶的|逼".getBytes("GBK"));
			dbc.setBytes(4,"版权所有：  <font \nface=Verdana, Arial, Helvetica, sans-serif size=1><b>SuperSpace<font \ncolor=#CC0000>.Com</font></b></font>".getBytes("GBK"));
			dbc.setBytes(5,"SuperSpace Version1.0".getBytes("GBK"));
			dbc.executeUpdate();
			out.println("初始化成功！<br>");
			%>

			<form action="">
				<input type="hidden" name="action" value="4">
				<input type="submit" value="下一步">
</form>

			<%
			dbc.close();
		}
		
		catch(Exception e){
				e.printStackTrace();
				return;
		}
	}
	else if(action.equals("4")){
		%>
		<%@include file="INC/const.jsp"%>
		<form method="POST" action="install.jsp">
		<input type="hidden" name="action" value="5">
<table width="95%" border="0" cellspacing="1" cellpadding="3"  align=center bordercolor=<%=aTableBackColor%>>
<tr bgcolor=<%=aTableTitleColor%>> 
<td height="23" colspan="2" ><font color=<%=tableFontColor%>><b>论坛变量设置</b></font></td>
</tr>
<tr> 
<td width="41%">论坛名称</td>
<td width="59%"> 
<input type="text" name="forumName" size="35" value="<%=forumName%>">
</td>
</tr>
<tr> 
<td width="41%">论坛的url</td>
<td width="59%"> 
<input type="text" name="forumURL" size="35" value="<%=forumURL%>">
</td>
</tr>
<tr> 
<td width="41%">主页名称</td>
<td width="59%"> 
<input type="text" name="companyName" size="35" value="<%=companyName%>">
</td>
</tr>
<tr> 
<td width="41%">主页URL</td>
<td width="59%"> 
<input type="text" name="hostURL" size="35" value="<%=hostURL%>">
</td>
</tr>
<tr> 
<td width="41%">SMTP Server地址</td>
<td width="59%"> 
<input type="text" name="SMTPServer" size="35" value="<%=SMTPServer%>">
</td>
</tr>
<tr> 
<td width="41%">论坛管理员Email</td>
<td width="59%"> 
<input type="text" name="systemEmail" size="35" value="<%=systemEmail%>">
</td>
</tr>
<tr> 
<td width="41%">服务器时差</td>
<td width="59%"> 
<input type="text" size="35" value="<%=timeAdjust%>" name="timeAdjust">
</td>
</tr>
<tr> 
<td width="41%">服务器脚本超时时间值，建议不要使用</td>
<td width="59%"> 
<input type="text" name="scriptTimeOut" size="35" value="<%=scriptTimeOut%>">
</td>
</tr>
<tr> 
<td width="41%">论坛forumLogo地址</td>
<td width="59%"> 
<input type="text" name="forumLogo" size="35" value="<%=forumLogo%>">
</td>
</tr>
<tr> 
<td width="41%">论坛图片目录</td>
<td width="59%"> 
<input type="text" name="picURL" size="35" value="<%=picURL%>">
</td>
</tr>
<tr> 
<td width="41%">论坛表情地址</td>
<td width="59%"> 
<input type="text" name="faceURL" size="35" value="<%=faceURL%>">
</td>
</tr>
<tr> 
<td width="41%">发送邮件组件</td>
<td width="59%"> 
<select name="emailFlag">
<option value="0" <%if(emailFlag==0) {%>selected<%}%>>不支持 
<option value="1" <%if (emailFlag==1) {%>selected<%}%>>JMAIL 
<option value="2" <%if (emailFlag==2) {%>selected<%}%>>CDONTS 
<option value="3" <%if (emailFlag==3) {%>selected<%}%>>ASPEMAIL 
</select>
</td>
</tr>
<tr> 
<td width="41%">贴子上传图片</td>
<td width="59%"> 
<select name="uploadPic">
<option value="0" <%if("0".equals(uploadPic)) {%>selected<%}%>>否 
<option value="1" <%if("1".equals(uploadPic)) {%>selected<%}%>>是 
</select>
</td>
</tr>
<tr> 
<td width="41%">用户IP</td>
<td width="59%"> 
<select name="ipFlag">
<option value="0" <%if ("0".equals(ipFlag)) {%>selected<%}%>>保密 
<option value="1" <%if ("1".equals(ipFlag)) {%>selected<%}%>>公开 
</select>
</td>
</tr>
<tr> 
<td width="41%">头像上传</td>
<td width="59%">
<select name="uploadFlag">
<option value="0" <%if ("0".equals(uploadFlag)) {%>selected<%}%>>否 
<option value="1" <%if ("1".equals(uploadFlag)) {%>selected<%}%>>是 
</select>
</td>
</tr>
<tr> 
<td width="41%">用户来源</td>
<td width="59%"> 
<select name="fromFlag">
<option value="0" <%if ("0".equals(fromFlag)) {%>selected<%}%>>保密 
<option value="1" <%if ("1".equals(fromFlag)) {%>selected<%}%>>公开 
</select>
</td>
</tr>
<tr> 
<td width="41%">用户头衔</td>
<td width="59%"> 
<select name="titleFlag">
<option value="0" <%if ("0".equals(titleFlag)){%>selected<%}%>>隐藏 
<option value="1" <%if ("1".equals(titleFlag)) {%>selected<%}%>>显示 
</select>
</td>
</tr>
<tr> 
<td width="41%">在线名单显示客人在线</td>
<td width="59%"> 
<select name="guestUser">
<option value="0" <%if ("0".equals(guestUser)){%>selected<%}%>>否 
<option value="1"  <%if("1".equals(guestUser)) {%>selected<%}%>>是 
</select>
</td>
</tr>
<tr> 
<td width="41%">有新的短消息弹出窗口</td>
<td width="59%"> 
<select name="openMSG">
<option value="0" <%if ("0".equals(openMSG)) {%>selected<%}%>>否 
<option value="1"  <%if ("1".equals(openMSG)) {%>selected<%}%>>是 
</select>
</td>
</tr>
<tr bgcolor=<%=aTableTitleColor%>> 
<td height="23" colspan="2" ><font color=<%=tableFontColor%>><b>关于贴子设置</b></font></td>
</tr>
<tr> 
<td height="17" width="41%">帖子内容最大的字节数</td>
<td height="17" width="59%"> 
<input type="text" name="announceMaxBytes" size="35" value="<%=announceMaxBytes%>">
</td>
</tr>
<tr> 
<td width="41%">每页显示最多纪录</td>
<td width="59%"> 
<input type="text" name="maxAnnouncePerPage" size="35" value="<%=maxAnnouncePerPage%>">
</td>
</tr>
<tr> 
<td width="41%">UBB风格浏览贴子每页显示贴子数</td>
<td width="59%"> 
<input type="text" name="maxTitleList" size="35" value="<%=maxTitleList%>">
</td>
</tr>
<tr bgcolor=<%=aTableTitleColor%>> 
<td height="23" colspan="2" ><font color=<%=tableFontColor%>><b>关于颜色字体设置（应用于除显示版面以外的页面，包括首页）</b></font></td>
</tr>
<tr> 
<td width="41%">表格背景(边框颜色)1<br>
一般页面</td>
<td width="59%"> 
<input type="text" name="tableBackColor" size="35" value="<%=tableBackColor%>">
</td>
</tr>
<tr> 
<td width="41%">表格背景(边框颜色)2<br>
用户页面、提示页面</td>
<td width="59%"> 
<input type="text" name="aTableBackColor" size="35" value="<%=aTableBackColor%>">
</td>
</tr>
<tr> 
<td width="41%">标题表格颜色1<br>
一般页面</td>
<td width="59%"> 
<input type="text" name="tableTitleColor" size="35" value="<%=tableTitleColor%>">
</td>
</tr>
<tr> 
<td width="41%">标题表格颜色2<br>
用户页面、提示页面</td>
<td width="59%"> 
<input type="text" name="aTableTitleColor" size="35" value="<%=aTableTitleColor%>">
</td>
</tr>
<tr> 
<td width="41%">表格体颜色1</td>
<td width="59%"> 
<input type="text" name="tableBodyColor" size="35" value="<%=tableBodyColor%>">
</td>
</tr>
<tr> 
<td width="41%">表格体颜色2(1和2颜色在首页显示中穿插)</td>
<td width="59%"> 
<input type="text" name="aTableBodyColor" size="35" value="<%=aTableBodyColor%>">
</td>
</tr>
<tr> 
<td width="41%">表格内文字标题颜色</td>
<td width="59%"> 
<input type="text" name="tableFontColor" size="35" value="<%=tableFontColor%>">
</td>
</tr>
<tr> 
<td width="41%">表格内文字内容颜色</td>
<td width="59%"> 
<input type="text" name="tableContentColor" size="35" value="<%=tableContentColor%>">
</td>
</tr>
<tr> 
<td width="41%">警告提醒语句的颜色</td>
<td width="59%"> 
<input type="text" name="alertFontColor" size="35" value="<%=alertFontColor%>">
</td>
</tr>
<tr> 
<td width="41%">显示帖子的时候，相关帖子，转发帖子，回复等的颜色</td>
<td width="59%"> 
<input type="text" name="contentTitle" size="35" value="<%=contentTitle%>">
</td>
</tr>
<tr bgcolor=<%=aTableTitleColor%>> 
<td height="23" colspan="2" ><font color=<%=tableFontColor%>><b>版权广告信息</b></font></td>
</tr>
<tr> 
<td width="41%">论坛页首广告代码</td>
<td width="59%"> 
<input type="text" name="ads1" size="35" value="<%=ads1%>">
</td>
</tr>
<tr> 
<td width="41%">论坛页尾广告代码</td>
<td width="59%"> 
<input type="text" name="ads2" size="35" value="<%=ads2%>">
</td>
</tr>
<tr> 
<td width="41%">版权信息</td>
<td width="59%"> 
<input type="text" name="copyRight" size="35" value="<%=copyRight%>">
</td>
</tr>
<tr> 
<td width="41%">版本信息</td>
<td width="59%"> 
<input type="text" name="version" size="35" value="<%=version%>">
</td>
</tr>
<tr bgcolor=<%=aTableTitleColor%>> 
<td width="41%">&nbsp;</td>
<td width="59%"> 
<div align="center"> 
<input type="submit" name="Submit" value="提 交">
</div>
</td>
</tr>
</table>
</form>
		<%
	}
		else if(action.equals("5")){
			try{
				ForumPropertiesManager.saveConst(request);
				%>
			<%@include file="INC/const.jsp"%>	
				
				<FORM name=theForm action="" method=post>
				<input type="hidden" name="action" value="6">
<table cellpadding=0 cellspacing=0 border=0 width=500 bgcolor=<%=aTableBackColor%> align=center>
        <tr>
            <td>
                
<table cellpadding=3 cellspacing=1 border=0 width=100%>
<TBODY> 
<TR align=middle bgcolor=<%=aTableTitleColor%>> 
<TD colSpan=2 height=24><b>请您填写超级管理员的信息！</b></TD>
</TR>
<TR bgcolor=<%=tableBodyColor%>> 
<TD width=150>注 册 名**</TD>
<TD> 
<INPUT maxLength=8 size=12 name=userName>
(可以使用中英文匿名)</TD>
</TR>
<TR bgcolor=<%=tableBodyColor%>> 
<TD width=150>性 别</TD>
<TD> 
<INPUT type=radio CHECKED value="1" name=sex>
<IMG 
      height=27 src="pic/Male.gif" width=25 align=absMiddle>男孩 &nbsp;&nbsp;&nbsp;&nbsp; 
<INPUT type=radio value="0" name=sex>
<IMG 
      height=27 src="pic/Female.gif" width=27 align=absMiddle>女孩</TD>
</TR>
<TR bgcolor=<%=tableBodyColor%>> 
<TD width=150>密&nbsp;&nbsp;&nbsp;&nbsp;码**</TD>
<TD> 
<INPUT type=password maxLength=16 size=13 name=psw>
</TD>
</TR>
<TR bgcolor=<%=tableBodyColor%>> 
<TD width=150>密码确认 **</TD>
<TD> 
<INPUT type=password maxLength=16 size=13 name=pswc>
</TD>
</TR>
<TR bgcolor=<%=tableBodyColor%>> 
<TD width=150 height=32>Email地址 **</TD>
<TD height=32> 
<INPUT maxLength=50 size=27 name=userEmail>
(如：abc@SuperSpace.net) </TD>
</TR>
<TR bgcolor=<%=tableBodyColor%>> 
<TD width=150 height=32>形象 <img id=face src="<%=picURL%>Image1.gif" alt=个人形象代表>**</TD>
<TD height=15> 
<select name=face size=1 onChange="document.images['face'].src=options[selectedIndex].value;" style="BACKGROUND-COLOR: #99CCFF; BORDER-BOTTOM: 1px double; BORDER-LEFT: 1px double; BORDER-RIGHT: 1px double; BORDER-TOP: 1px double; COLOR: #000000">
<%for(i=1;i<61;i++){%>
<option value='<%=picURL%>Image<%=i%>.gif'>Image<%=i%></option>
<%}%>
</select>
</TR>
<tr bgcolor=<%=tableBodyColor%>> 
<td width=150 height=32>发帖有回复时是否提示</td>
<td height=16>
<input type="radio" name="showRe" value="1" checked>
提示我
<input type="radio" name="showRe" value="0">
不提示
</tr>
<TR bgcolor=<%=tableBodyColor%>> 
<TD width=150 valign=top>自定义头像<br>
如果图像位置中有连接图片将以自定义的为主</TD>
<TD> 
<% if ("1".equals(uploadFlag)){ %>
<iframe name="ad" frameborder=0 width=300 height=40 scrolling=no src=reg_upload.jsp></iframe> 
<br>
<% } %>
图像位置： 
<input type="TEXT" name="myface" size=20 maxlength=100>
完整Url地址<br>
宽&nbsp;&nbsp;&nbsp;&nbsp;度： 
<input type="TEXT" name="width" size=2 maxlength=2>
20---80的整数<br>
高&nbsp;&nbsp;&nbsp;&nbsp;度： 
<input type="TEXT" name="height" size=2 maxlength=2>
20---80的整数<br>
</TD>
</TR>
<TR bgcolor=<%=tableBodyColor%>> 
<TD width=150>OICQ号码</TD>
<TD> 
<INPUT maxLength=20 size=44 name=oicq>
</TD>
</TR>
<TR bgcolor=<%=tableBodyColor%>> 
<TD width=150>签 名<BR>
<BR>
文字将出现在您发表的文章的结尾处。体现您的个性。 </TD>
<TD> 
<TEXTAREA name=sign rows=5 wrap=PHYSICAL cols=42></TEXTAREA>
</TD>
</TR>
<TR align=middle bgcolor=<%=aTableTitleColor%>> 
<TD colSpan=2> 
<DIV align=center> 
<INPUT value="注 册" name=Submit type=submit>
<INPUT type=reset value="重 写" name=Submit2>
</DIV>
</TD>
</TR>
</TBODY> 
</TABLE>
</td></tr></table>
</FORM>
				<%
			}
			catch(Exception e){
				e.printStackTrace();
				out.println(e.getMessage());
			}
		}
		else if(action.equals("6")){
			%>
			<%@include file="INC/const.jsp"%>
			<%
			UserManager.addAdmin(request,wealthReg,epReg,cpReg);
			out.println("添加成功，请您删除install.jsp文件！现在登陆论坛进入管理界面");
			%>
			<form action="index.jsp">
			<input type="submit" value="进入<%=forumName%>">
			</form>
			<%
		}


%>
</body>
</html>