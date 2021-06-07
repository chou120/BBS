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
		String action=ParamUtil.getString(request,"action");

	
%>
<table cellpadding=0 cellspacing=0 border=0 width=95% bgcolor=<%=aTableBackColor%> align=center>
  <tr>
    <td>
      <table cellpadding=3 cellspacing=1 border=0 width=100%>
        <tr bgcolor='<%=aTableTitleColor%>'>
        <td align=center colspan="2">欢迎<b><%=session.getAttribute("adminFlag")%></b>进入管理页面
        </td>
        </tr>
            <tr bgcolor=<%=tableBodyColor%>>
              <td width="20%" valign=top>
<%@include file="admin_left.jsp"%>
	      </td>
              <td width="80%" valign=top><p>
<%
		if(action!=null&&"update".equals(action)){
			ForumAdmin forumAdmin=new ForumAdmin();
			out.println(forumAdmin.update()+"<br>操作成功！");
		  }
		else{
%>
              <table width="100%" border="0" cellspacing="3" cellpadding="0">
                <tr> 
                  <td bgcolor=<%=aTableTitleColor%>> 
                    <p><b>更新论坛数据</b>：<br>
                      注意：这里将重新统计所有论坛的最新帖子、最新发表时间、发表帖子数等信息。</p>
                  </td>
                </tr>
                <tr> 
                  <td> 
            <form action="admin_updateboard.jsp?action=update" method=post>
<input type="submit" name="Submit" value="更新">
	    </form>
                  </td>
                </tr>
<%
	}
%>
</p></td>
            </tr>
        </table>
        </td>
    </tr>
</table>

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