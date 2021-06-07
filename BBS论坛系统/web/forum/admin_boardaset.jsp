<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="INC/const.jsp"%>
<%@ page import = "java.util.Vector,
					net.acai.forum.admin.*"%>
<%
	stats=forumName+"斑竹管理页面";
	forumID=ParamUtil.getInt(request,"forumID",0);
	String errMsg="";
	
%>
<%@ include file="INC/theme.jsp"%>
<%
out.println(headLine(1,forumName,forumLogo,"",1,stats));
%>
<%
	
		try{
			ForumNewsAdmin forumNewsAdmin=new ForumNewsAdmin(request,response);
			

%>
<table cellpadding=0 cellspacing=0 border=0 width=<%=tableWidth%> bgcolor=<%=tableBackColor%> align=center>
  <tr>
    <td>
      <table cellpadding=3 cellspacing=1 border=0 width=100%>
        <tr bgcolor='<%=tableTitleColor%>'>
          <td align=center colspan="2"><font color="<%=tableFontColor%>">欢迎<b> <%=response.encodeURL(userName)%></b>进入版主管理页面</font></td>
        </tr>
            <tr bgcolor=<%=tableBodyColor%>>
              <td width="30%" valign=top><font color="<%=tableContentColor%>">
&nbsp;&nbsp;注意：各个版面版主可以在自己版面自由发布公告和版面设置，管理员可以在所有版面发布，并对信息进行管理操作。
<br><BR>
版主管理选项：<BR>
主版主可增删副版主：<%if (bmFlag_1==1) {%>打开<%}else{%>关闭<%}%><BR>
主版主可修改颜色配置：<%if (bmFlag_2==1) {%>打开<%}else{%>关闭<%}%><BR>
主版主可更改论坛使用设置：<%if (bmFlag_3==1) {%>打开<%}else{%>关闭<%}%><BR>
所有版主均可修改颜色配置：<%if (bmFlag_4==1){%>打开<%}else{%>关闭<%}%><BR>
所有版主均可更改论坛设置：<%if (bmFlag_5==1) {%>打开<%}else{%>关闭<%}%><BR>
</font>
	      </td>
              <td width="70%" valign=top>
<font color="<%=tableContentColor%>">
      		<table cellpadding=0 cellspacing=0 border=0 width=100% align=center>
		  <tr>
			<td width="100%" height=24 bgcolor=<%=aTableTitleColor%>>
<font color="<%=tableContentColor%>">
<B>注意</B>：<BR>本页面为版主专用，使用前请看左边相对应的功能是否打开，在进行管理设置的时候，不要随意更改设置，如需更改，必须填写完整或者正确的填写。<BR>
        <b>管理选项：<a href=admin_boardaset.jsp?forumID=<%=forumID%>><font color="<%=tableContentColor%>">论坛公告发布</font></a>
        <%if (master) {%>
        | <b><a href=admin_boardaset.jsp?action=manage&forumID=<%=forumID%>><font color="<%=tableContentColor%>">公告管理</font></a>
        <%}%> | 
		<a href=admin_boardaset.jsp?action=editbminfo&forumID=<%=forumID%>><font color="<%=tableContentColor%>">基本信息管理</font></a> | 
		<a href=admin_boardaset.jsp?action=editbmset&forumID=<%=forumID%>><font color="<%=tableContentColor%>">基本设置管理</font></a> | 
		<a href=admin_boardaset.jsp?action=editbmcolor&forumID=<%=forumID%>><font color="<%=tableContentColor%>">颜色设置管理</font></a></b></font>
		  </td></tr>
		</table>
<%
	String action=ParamUtil.getString(request,"action");
	
	
%></font>
	      </td>
            </tr>
        </table>
        </td>
    </tr>
</table>
<%
	if(action==null||action.equals("news")){
%>
<form action="admin_boardaset.jsp?action=new" method=post name=FORM>
      		
  <table cellpadding=0 cellspacing=0 border=0 width=100% align=center>
    <tr> 
      <td width="20%" valign=top> 
        <div align="center"><font color="<%=tableContentColor%>">发布版面： </font></div>
      </td>
      <td width="80%"> 
        <%if (master) {%>
       
        <select name="forumID" size="1">
          <option value="0">论坛首页</option>
          <%@include file="INC/forumList.jsp"%>
        </select>
        <%}else{%>
        <%
	Forum theForum=ForumFactory.getForum(forumID);
%>
        <select name="forumID" size="1">
          <option value="<%=forumID%>"><%=theForum.getForumType()%></option>
        </select>
        <%}%>
      </td>
    </tr>
    <tr> 
      <td width="20%" valign=top> 
        <div align="center"><font color="<%=tableContentColor%>">发布人： </font></div>
      </td>
      <td width="80%">
        <input type=text name=username size=36 value="<%=userName%>" disabled>
        <input type=hidden name=username value="<%=userName%>">
      </td>
    </tr>
    <tr> 
      <td width="20%" valign=top> 
        <div align="center"><font color="<%=tableContentColor%>">标题： </font></div>
      </td>
      <td width="80%">
        <input type=text name=title size=36>
      </td>
    </tr>
    <tr> 
      <td width="20%" valign=top> 
        <div align="center"><font color="<%=tableContentColor%>">内容： </font></div>
      </td>
      <td width="80%">
        <textarea cols=35 rows=6 name="content"></textarea>
      </td>
    </tr>
    <tr>
      <td width="100%" valign=top colspan="2" align=center> 
	    <input type=hidden name="checked" value="yes">
        <input type=Submit value="发 送" name=Submit">
        &nbsp; 
        <input type="reset" name="Clear" value="清 除">
      </td>
    </tr>
  </table>
</form>
<%
}
else if(action.equals("new")){
	out.println("发布成功!");
}
else if(action.equals("del")){
	out.println("删除公告成功");
}
else if(action.equals("update")){
	out.println("修改成功!");
}
else if(action.equals("saveditbm")){
	out.println("修改成功");
}
else if(action.equals("manage")){
%>
      		<table cellpadding=0 cellspacing=0 border=0 width=100% align=center>
		  <tr><td width="80%" valign=top height=22>
<font color="<%=tableContentColor%>">标题</font>
		  </td>
		  <td width="20%">
<font color="<%=tableContentColor%>">操作</font>
		  </td></tr>
<%
	try{
		Vector forumNewsVector=ForumNewsManager.getForumNewsVector();
		for(i=0;i<forumNewsVector.size();i++){
			ForumNews forumNews=(ForumNews)forumNewsVector.get(i);
	
%>
		  <tr><td width="80%" valign=top height=22><a href=admin_boardaset.jsp?action=edit&newsID=<%=forumNews.getId()%>&forumID=<%=forumNews.getBoardid()%>><font color="<%=tableContentColor%>"><%=forumNews.getTitle()%></font></a>
		  </td>
		  <td width="20%"><a href=admin_boardaset.jsp?action=del&newsID=<%=forumNews.getId()%>&forumID=<%=forumNews.getBoardid()%>><font color="<%=tableContentColor%>">删除</font></a>
		  </td></tr>
<%
		}
	}
	catch(Exception e){
		e.printStackTrace();
	}
%></table>
<%
}

else if(action.equals("edit")){
	int newsID=ParamUtil.getInt(request,"newsID");
%>
<form action="admin_boardaset.jsp?action=update&newsID=<%=newsID%>" method=post>
      		<table cellpadding=0 cellspacing=0 border=0 width=100% align=center>
		  <tr><td width="20%" valign=top>
<font color="<%=tableContentColor%>">发布版面：</font>
		  </td>
		  <td width="80%">

<select name="forumID" size="1">
<option value="0" <%if (forumID==0) {%>selected<%}%>>论坛首页</option>
<%@include file="INC/forumList.jsp"%> 
          </select>
		  </td></tr>
<%
	try{

		ForumNews forumNews=ForumNewsManager.getSignalForumNews(newsID);
		%>
		  <tr><td width="20%" valign=top>
<font color="<%=tableContentColor%>">发布人：</font>
		  </td>
		  <td width="80%"><input type=text name=username size=36 value=<%=forumNews.getUserName()%>></td></tr>
		  <tr><td width="20%" valign=top>
<font color="<%=tableContentColor%>">标题：</font>
		  </td>
		  <td width="80%"><input type=text name=title size=36 value=<%=forumNews.getTitle()%>></td></tr>
		  <tr><td width="20%" valign=top>
<font color="<%=tableContentColor%>">内容：</font>
		  </td>
		  <td width="80%"><textarea cols=35 rows=6 name="content">
<%=forumNews.getContent()%>
		  </textarea></td>
		  </tr>
		  <tr><td width="100%" valign=top colspan="2" align=center>
<input type=Submit value="修 改" name=Submit"> &nbsp; <input type="reset" name="Clear" value="清 除">
		  </td></tr>
		</table>
</form>
<%
		 }
		catch(Exception e){
			e.printStackTrace();
			throw new Exception("没有发现新闻!");
		}
}

else if(action.equals("editbminfo")){
	if(bmFlag_1==0&&!master)
		throw new Exception("本项版主管理功能未开放。");


%>
 <form action ="admin_boardaset.jsp?action=saveditbm&forumID=<%=forumID%>" method=post>           
<%
	Forum theForum;
	if(forumID==0)
		throw new Exception("您没有指定相应论坛ID，不能进行管理。");
	else
		theForum=ForumFactory.getForum(forumID);

	
%>            
<input type='hidden' name=editid value='<%=forumID%>'>
            
  <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
    <tr bgcolor=<%=aTableTitleColor%>> 
      <td width="52%" height=22><font color="<%=tableContentColor%>"><b>字段名称：</b></font> </td>
      <td width="48%"> 
        <div align="center"><font color="<%=tableContentColor%>"><b>变量值：</b></font></div>
      </td>
    </tr>
    <tr> 
      <td width="52%"><font color="<%=tableContentColor%>">论坛序号（注意不能和别的论坛序号相同）</font></td>
      <td width="48%"> <font color="<%=tableContentColor%>"><%=forumID%> </font></td>
    </tr>
    <tr> 
      <td width="52%"><font color="<%=tableContentColor%>">论坛名</font></td>
      <td width="48%"> <font color="<%=tableContentColor%>"><%=theForum.getForumType()%></font> </td>
    </tr>
    <tr> 
      <td width="52%"><font color="<%=tableContentColor%>">版面说明</font></td>
      <td width="48%"> 
        <input type="text" name="readme" size="24" value='<%=theForum.getReadMe()%>'>
      </td>
    </tr>
    <tr> 
      <td width="52%"><font color="<%=tableContentColor%>">版主(多版主添加请用|分隔，如：沙滩小子|wodeail)：</font></td>
      <td width="48%"> 
        <input type="text" name="boardmaster" size="24"  value='<%=theForum.getForumMaster()%>'>
      </td>
    </tr>
    <tr bgcolor=<%=aTableTitleColor%>> 
      <td width="52%">&nbsp;</td>
      <td width="48%"> 
        <input type="submit" name="Submit" value="提交">
      </td>
    </tr>
  </table>
</form>
<%

}

else if(action.equals("editbmset")){


out.println("正在建设中");
}
else if(action.equals("editbmcolor")){
	out.println("正在建设中");
}
else 
	throw new Exception("非法请求！");

}
catch(Exception e){
		e.printStackTrace();
		errMsg=e.getMessage();
	%>
	<%@include file="INC/error.jsp"%>
	<%
	}
%>
<%@include file="foot.jsp"%>
