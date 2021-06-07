<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="INC/const.jsp"%>
<%@ page import = "java.util.Vector"%>
<%
	stats=forumName+"论坛短消息处理.";
	forumID=ParamUtil.getInt(request,"forumID",0);
	
	
%>
<%@ include file="INC/theme.jsp"%>
<%
out.println(headLine(1,forumName,forumLogo,"",1,stats));
%>
<script language="javascript">
function DoTitle(addTitle) { 
var revisedTitle; 
var currentTitle = document.messager.touser.value; 
revisedTitle = currentTitle+addTitle; 
document.messager.touser.value=revisedTitle; 
document.messager.touser.focus(); 
return; }
</script>
<%
try{


	if(!foundUser)
		throw new Exception("您没有<a href=login.jsp target=_blank>登录</a>");
	FriendsManager theManager=new FriendsManager(request);
	String action=ParamUtil.getString(request,"action");
	String sender=ParamUtil.getString(request,"touser","");
	int id=ParamUtil.getInt(request,"id",1);
	out.println( "<TABLE border=0 width="+tableWidth+" align=center><TBODY>"+
				"<TR><TD align=left></TD>"+
				"<TD Align=right>  <a href=usersms.jsp?action=inbox><img src=pic/m_inbox.gif border=0 alt=收件箱></a> &nbsp; <a href=usersms.jsp?action=outbox><img src=pic/m_outbox.gif border=0 alt=发件箱></a> &nbsp; <a href=usersms.jsp?action=issend><img src=pic/m_issend.gif border=0 alt=已发送邮件></a>&nbsp; <a href=usersms.jsp?action=recycle><img src=pic/m_recycle.gif border=0 alt=废件箱></a>&nbsp; <a href=friendlist.jsp><img src=pic/m_address.gif border=0 alt=地址簿></a>&nbsp;<a href=usersms.jsp?action=new&id=><img src=pic/m_write.gif border=0 alt=发送消息></a> &nbsp;<a href=usersms.jsp?action=new&touser="+response.encodeURL(sender)+"&id="+id+"><img src=pic/m_reply.gif border=0 alt=回复消息></a> &nbsp;<a href=usersms.jsp?action=fw&id="+id+"><img src=pic/m_fw.gif border=0 alt=转发消息></a>&nbsp;<a href=usersms.jsp?action=delete&id="+id+"><img src=pic/m_delete.gif border=0 alt=删除消息></a>"+
				"</TD></TR></TBODY></TABLE><br>");

	
//'收件箱
	if(action==null||"info".equals(action.trim())||"".equals(action.trim())){
	

%>
<form action="friendlist.jsp" method=post name=inbox>
    <table cellpadding=0 cellspacing=0 border=0 width="<%=tableWidth%>" bgcolor=<%=tableBackColor%> align=center>
        <tr>
            <td>
                <table cellpadding=3 cellspacing=1 border=0 width=100%>
            <tr bgcolor=<%=tableTitleColor%>>
                <td align=center valign=middle width="25%"><font color="<%=tableFontColor%>"><b>姓名</b></font></td>
                <td align=center valign=middle width="25%"><font color="<%=tableFontColor%>"><b>邮件</b></font></td>
                <td align=center valign=middle width="25%"><font color="<%=tableFontColor%>"><b>主页</b></font></td>
                <td align=center valign=middle width="10%"><font color="<%=tableFontColor%>"><b>OICQ</b></font></td>
                <td align=center valign=middle width="10%"><font color="<%=tableFontColor%>"><b>发短信</b></font></td>
                <td align=center valign=middle width="5%"><font color="<%=tableFontColor%>"><b>操作</b></font></td>
            </tr>
<%
	Vector friendInfo=theManager.getFriendInfo(request);
	if(friendInfo.size()==0){
%>
                <tr>
                <td bgcolor=<%=tableBodyColor%> align=center valign=middle colspan=6><font color="<%=tableContentColor%>">您的好友列表中没有任何内容。</font></td>
                </tr>
<%}else{%>
<%
	for(i=0;i<friendInfo.size();i++){
		Friend friend=(Friend)friendInfo.get(i);
%>
                <tr bgcolor="<%=tableBodyColor%>">
                    <td align=center valign=middle><font color="<%=tableContentColor%>"><a href="dispuser.jsp?name=<%=response.encodeURL(friend.getFriendFriend())%>" target=_blank><%=friend.getFriendFriend()%></a></font></td>
                    <td align=center valign=middle><font color="<%=tableContentColor%>"><a href="mailto:<%=friend.getFriendEmail()%>"><%=friend.getFriendEmail()%></a></font></td>
                    <td align=center><font color="<%=tableContentColor%>">
					<%
						if(friend.getFriendHomePage()!=null&&!"".equals(friend.getFriendHomePage().trim())){
					%>
						<a href="<%=friend.getFriendHomePage()%>" target=_blank><%=friend.getFriendHomePage()%></a>
					<%
					}
					else {out.println("无");}
					%></font></td>
                    <td align=center>
					<%
						if(friend.getFriendOicq()!=null&&!"".equals(friend.getFriendOicq().trim())){
					%>
						<a href="<%=friend.getFriendOicq()%>" target=_blank><%=friend.getFriendOicq()%></a>
					<%
					}
					else {out.println("无");}
					%></td>
                    <td align=center><a href="usersms.jsp?action=new&touser=<%=response.encodeURL(friend.getFriendFriend())%>">发送</a></td>
                <td align=center><input type=checkbox name=id value=<%=friend.getFriendID()%>></td>
                </tr>
<%
	
	}
	}
	
%>
                
        <tr bgcolor="<%=tableTitleColor%>"> 
          <td align=right valign=middle colspan=6><input type=checkbox name=chkall value=on onclick="CheckAll(this.form)">选中所有显示记录&nbsp;<input type=button name=action onclick="location.href='friendlist.jsp?action=addF'" value="添加好友">&nbsp;<input type=submit name=action onclick="{if(confirm('确定删除选定的纪录吗?')){this.document.inbox.submit();return true;}return false;}" value="删除">&nbsp;<input type=submit name=action onclick="{if(confirm('确定清除所有的纪录吗?')){this.document.inbox.submit();return true;}return false;}" value="清空好友"></td>
                </tr>
                </table></td></tr></table></form>
<%
	}
		  else if(action.equals("删除")){
			  theManager.delFriend(request);
			  response.sendRedirect("friendlist.jsp?action=success&msg="+java.net.URLEncoder.encode("删除好友成功！"));
			  
		  }
		  else if(action.equals("清空好友")){
			  theManager.allDelFriend();
			  response.sendRedirect("friendlist.jsp?action=success&msg="+java.net.URLEncoder.encode("清空好友成功！"));
			  
		  }
		  else if(action.equals("addF")){

%>
<form action="friendlist.jsp" method=post name=messager>
  <table cellpadding=0 cellspacing=0 border=0 width="<%=tableWidth%>" bgcolor=<%=tableBackColor%> align=center>
    <tr> 
      <td> 
        <table cellpadding=3 cellspacing=1 border=0 width=100%>
          <tr> 
            <td bgcolor=<%=tableTitleColor%> colspan=2 align=center> 
              <input type=hidden name="action" value="saveF">
              <font color="<%=tableFontColor%>"><b>加入好友</b>--请完整输入下列信息</font></td>
          </tr>
          <tr> 
            <td bgcolor=<%=tableBodyColor%> valign=middle width=70><font color="<%=tableContentColor%>"><b>好友：</b></font></td>
            <td bgcolor=<%=tableBodyColor%> valign=middle><font color="<%=tableContentColor%>">
              <input type=text name="touser" size=50 value="<%=ParamUtil.getString(request,"myFriend","")%>">
			  &nbsp;使用逗号（,）分开，最多5位用户</font>
            </td>
          </tr>
          <tr> 
            <td bgcolor=<%=tableTitleColor%> valign=middle colspan=2 align=center> 
              <input type=Submit value="保存" name=Submit>
              &nbsp; 
              <input type="reset" name="Clear" value="清除">
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</form>
<%
		  }
			  else if(action.equals("saveF")){
				  theManager.saveFriend(request);
				  response.sendRedirect("friendlist.jsp?action=success&msg="+java.net.URLEncoder.encode("添加好友成功！"));
			  }

			else if(action.equals("success")){
%>
    <table cellpadding=0 cellspacing=0 border=0 width="<%=tableWidth%>" bgcolor=<%=tableBackColor%> align=center>
        <tr>
            <td>
                <table cellpadding=3 cellspacing=1 border=0 width=100%>
    <tr align="center"> 
      <td width="100%" bgcolor=<%=tableTitleColor%>><font color="<%=tableFontColor%>">成功：好友列表</font></td>
    </tr>
    <tr> 
      <td width="100%" bgcolor=<%=tableBodyColor%>><font color="<%=tableContentColor%>"><%=new String(ParamUtil.getString(request,"msg","").getBytes("ISO-8859-1"),"GBK")%></font>
      </td>
    </tr>
    </table>   </td></tr></table>
<%
			}
		else 
			throw new Exception("错误请求！");
	}
	catch(Exception e){
		e.printStackTrace();
		String errMsg=e.getMessage();
		%>
		<%@include file="INC/error.jsp"%>
		<%
	}
%>
<script language="JavaScript">
<!--
function CheckAll(form)  {
  for (var i=0;i<form.elements.length;i++)    {
    var e = form.elements[i];
    if (e.name != 'chkall')       e.checked = form.chkall.checked; 
   }
  }
//-->
</script>
<%@ include file="foot.jsp"%>