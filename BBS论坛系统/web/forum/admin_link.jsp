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
        <td align=center colspan="2">欢迎<b><%=session.getAttribute("adminName")%></b>进入管理页面
        </td>
        </tr>
            <tr bgcolor=<%=tableBodyColor%>>
              
          <td width="20%" valign=top> 
             <%@include file="admin_left.jsp"%>
            </td>
              
          <td width="80%" valign=top>
<%
	/*if request("action") = "add" then 
		call addlink()
	elseif request("action")="edit" then
		call editlink()
	elseif request("action")="savenew" then
		call savenew()
	elseif request("action")="savedit" then
		call savedit()
	elseif request("action")="del" then
		call del()
	elseif request("action")="orders" then
		call orders()
	elseif request("action")="updateorders" then
		call updateorders()
	else
		call linkinfo()
	}*/
%>     
   
<%
		if(action==null||"".equals(action)){
	%>
	 <table width="100%" border="0" cellspacing="3" cellpadding="0">
              <tr>
                <td>注意事项： <br>
                  在下面，您将看到目前所有的联盟论坛。您可以编辑联盟论坛名或是增加一个新的联盟论坛。 也可以编辑或删除目前存在的联盟论坛。您可以对目前的联盟重新进行排列。 
                </td>
              </tr>
            </table>
<%
	Vector forumLinkVector=new Vector();
	forumLinkVector=ForumLinkFactory.getForumLinks();
%> 
<br>
            <table width="100%" border="0" cellspacing="3" cellpadding="0">
              <tr bgcolor="<%=aTableTitleColor%>"> 
                <td height="22"><a href="admin_link.jsp?action=add">增加新的联盟论坛</a></td>
              </tr>
            </table>
<%
	for(i=0;i<forumLinkVector.size();i++){
		ForumLink forumLink=(ForumLink)forumLinkVector.get(i);
%>
<hr width=60% align=left color=black height=1>
            <table width="100%" border="0" cellspacing="3" cellpadding="0">
              <tr> 
                <td>联盟论坛名称：<%=forumLink.getForumName()%></td>
              </tr>
              <tr> 
                <td>联盟论坛 URL：<%=forumLink.getForumURL()%></td>
              </tr>
              <tr> 
                <td>联盟论坛简介：<%=forumLink.getReadMe()%></td>
              </tr>
              <tr align="left" valign="bottom"> 
                <td height="27"><a href="admin_link.jsp?action=edit&id=<%=forumLink.getLinkID()%>">编辑此联盟论坛</a> | <a href="admin_link.jsp?action=del&id=<%=forumLink.getLinkID()%>">删除此联盟论坛</a> | <a href="admin_link.jsp?action=orders&id=<%=forumLink.getLinkID()%>">联盟论坛重新排序</a></td>
              </tr>
            </table>

<%
}
%>
<hr width=60% align=left color=black height=1>
            <table width="100%" border="0" cellspacing="3" cellpadding="0">
              <tr bgcolor=<%=aTableTitleColor%>> 
                <td height="20"><a href="admin_link.jsp?action=add">增加新的联盟论坛</a></td>
              </tr>
            </table>
            <br>
            <br>
          </td>
            </tr>
        </table>
	<%
	}

		
	else if(action.equals("add")){
%>
<form action="admin_link.jsp?action=savenew" method = post>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="30%">论坛名称： </td>
    <td width="70%"> 
      <input type="text" name="name" size=40>
    </td>
  </tr>
  <tr> 
    <td width="30%">连接URL： </td>
    <td width="70%"> 
      <input type="text" name="url" size=40>
    </td>
  </tr>
  <tr> 
    <td height="15" width="30%">论坛简介： </td>
    <td height="15" width="70%"> 
      <input type="text" name="readme" size=40>
    </td>
  </tr>
  <tr> 
    <td height="15" colspan="2"> 
      <div align="center"> 
        <input type="submit" name="Submit" value="添加">
      </div>
    </td>
  </tr>
</table>
</form>
<%
		}
		else if(action.equals("edit")){
	int forumLinkID=ParamUtil.getInt(request,"id",0);
	ForumLink forumLink=ForumLinkFactory.getForumLink(forumLinkID);
%>
<form action="admin_link.jsp?action=savedit" method=post>
<input type=hidden name=id value=<%=forumLinkID%>>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="30%">论坛名称： </td>
    <td width="70%"> 
      <input type="text" name="name" size=40 value=<%=forumLink.getForumName()%>>
    </td>
  </tr>
  <tr> 
    <td width="30%">连接URL： </td>
    <td width="70%"> 
      <input type="text" name="url" size=40 value=<%=forumLink.getForumURL()%>>
    </td>
  </tr>
  <tr> 
    <td height="15" width="30%">论坛简介： </td>
    <td height="15" width="70%"> 
      <input type="text" name="readme" size=40 value=<%=forumLink.getReadMe()%>>
    </td>
  </tr>
  <tr> 
    <td height="15" colspan="2"> 
      <div align="center"> 
        <input type="submit" name="Submit" value="修改">
      </div>
    </td>
  </tr>
</table>
</form>
<%
	
		}
		else if(action.equals("savenew")){


			ForumLinkAdmin.saveNew(request);
			out.println("操作成功！");
		}
		else if(action.equals("savedit")){
			ForumLinkAdmin.saveEdit(request);
			out.println("操作成功！");
		}
		else if(action.equals("del")){
			ForumLinkAdmin.del(request);
			out.println("操作成功！");
		}
		else if(action.equals("orders")){
			
%><br>
            <table width="95%" border="0" cellspacing="3" cellpadding="0" align=center>
              <tr> 
                <td height="22"><b>联盟论坛重新排序</b><br>
注意：请在相应论坛的排序表单内输入相应的排列序号，注意不能和别的联盟论坛有相同的排列序号。
		</td>
              </tr>
	      <tr>
              <tr bgcolor="<%=aTableTitleColor%>"> 
                <td height="22" align=center><a href="admin_link.jsp?action=add">增加新的联盟论坛</a></td>
              </tr>
	      <tr>
		<td>
<%
	int forumLinkID=ParamUtil.getInt(request,"id",0);
	ForumLink forumLink=ForumLinkFactory.getForumLink(forumLinkID);
	out.println( "<form action=admin_link.jsp?action=updateorders method=post>");
	out.println( forumLink.getForumName()+"  <input type=text name=newid size=2 value="+forumLink.getLinkID()+">");
	out.println( "<input type=hidden name=id value="+forumLink.getLinkID()+">");
	out.println( "<input type=submit name=Submit value=修改></form>");
%>
		</td>
	      </tr>
              <tr bgcolor="<%=aTableTitleColor%>"> 
                <td height="22" align=center><a href="admin_link.jsp?action=add">增加新的联盟论坛</a></td>
              </tr>
            </table>
<%
		}
		else if(action.equals("updateorders")){
			ForumLinkAdmin.updateOrders(request);
			out.println("操作成功！");
		}
		else{
%>		 <table width="100%" border="0" cellspacing="3" cellpadding="0">
              <tr>
                <td>注意事项： <br>
                  在下面，您将看到目前所有的联盟论坛。您可以编辑联盟论坛名或是增加一个新的联盟论坛。 也可以编辑或删除目前存在的联盟论坛。您可以对目前的联盟重新进行排列。 
                </td>
              </tr>
            </table>
<%
	Vector forumLinkVector=new Vector();
	forumLinkVector=ForumLinkFactory.getForumLinks();
%> 
<br>
            <table width="100%" border="0" cellspacing="3" cellpadding="0">
              <tr bgcolor="<%=aTableTitleColor%>"> 
                <td height="22"><a href="admin_link.jsp?action=add">增加新的联盟论坛</a></td>
              </tr>
            </table>
<%
	for(i=0;i<forumLinkVector.size();i++){
		ForumLink forumLink=(ForumLink)forumLinkVector.get(i);
%>
<hr width=60% align=left color=black height=1>
            <table width="100%" border="0" cellspacing="3" cellpadding="0">
              <tr> 
                <td>联盟论坛名称：<%=forumLink.getForumName()%></td>
              </tr>
              <tr> 
                <td>联盟论坛 URL：<%=forumLink.getForumURL()%></td>
              </tr>
              <tr> 
                <td>联盟论坛简介：<%=forumLink.getReadMe()%></td>
              </tr>
              <tr align="left" valign="bottom"> 
                <td height="27"><a href="admin_link.jsp?action=edit&id=<%=forumLink.getLinkID()%>">编辑此联盟论坛</a> | <a href="admin_link.jsp?action=del&id=<%=forumLink.getLinkID()%>">删除此联盟论坛</a> | <a href="admin_link.jsp?action=orders&id=<%=forumLink.getLinkID()%>">联盟论坛重新排序</a></td>
              </tr>
            </table>

<%
}
%>
<hr width=60% align=left color=black height=1>
            <table width="100%" border="0" cellspacing="3" cellpadding="0">
              <tr bgcolor=<%=aTableTitleColor%>> 
                <td height="20"><a href="admin_link.jsp?action=add">增加新的联盟论坛</a></td>
              </tr>
            </table>
            <br>
            <br>
          </td>
            </tr>
        </table>
	<%
	}

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
     </td>
    </tr>
</table>
<%@ include file="foot.jsp"%>