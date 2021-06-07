<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="INC/const.jsp"%>
<%@ page import = "java.util.Vector,
					net.acai.forum.admin.*"%>
<%
System.out.println(forumName);
%>
<title><%=forumName%>--管理页面</title>
<link rel="stylesheet" type="text/css" href="forum.css">

<BODY bgcolor="#ffffff" alink="#333333" vlink="#333333" link="#333333" topmargin="20">
<%
	try{
		if(session.getAttribute("adminFlag")==null)
			throw new Exception("本页面为管理员专用，请<a href=elogin.jsp>登陆管理</a>后进入。");

	
%>
<table cellpadding=0 cellspacing=0 border=0 width=95% bgcolor=<%=aTableBackColor%> align=center>
  <tr>
    <td>
      <table cellpadding=3 cellspacing=1 border=0 width=100%>
        <tr bgcolor='<%=aTableTitleColor%>'>
        <td align=center colspan="2">欢迎<b>
<%=session.getAttribute("adminName")%></b>进入管理页面
        </td>
        </tr>
            <tr bgcolor=<%=tableBodyColor%>>
              
          <td width="20%" valign=top> 
            <%@include file="admin_left.jsp"%>
            </td>
              
          <td width="80%" valign=top> 
            <table width="100%" border="0" cellspacing="3" cellpadding="0">
              <tr>
                <td>1．注意事项： 在下面，您将看到目前所有的论坛分类。您可以编辑论坛分类名或是增加一个新的论坛到这个分类中。 也可以编辑或删除目前存在的论坛。您可以对目前的分类重新进行排列。 
                   <p><font color=<%=alertFontColor%>>2.特别注意</font>：删除论坛同时将删除该论坛下所有帖子！删除分类同时删除下属论坛和其中帖子！ 操作时请完整填写表单信息。
                </td>
              </tr>
              <tr>
              <td>
              <p align=cetner><b><a href=admin_board.jsp>论坛管理</a> | <a href="admin_board.jsp?action=addclass">新建论坛分类</a></p>
              </td>
              <tr>
            </table>
<%
			  String action=ParamUtil.getString(request,"action");
		if(action==null||action.equals("")){
			  response.sendRedirect("admin_board.jsp?action=boardinfo");
		  }
		  

		else if(action.equals("add")){

%>
 <form action ="admin_board.jsp?action=savenew" method=post>

<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
<tr bgcolor=<%=aTableTitleColor%>> 
<td width="52%" height=22><b>字段名称：</b> </td>
<td width="48%"><b>变量值：</b> </td>
</tr>
<tr> 
<td width="52%">论坛序号（注意不能和别的论坛序号相同）</td>
<td width="48%"> 

</td>
</tr>
<tr> 
<td width="52%">论坛名</td>
<td width="48%"> 
<input type="text" name="boardtype" size="24">
</td>
</tr>
<tr> 
<td width="52%">所属类别</td>
<td width="48%"> 
<select name=class>
<%
		Vector gateWayVector=GateWayFactory.getGateWays();
		for( i=0;i<gateWayVector.size();i++){
			GateWay gateWay=(GateWay)gateWayVector.get(i);
    			int gateWayID=gateWay.getGateWayID();
    			String gateWayName=gateWay.getGateWayName();
			
		
%>
<option value=<%=gateWayID%> <%if(gateWayID==ParamUtil.getInt(request,"gateWayID",0)){out.println("selected");}%>><%=gateWayName%> 
<%
		}
%>
</select>
</td>
</tr>
<tr> 
<td width="52%">版面说明</td>
<td width="48%"> 
<input type="text" name="readme" size="24">
</td>
</tr>
<tr> 
<td width="52%">斑竹(多斑竹添加请用|分隔，如：沙滩小子|wodeail)：</td>
<td width="48%"> 
<input type="text" name="boardmaster" size="24">
</td>
</tr>
<tr> 
<td width="52%">锁定版面(0开放，1锁定，2特定用户开放)</td>
<td width="48%"> 
<select name="lockboard">
<option value="0" selected>0 
<option value="1">1 
<option value="2">2 
</select>
</td>
</tr>
<tr> 
<td width="52%">版面表格边框颜色</td>
<td width="48%"> 
<input type="text" name="Tableback" size="24" value="<%=tableBackColor%>">
</td>
</tr>
<tr> 
<td width="52%">版面标题表格颜色</td>
<td width="48%"> 
<input type="text" name="Tabletitle" size="24" value="<%=tableTitleColor%>">
</td>
</tr>
<tr> 
<td width="52%">版面内容表格颜色1</td>
<td width="48%"> 
<input type="text" name="Tablebody" size="24" value="<%=tableBodyColor%>">
</td>
</tr>
<tr> 
<td width="52%">版面内容表格颜色2，颜色1和颜色2在bbs风格中互相穿插排列</td>
<td width="48%"> 
<input type="text" name="aTablebody" size="24" value="#FFFFFF">
</td>
</tr>
<tr> 
<td width="52%">版面标题表格字体颜色</td>
<td width="48%"> 
<input type="text" name="TableFont" size="24" value="<%=tableFontColor%>">
</td>
</tr>
<tr> 
<td width="52%">版面内容表格字体颜色</td>
<td width="48%"> 
<input type="text" name="TableContent" size="24" value="<%=tableContentColor%>">
</td>
</tr>
<tr> 
<td width="52%">提醒语句颜色</td>
<td width="48%"> 
<input type="text" name="AlertFont" size="24" value="<%=alertFontColor%>">
</td>
</tr>
<tr> 
<td width="52%">论坛Logo地址</td>
<td width="48%"> 
<input type="text" name="Logo" size="35" value="<%=forumLogo%>">
</td>
</tr>
<tr> 
<td width="52%">首页显示论坛图片</td>
<td width="48%"> 
<input type="text" name="indexIMG" size="35" value="">
</td>
</tr>
<tr> 
<td width="52%">UBB标签</td>
<td width="48%"> 
<select name="strAllowForumCode">
<option value="0">不使用 
<option value="1" selected>使用 
</select>
</td>
</tr>
<tr> 
<td width="52%">HTML标签</td>
<td width="48%"> 
<select name="strAllowHTML">
<option value="0" selected>不使用 
<option value="1">使用 
</select>
</td>
</tr>
<tr> 
<td width="52%">帖图标签</td>
<td width="48%"> 
<select name="strIMGInPosts">
<option value="0">不使用 
<option value="1" selected>使用 
</select>
</td>
</tr>
<tr> 
<td width="52%">Flash标签</td>
<td width="48%"> 
<select name="strflash">
<option value="0">不使用 
<option value="1" selected>使用 
</select>
</td>
</tr>
<tr> 
<td width="52%">表情标签</td>
<td width="48%"> 
<select name="strIcons">
<option value="0">不使用 
<option value="1" selected>使用 
</select>
</td>
</tr>
<tr bgcolor="<%=aTableTitleColor%>"> 
<td width="52%">&nbsp;</td>
<td width="48%"> 
<input type="submit" name="Submit" value="添加论坛">
</td>
</tr>
</table>
</form>
<%
}

else if(action.equals("edit")){

%>
 <form action ="admin_board.jsp?action=savedit" method=post>           
<%
	int editID;
	try{
		editID=ParamUtil.getInt(request,"editid");
	}
	catch(Exception e){
		throw new Exception("对不起，您没选择，编辑论坛的ID");
	}
	
	Forum theForum=ForumFactory.getForum(editID);
	if(theForum==null)
		throw new Exception("错误的版面");
%>            
<input type='hidden' name=editid value='<%=editID%>'>
            
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
<tr bgcolor=<%=aTableTitleColor%>> 
<td width="52%" height=22><b>字段名称：</b> </td>
<td width="48%"> 
<div align="center"><b>变量值：</b></div>
</td>
</tr>
<tr>
<td width="52%" height=24><font color="<%=tableContentColor%>"><B>论坛ID</B></font></td>
<td width="48%"> 
<input type="text" name="newforumID" size="3"  value = '<%=theForum.getForumID()%>'>
</td>
</tr>
<tr> 
<td width="52%" height=24><font color="<%=tableContentColor%>"><B>论坛名称</B></font></td>
<td width="48%"> 
<input type="text" name="boardtype" size="24"  value = '<%=theForum.getForumType()%>'>
</td>
</tr>
<tr> 
<td width="52%" height=24><font color="<%=tableContentColor%>"><B>所属类别</B></font></td>
<td width="48%"> 
<select name=class>
<%
		Vector gateWayVector=GateWayFactory.getGateWays();
		for( i=0;i<gateWayVector.size();i++){
			GateWay gateWay=(GateWay)gateWayVector.get(i);
    			int gateWayID=gateWay.getGateWayID();
    			String gateWayName=gateWay.getGateWayName();
			
		
%>
<option value=<%=gateWayID%> <%if(theForum.getForumClass()==gateWayID){ out.println("selected");}%>><%=gateWayName%> 
<%
		}
%>
</select>
</td>
</tr>
<tr> 
<td width="52%" height=24><font color="<%=tableContentColor%>"><B>版面说明</B></font></td>
<td width="48%"> 
<input type="text" name="readme" size="24" value='<%=theForum.getReadMe()%>'>
</td>
</tr>
<tr> 
<td width="52%" height=24><font color="<%=tableContentColor%>"><B>论坛版主</B><BR>多斑竹添加请用|分隔，如：沙滩小子|wodeail</font></td>
<td width="48%"> 
<input type="text" name="boardmaster" size="24"  value='<%=theForum.getForumMaster()%>'>
</td>
</tr>
<tr> 
<td width="52%" height=24><font color="<%=tableContentColor%>"><B>是否为隐含版面</B><BR>0表示开放，1表示隐含</font></td>
<td width="48%"> 
<select name="lockboard">
<option value="0" <%if (theForum.getLockForum()==0) {%>selected<%}%>>0 
<option value="1" <%if (theForum.getLockForum()==1) {%>selected<%}%>>1 
</select>
</td>
</tr>
<tr> 
<td width="52%">版面表格边框颜色</td>
<td width="48%"> 
<input type="text" name="Tableback" size="24"  value='<%=theForum.getTableBack()%>'>
</td>
</tr>
<tr> 
<td width="52%">版面标题表格颜色</td>
<td width="48%"> 
<input type="text" name="Tabletitle" size="24"  value='<%=theForum.getTableTitle()%>'>
</td>
</tr>
<tr> 
<td width="52%">版面内容表格颜色1</td>
<td width="48%"> 
<input type="text" name="Tablebody" size="24"  value='<%=theForum.getTableBody()%>'>
</td>
</tr>
<tr > 
<td width="52%">版面内容表格颜色2，颜色1和颜色2在bbs风格中互相穿插排列</td>
<td width="48%"> 
<input type="text" name="aTablebody" size="24"  value='<%=theForum.getATableBody()%>'>
</td>
</tr>
<tr> 
<td width="52%">版面标题表格字体颜色</td>
<td width="48%"> 
<input type="text" name="TableFont" size="24"  value='<%=theForum.getTableFont()%>'>
</td>
</tr>
<tr> 
<td width="52%">版面内容表格字体颜色</td>
<td width="48%"> 
<input type="text" name="TableContent" size="24"  value='<%=theForum.getTableContent()%>'>
</td>
</tr>
<tr> 
<td width="52%">提醒语句颜色</td>
<td width="48%"> 
<input type="text" name="AlertFont" size="24"  value='<%=theForum.getAlertFont()%>'>
</td>
</tr>
<tr> 
<td width="52%">论坛Logo地址</td>
<td width="48%"> 
<input type="text" name="Logo" size="35" value="<%=theForum.getForumLogo()%>">
</td>
</tr>
<tr> 
<td width="52%">首页显示论坛图片</td>
<td width="48%">
<input type="text" name="indexIMG" size="35" value="<%=theForum.getIndexIMG()%>">
</td>
</tr>
<tr> 
<td width="52%">UBB标签</td>
<td width="48%"> 
<select name="strAllowForumCode">
<option value="0" <%if (!theForum.getStrAllowForumCode()){%>selected<%}%>>不使用 
<option value="1" <%if (theForum.getStrAllowForumCode()){%>selected<%}%>>使用 
</select>
</td>
</tr>
<tr> 
<td width="52%">HTML标签</td>
<td width="48%"> 
<select name="strAllowHTML">
<option value="0" <%if (!theForum.getStrAllowHTML()){%>selected<%}%>>不使用 
<option value="1" <%if (theForum.getStrAllowHTML()) {%>selected<%}%>>使用 
</select>
</td>
</tr>
<tr> 
<td width="52%">帖图标签</td>
<td width="48%"> 
<select name="strIMGInPosts">
<option value="0" <%if (!theForum.getStrIMGInPosts()) {%>selected<%}%>>不使用 
<option value="1" <%if (theForum.getStrIMGInPosts()) {%>selected<%}%>>使用 
</select>
</td>
</tr>
<tr> 
<td width="52%">Flash标签</td>
<td width="48%"> 
<select name="strflash">
<option value="0" <%if (!theForum.getStrFlash()) {%>selected<%}%>>不使用 
<option value="1" <%if (theForum.getStrFlash()) {%>selected<%}%>>使用 
</select>
</td>
</tr>
<tr> 
<td width="52%">表情标签</td>
<td width="48%"> 
<select name="strIcons">
<option value="0" <%if (!theForum.getStrIcons()){%>selected<%}%>>不使用 
<option value="1" <%if (theForum.getStrIcons()) {%>selected<%}%>>使用 
</select>
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
else if(action.equals("boardinfo")){

	    Vector gateWayVector=GateWayFactory.getGateWays();
		for( i=0;i<gateWayVector.size();i++){
			GateWay gateWay=(GateWay)gateWayVector.get(i);
    			int gateWayID=gateWay.getGateWayID();
    			String gateWayName=gateWay.getGateWayName();

	   
%>
            <table width="100%" border="0" cellspacing="3" cellpadding="0">
              <tr bgcolor="<%=aTableTitleColor%>">

                <td height="21"><font color="<%=tableContentColor%>"><B><%=gateWayID%>,分类名：<%=gateWayName%></b>    <a href="admin_board.jsp?action=add&gateWayID=<%=gateWayID%>"><font color="<%=tableContentColor%>">新增论坛</font></a> | <a href=admin_board.jsp?action=orders&id=<%=gateWayID%>><font color="<%=tableContentColor%>">分类排序修改</font></a> | <a href=admin_board.jsp?action=del1&id=<%=gateWayID%> onclick="{if(confirm('删除将包括该分类下所有论坛的所有帖子，确定删除吗?')){return true;}return false;}"><font color="<%=tableContentColor%>">删除分类</font></a></font></td>
              </tr>
            </table>
<%
            try{
				Vector forumVector=ForumFactory.getForums(gateWayID);
				for(int j=0;j<forumVector.size();j++){
					Forum theForum=(Forum)forumVector.get(j);
            %>
            <table width="100%" border="0" cellspacing="3" cellpadding="0">
              <tr> 
                <td height="18"><%=theForum.getForumID()%>,论坛名：<%=theForum.getForumType()%></td>
              </tr>
              <tr>
                <td height="18">论坛简介：<%=theForum.getReadMe()%></td>
              </tr>
              <tr>
                <td height="15"><a href="admin_board.jsp?action=edit&editid=<%=theForum.getForumID()%>">编辑此论坛</a> | <a href="admin_board.jsp?action=del&boardid=<%=theForum.getForumID()%>">删除此论坛</a></td>
              </tr>
            </table>
<hr color=black height=1 width="70%" align=left>
<%
				}
			}
			catch(Exception e){}
		}
%>
          </td>
            </tr>
        </table>      
        </td>
       </tr>
</table>
<%
}
else if(action.equals("savenew")){
	ForumAdmin.saveNew(request);
	
	
}
else if(action.equals("savedit")){

	ForumAdmin.saveEdit(request);
	
}
else if(action.equals("del")){

	ForumAdmin.del(request);
}
else if(action.equals("del1")){
	ForumAdmin.dell(request);
	
}
else if(action.equals("orders")){

%><br>
            <table width="95%" border="0" cellspacing="3" cellpadding="0" align=center>
              <tr> 
                <td height="22"><b>论坛分类重新排序修改</b><br>
注意：请在相应论坛分类的排序表单内输入相应的排列序号，注意不能和别的论坛分类有相同的排列序号。
		</td>
              </tr>
	      <tr>
		<td>
<%
	
	GateWay gateWay=GateWayFactory.getGateWay(request);
	out.println( "<form action=admin_board.jsp?action=updateorders method=post>");
	out.println( "<input type=text name=classname size=25 value="+gateWay.getGateWayName()+">");
	out.println( "  <input type=text name=newid size=2 value="+gateWay.getGateWayID()+">");
	out.println( "<input type=hidden name=id value="+gateWay.getGateWayID()+">");
	out.println( "<input type=submit name=Submit value=修改></form>");
	
	
%>
		</td>
	      </tr>
            </table>
<%
}
else if(action.equals("updateorders")){

	ForumAdmin.updateOrders(request);
	
}
else if(action.equals("addclass")){
	
%>
            <table width="95%" border="0" cellspacing="3" cellpadding="0" align=center>
              <tr> 
                <td height="22" bgcolor=<%=aTableTitleColor%>><b>添加新的论坛分类</b><br>
注意：请完整填写以下表单信息，注意不能和别的论坛分类有相同的排列序号。
		</td>
              </tr>
<form action=admin_board.jsp?action=saveclass method=post>
	      <tr>
		
分类名：<input name=classname type=text size=25>
<input type=submit name=Submit value=添加>
		</td>
	      </tr>
</form>
	    </table>
<%
}
else if(action.equals("saveclass")){

	ForumAdmin.saveClass(request);
}

else
	throw new Exception("错误非法请求！");


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