<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="INC/const.jsp"%>
<%@ page import = "java.util.Vector,
					net.acai.forum.admin.*"%>
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
<%
		String userID=ParamUtil.getString(request,"userID");
		if(userID!=null&&!("".equals(userID))){
			//out.println(userID);

			UserManager.delUser(request);
			out.println("操作成功！");
		}
		else{
			String txtitle=ParamUtil.getString(request,"txtitle");
			Vector users;
			if(!(txtitle==null||"".equals(txtitle.trim())))
				users=UserManager.findUsers(txtitle);
			else
				users=SkinUtil.getTopList(request);
		int orders=ParamUtil.getInt(request,"orders",7);	
		
		int usersNum=users.size();
   	int Page;
	Page=ParamUtil.getInt(request,"Page",1);


	
%>

<div align="center"><center>

<form name="searchuser" method="POST" action="admin_user.jsp">
<font color=red>点击用户名进行相应操作</font>，  查找用户:  <input type="text" name="txtitle" size="13"><input type="submit" value="查询" name="title">
</form>
<form method=Post action="admin_user.jsp">
    <div align="center">



      <div align="center"><center>
<table border="0" cellspacing="0" width="100%"  cellpadding="0">
        <tr>
          <td width="46" align="center" bgcolor="<%=aTableTitleColor%>" height="20"><strong>ID号</strong></td>
          <td width="400" align="center" bgcolor="<%=aTableTitleColor%>"><strong>用户名</strong></td>
          <td width="68" align="center" bgcolor="<%=aTableTitleColor%>"><input type='submit'  value='删除'></td>
        </tr>
<%
	

		for (i=(Page-1)*20;i<Page*20;i++){
			if (i>=usersNum) break;
			User theUser=(User)users.get(i);
%>
        <tr>
          <td height="23" width="46"><p align="center"><%=theUser.getUserID()%></td>
          <td width="400"><p align="center"><a href="dispuser.jsp?name=<%=java.net.URLEncoder.encode(theUser.getUserName())%>"><%=theUser.getUserName()%></a></td>
          <td width="68"><p align="center"><input type='checkbox' name='userID' value='<%=theUser.getUserID()%>'></td>
        </tr>
<% 
		}
%>
      </table>
      </center></div>

  <%
	int totalPages=usersNum/20+1; 
if (Page==0)  Page=1;
out.println("共 "+totalPages+" 页 第 "+Page+" 页　");
if (Page==1|| totalPages==1 )
			out.println("<font color=gray>首页　前页</font>");
else
	out.println("<a href=?Page=1&orders="+orders+"&txtitle="+ParamUtil.getString(request,"txtitle","")+">首页</a>　<a href=?Page="+(Page-1)+"&orders="+orders+"&txtitle="+ParamUtil.getString(request,"txtitle","")+">前页</a>");
		
		
		if (Page==totalPages|| totalPages==1)
			out.println("　<font color=gray>后页　尾页</font>");
		else
			out.println("　<a href=?Page="+(Page+1)+"&orders="+orders+"&txtitle="+ParamUtil.getString(request,"txtitle","")+">后页</a>　<a href=?Page="+totalPages+"&orders="+orders+"&txtitle="+ParamUtil.getString(request,"txtitle","")+">尾页</a>");
		
%>

 
	      </td>
            </tr>
        </table>
        </td>
    </tr>
</table>
<%}%>
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
