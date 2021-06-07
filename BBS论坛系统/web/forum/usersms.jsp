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
	if(foundUser){
		SMSManager smsManager=new SMSManager(request,response);
		String sender=ParamUtil.getString(request,"sender","");
		int id=ParamUtil.getInt(request,"id",0);
		String action=new String(ParamUtil.getString(request,"action").getBytes("ISO-8859-1"),"GBK");
		if(action==null||"".equals(action.trim()))
			throw new Exception("错误请求！");
		action=action.trim();
		String msg="";
out.println( "<TABLE border=0 width="+tableWidth+" align=center><TBODY>"+
				"<TR><TD align=left></TD>"+
				"<TD Align=right>  <a href=usersms.jsp?action=inbox><img src=pic/m_inbox.gif border=0 alt=收件箱></a> &nbsp; <a href=usersms.jsp?action=outbox><img src=pic/m_outbox.gif border=0 alt=发件箱></a> &nbsp; <a href=usersms.jsp?action=issend><img src=pic/m_issend.gif border=0 alt=已发送邮件></a>&nbsp; <a href=usersms.jsp?action=recycle><img src=pic/m_recycle.gif border=0 alt=废件箱></a>&nbsp; <a href=friendlist.jsp><img src=pic/m_address.gif border=0 alt=地址簿></a>&nbsp;<a href=usersms.jsp?action=new&id=><img src=pic/m_write.gif border=0 alt=发送消息></a> &nbsp;<a href=usersms.jsp?action=new&touser="+response.encodeURL(sender)+"&id="+id+"><img src=pic/m_reply.gif border=0 alt=回复消息></a> &nbsp;<a href=usersms.jsp?action=fw&id="+id+"><img src=pic/m_fw.gif border=0 alt=转发消息></a>&nbsp;<a href=usersms.jsp?action=delete&id="+id+"><img src=pic/m_delete.gif border=0 alt=删除消息></a>"+
				"</TD></TR></TBODY></TABLE><br>");
/*if founderr=true then
	call error()
else
	select case request("action")
	case "inbox"
		call inbox()
	case "outbox"
		call outbox()
	case "issend"
		call issend()
	case "recycle"
		call recycle()
	case "new"
		call sendmsg()
	case "read"
		call read()
	case "outread"
		call read()
	case "delete"
		call delete()
	case "send"
		call savemsg()
	case "newmsg"
		call newmsg()
	case "fw"
		call fw()
	case "edit"
		call edit()
	case "savedit"
		call savedit()
	case "删除收件"
		call delinbox()
			<b>恭喜您，删除短信息成功。</b><br>删除的消息将转移到您的回收站。
	case "清空收件箱"
		恭喜您，删除短信息成功。</b><br>删除的消息将转移到您的回收站。
	case "删除发件"
		call deloutbox()
	case "清空发件箱"
		call AllDeloutbox()
	case "删除已发信息"
		call delissend()
	case "清空已发送信息"
		call AllDelissend()
	case "删除指定信息"
		call delrecycle()
	case "清空回收站"
		call AllDelrecycle()
	case else
		call inbox()
	end select
	if founderr then call error()
}*/
//收件箱

		if(action.equals("inbox")){
%>
<form action="usersms.jsp" method=post name=inbox>
    <table cellpadding=0 cellspacing=0 border=0 width=<%=tableWidth%> bgcolor=<%=tableBackColor%> align=center>
        <tr>
            <td>
                <table cellpadding=3 cellspacing=1 border=0 width=100%>
            <tr bgcolor=<%=tableTitleColor%>>
                <td align=center valign=middle width=30><font color="<%=tableFontColor%>"><b>已读</b></font></td>
                <td align=center valign=middle width=100><font color="<%=tableFontColor%>"><b>发件人</b></font></td>
                <td align=center valign=middle width=300><font color="<%=tableFontColor%>"><b>主题</b></font></td>
                <td align=center valign=middle width=150><font color="<%=tableFontColor%>"><b>日期</b></font></td>
                <td align=center valign=middle width=50><font color="<%=tableFontColor%>"><b>大小</b></font></td>
                <td align=center valign=middle width=30><font color="<%=tableFontColor%>"><b>操作</b></font></td>
            </tr>
<%

	Vector smsVector=smsManager.getInBox();
	if(smsVector.size()==0){
%>
                <tr>
                <td bgcolor=<%=tableBodyColor%> align=center valign=middle colspan=6><font color="<%=tableContentColor%>">您的收件箱中没有任何内容。</font></td>
                </tr>
<%}else{%>
<%
	for(i=0;i<smsVector.size();i++){
		SMSMSG sms=(SMSMSG)smsVector.get(i);
%>
                <tr bgcolor=<%if (sms.getFlag()==0){%>"<%=aTableBodyColor%>"<%}else{%>"<%=tableBodyColor%>"<%}%>>
                    <td align=center valign=middle><%if (sms.getFlag()==0) {%><img src="pic/m_news.gif"><%}else{%><img src="<%=picURL%>m_olds.gif"><%}%></td>
                    <td align=center valign=middle><%if (sms.getFlag()==0) {%><b><%}%><a href="dispuser.jsp?name=<%=response.encodeURL(sms.getSender())%>" target=_blank><%=response.encodeURL(sms.getSender())%></a></td>
                    <td align=left><a href="usersms.jsp?action=read&id=<%=sms.getID()%>&sender=<%=sms.getSender()%>"><%if (sms.getFlag()==0) {%><b><%}%><%=response.encodeURL(sms.getTitle())%></a>	</td>
                    <td><font color="<%=tableContentColor%>"><%if (sms.getFlag()==0) {%><b><%}%><%=sms.getSendtime()%></font></td>
                    <td><font color="<%=tableContentColor%>"><%if (sms.getFlag()==0) {%><b><%}%><%=sms.getContent().length()%>Byte</font></td>
                <td align=center valign=middle width=30><input type=checkbox name=id value=<%=sms.getID()%>></td>
                </tr>
<%
		}
}

%>
                
        <tr bgcolor="<%=tableTitleColor%>"> 
          <td align=right valign=middle colspan=6><font color="<%=tableFontColor%>">节省每一分空间，请及时删除无用信息&nbsp;<input type=checkbox name=chkall value=on onclick="CheckAll(this.form)">选中所有显示记录&nbsp;<input type=submit name=action onclick="{if(confirm('确定删除选定的纪录吗?')){this.document.inbox.submit();return true;}return false;}" value="删除收件">&nbsp;<input type=submit name=action onclick="{if(confirm('确定清除收件箱所有的纪录吗?')){this.document.inbox.submit();return true;}return false;}" value="清空收件箱"></font></td>
                </tr>
                </table></td></tr></table></form>
<%
			
		}
		else if(action.equals("send")){
			smsManager.saveSMS(request);
			response.sendRedirect("usersms.jsp?action=success&msg="+java.net.URLEncoder.encode("发送短消息成功！"));
		}
		else if(action.equals("删除收件")){
			smsManager.delInBox(request);
			response.sendRedirect("usersms.jsp?action=success&msg="+java.net.URLEncoder.encode("删除短消息成功，并把他保存在垃圾箱中！"));
		}
		 else if(action.equals("清空收件箱")){
			smsManager.allDelInBox();
			response.sendRedirect("usersms.jsp?action=success&msg="+java.net.URLEncoder.encode("删除短消息成功，并把他保存在垃圾箱中！"));
		}
		  //收件箱
		else if(action.equals("outbox")){
%>
<form action="usersms.jsp" method=post name=inbox>
    <table cellpadding=0 cellspacing=0 border=0 width=<%=tableWidth%> bgcolor=<%=tableBackColor%> align=center>
        <tr>
            <td>
                <table cellpadding=3 cellspacing=1 border=0 width=100%>
            <tr bgcolor=<%=tableTitleColor%>>
                <td align=center valign=middle width=30><font color="<%=tableFontColor%>"><b>已读</b></font></td>
                <td align=center valign=middle width=100><font color="<%=tableFontColor%>"><b>收件人</b></font></td>
                <td align=center valign=middle width=300><font color="<%=tableFontColor%>"><b>主题</b></font></td>
                <td align=center valign=middle width=150><font color="<%=tableFontColor%>"><b>日期</b></font></td>
                <td align=center valign=middle width=50><font color="<%=tableFontColor%>"><b>大小</b></font></td>
                <td align=center valign=middle width=30><font color="<%=tableFontColor%>"><b>操作</b></font></td>
            </tr>
<%
	Vector outBox=smsManager.getOutBox();
	if(outBox.size()==0){
%>
                <tr>
                <td bgcolor=<%=tableBodyColor%> align=center valign=middle colspan=6><font color="<%=tableContentColor%>">您的发件箱中没有任何内容。</font></td>
                </tr>
<%}else{%>
<%	
	for(i=0;i<outBox.size();i++){
		SMSMSG sms=(SMSMSG)outBox.get(i);
	
	%>
                <tr bgcolor=<%if (sms.getFlag()==0) {%>"<%=aTableBodyColor%>"<%}else{%>"<%=tableBodyColor%>"<%}%>>
                    <td align=center valign=middle><img src="<%=picURL%>m_issend_2.gif"></td>
                    <td align=center valign=middle><%if (sms.getFlag()==0) {%><b><%}%><a href="dispuser.jsp?name=<%=response.encodeURL(sms.getIncept())%>" target=_blank><%=response.encodeURL(sms.getIncept())%></a></td>
                    <td align=left><a href="usersms.jsp?action=edit&id=<%=sms.getID()%>"><%if (sms.getFlag()==0) {%><b><%}%><%=response.encodeURL(sms.getTitle())%></a>	</td>
                    <td><font color="<%=tableContentColor%>"><%if (sms.getFlag()==0) {%><b><%}%><%=sms.getSendtime()%></font></td>
                    <td><font color="<%=tableContentColor%>"><%if (sms.getFlag()==0) {%><b><%}%><%=sms.getContent().length()%>Byte</font></td>
                <td align=center valign=middle width=30><input type=checkbox name=id value=<%=sms.getID()%>></td>
                </tr>
<%
		}
	}
%>
                
        <tr bgcolor="<%=tableTitleColor%>"> 
          <td align=right valign=middle colspan=6><font color="<%=tableFontColor%>">节省每一分空间，请及时删除无用信息&nbsp;<input type=checkbox name=chkall value=on onclick="CheckAll(this.form)">选中所有显示记录&nbsp;<input type=submit name=action onclick="{if(confirm('确定删除选定的纪录吗?')){this.document.inbox.submit();return true;}return false;}" value="删除发件">&nbsp;<input type=submit name=action onclick="{if(confirm('确定清除发件箱所有的纪录吗?')){this.document.inbox.submit();return true;}return false;}" value="清空发件箱"></font></td>
                </tr>
                </table></td></tr></table></form>
<%
		}
		  else if(action.equals("删除发件")){
			smsManager.delOutBox(request);
			response.sendRedirect("usersms.jsp?action=success&msg="+java.net.URLEncoder.encode("删除短消息成功，并把他保存在垃圾箱中！"));
		}
		 else if(action.equals("清空发件箱")){
			smsManager.allDelOutBox();
			response.sendRedirect("usersms.jsp?action=success&msg="+java.net.URLEncoder.encode("删除短消息成功，并把他保存在垃圾箱中！"));
		}
		else if(action.equals("issend")){
%>
<form action="usersms.jsp" method=post name=inbox>
    <table cellpadding=0 cellspacing=0 border=0 width=<%=tableWidth%> bgcolor=<%=tableBackColor%> align=center>
        <tr>
            <td>
                <table cellpadding=3 cellspacing=1 border=0 width=100%>
            <tr bgcolor=<%=tableTitleColor%>>
                <td align=center valign=middle width=30><font color="<%=tableFontColor%>"><b>已读</b></font></td>
                <td align=center valign=middle width=100><font color="<%=tableFontColor%>"><b>收件人</b></font></td>
                <td align=center valign=middle width=300><font color="<%=tableFontColor%>"><b>主题</b></font></td>
                <td align=center valign=middle width=150><font color="<%=tableFontColor%>"><b>日期</b></font></td>
                <td align=center valign=middle width=50><font color="<%=tableFontColor%>"><b>大小</b></font></td>
                <td align=center valign=middle width=30><font color="<%=tableFontColor%>"><b>操作</b></font></td>
            </tr>
<%
	Vector isSend=smsManager.getIsSend();
	if(isSend.size()==0){
%>
                <tr>
                <td bgcolor=<%=tableBodyColor%> align=center valign=middle colspan=6><font color="<%=tableContentColor%>">您的已发送信息中没有任何内容。</font></td>
                </tr>
<%}else{%>
<%
	for(i=0;i<isSend.size();i++){
		SMSMSG sms=(SMSMSG)isSend.get(i);
%>
                <tr bgcolor=<%if (sms.getFlag()==0) {%>"<%=aTableBodyColor%>"<%}else{%>"<%=tableBodyColor%>"<%}%>>
                    <td align=center valign=middle><img src="<%=picURL%>m_issend_1.gif"></td>
                    <td align=center valign=middle><%if (sms.getFlag()==0) {%><b><%}%><a href="dispuser.jsp?name=<%=response.encodeURL(sms.getIncept())%>" target=_blank><%=response.encodeURL(sms.getIncept())%></a></td>
                    <td align=left><a href="usersms.jsp?action=outread&id=<%=sms.getID()%>"><%if (sms.getFlag()==0) {%><b><%}%><%=response.encodeURL(sms.getTitle())%></a>	</td>
                    <td><font color="<%=tableContentColor%>"><%if (sms.getFlag()==0) {%><b><%}%><%=sms.getSendtime()%></font></td>
                    <td><font color="<%=tableContentColor%>"><%if (sms.getFlag()==0) {%><b><%}%><%=sms.getContent().length()%>Byte</font></td>
                <td align=center valign=middle width=30><input type=checkbox name=id value=<%=sms.getID()%>></td>
                </tr>
<%
	
		}
	}
	
%>
                
        <tr bgcolor="<%=tableTitleColor%>"> 
          <td align=right valign=middle colspan=6><font color="<%=tableFontColor%>">节省每一分空间，请及时删除无用信息&nbsp;<input type=checkbox name=chkall value=on onclick="CheckAll(this.form)">选中所有显示记录&nbsp;<input type=submit name=action onclick="{if(confirm('确定删除选定的纪录吗?')){this.document.inbox.submit();return true;}return false;}" value="删除已发信息">&nbsp;<input type=submit name=action onclick="{if(confirm('确定清除已发送信息所有的纪录吗?')){this.document.inbox.submit();return true;}return false;}" value="清空已发送信息"></font></td>
                </tr>
                </table></td></tr></table></form>
<%
		}
		  else if(action.equals("删除已发信息")){
			smsManager.delIsSend(request);
			response.sendRedirect("usersms.jsp?action=success&msg="+java.net.URLEncoder.encode("删除短消息成功，并把他保存在垃圾箱中！"));
		}
		 else if(action.equals("清空已发送信息")){
			smsManager.allDelIsSend();
			response.sendRedirect("usersms.jsp?action=success&msg="+java.net.URLEncoder.encode("删除短消息成功，并把他保存在垃圾箱中！"));
		}
//'已发送逻辑删除，置于回收站，入口字段delS，可用于批量及单个删除
//'delS：0未操作，1发送者删除，2发送者从回收站删除

		else if(action.equals("recycle")){
%>
<form action="usersms.jsp" method=post name=inbox>
    <table cellpadding=0 cellspacing=0 border=0 width=<%=tableWidth%> bgcolor=<%=tableBackColor%> align=center>
        <tr>
            <td>
                <table cellpadding=3 cellspacing=1 border=0 width=100%>
            <tr bgcolor=<%=tableTitleColor%>>
                <td align=center valign=middle width=30><font color="<%=tableFontColor%>"><b>已读</b></font></td>
                <td align=center valign=middle width=100><font color="<%=tableFontColor%>"><b>名字</b></font></td>
                <td align=center valign=middle width=300><font color="<%=tableFontColor%>"><b>主题</b></font></td>
                <td align=center valign=middle width=150><font color="<%=tableFontColor%>"><b>日期</b></font></td>
                <td align=center valign=middle width=50><font color="<%=tableFontColor%>"><b>大小</b></font></td>
                <td align=center valign=middle width=30><font color="<%=tableFontColor%>"><b>操作</b></font></td>
            </tr>
<%
	Vector recycle = smsManager.getRecycle();
	if(recycle.size()==0){
%>
                <tr>
                <td bgcolor=<%=tableBodyColor%> align=center valign=middle colspan=6><font color="<%=tableContentColor%>">您的废件箱中没有任何内容。</font></td>
                </tr>
<%}else{%>
<%
	for(i=0;i<recycle.size();i++){
	SMSMSG sms=(SMSMSG)recycle.get(i);
%>
                <tr bgcolor=<%if (sms.getFlag()==0) {%>"<%=aTableBodyColor%>"<%}else{%>"<%=tableBodyColor%>"<%}%>>
                    <td align=center valign=middle><font face="宋体" color="#333333"><%if (sms.getFlag()==0) {%><img src="pic/m_news.gif"><%}else{%><img src="pic/m_olds.gif"><%}%></font></td>
                    <td align=center valign=middle><%if (sms.getFlag()==0) {%><b><%}%><a href="dispuser.jsp?name=<%=response.encodeURL(sms.getIncept())%>" target=_blank><%=response.encodeURL(sms.getIncept())%></a></td>
                    <td align=left><a href="usersms.jsp?action=read&id=<%=sms.getID()%>"><%if (sms.getFlag()==0) {%><b><%}%><%=response.encodeURL(sms.getTitle())%></a>	</td>
                    <td><font color="<%=tableContentColor%>"><%if (sms.getFlag()==0) {%><b><%}%><%=sms.getSendtime()%></font></td>
                    <td><font color="<%=tableContentColor%>"><%if (sms.getFlag()==0) {%><b><%}%><%=sms.getContent().length()%>Byte</font></td>
                <td align=center valign=middle width=30><input type=checkbox name=id value=<%=sms.getID()%>></td>
                </tr>
<%
		}
	}
	
%>
                
        <tr bgcolor="<%=tableTitleColor%>"> 
          <td align=right valign=middle colspan=6><font color="<%=tableFontColor%>">节省每一分空间，请及时删除无用信息&nbsp;<input type=checkbox name=chkall value=on onclick="CheckAll(this.form)">选中所有显示记录&nbsp;<input type=submit name=action onclick="{if(confirm('确定删除选定的纪录吗?')){this.document.inbox.submit();return true;}return false;}" value="删除指定信息">&nbsp;<input type=submit name=action onclick="{if(confirm('确定清除回收站所有的纪录吗?')){this.document.inbox.submit();return true;}return false;}" value="清空回收站"></font></td>
                </tr>
                </table></td></tr></table></form>
<%
		}
		  else if(action.equals("删除指定信息")){
			smsManager.delRecycle(request);
			response.sendRedirect("usersms.jsp?action=success&msg="+java.net.URLEncoder.encode("删除短消息成功，并把他保存在垃圾箱中！"));
		}
		 else if(action.equals("清空回收站")){
			smsManager.allDelRecycle();
			response.sendRedirect("usersms.jsp?action=success&msg="+java.net.URLEncoder.encode("删除短消息成功，并把他保存在垃圾箱中！"));
		}
		
//发送信息
		else if(action.equals("new")){

	String title="";
	String sendtime="";
	String content="";
	boolean fwSign=false;
	try{
		SMSMSG sms=smsManager.getSMSMSG(request);
		sendtime=sms.getSendtime();
		title="RE " + sms.getTitle();
		content=sms.getContent();
		fwSign=true;
	}
	catch(Exception e){
	}

%>
<form action="usersms.jsp" method=post name=messager>
  <table cellpadding=0 cellspacing=0 border=0 width=<%=tableWidth%> bgcolor=<%=tableBackColor%> align=center>
    <tr> 
      <td> 
        <table cellpadding=3 cellspacing=1 border=0 width=100%>
          <tr> 
            <td bgcolor=<%=tableTitleColor%> colspan=2 align=center> 
              <input type=hidden name="action" value="send">
              <font color="<%=tableFontColor%>"><b>发送短消息</b>--请完整输入下列信息</font></td>
          </tr>
          <tr> 
            <td bgcolor=<%=tableBodyColor%> valign=middle width=70><font color="<%=tableContentColor%>"><b>收件人：</b></font></td>
            <td bgcolor=<%=tableBodyColor%> valign=middle><font color="<%=tableContentColor%>">
              <input type=text name="touser" value="<%=ParamUtil.getString(request,"touser","")%>" size=50>
              <SELECT name=font onchange=DoTitle(this.options[this.selectedIndex].value)>
              <OPTION selected value="">选择</OPTION>
<%

	Vector friendList=FriendsManager.getFriendList(request);
	for(i=0;i<friendList.size();i++){
		Friend friend=(Friend)friendList.get(i);
%>
			  <OPTION value="<%=friend.getFriendFriend()%>"><%=friend.getFriendFriend()%></OPTION> 
<%
	}
%>
			  </SELECT>
			  &nbsp;使用逗号（,）分开，最多5位用户</font>
            </td>
          </tr>
          <tr> 
            <td bgcolor=<%=tableBodyColor%> valign=top><font color="<%=tableContentColor%>"><b>标题：</b></font></td>
            <td bgcolor=<%=tableBodyColor%> valign=middle><font color="<%=tableContentColor%>">
              <input type=text name="title" size=50 maxlength=80 value="<%=title%>">&nbsp;请限定50字内</font>
            </td>
          </tr>
          <tr> 
            <td bgcolor=<%=tableBodyColor%> valign=top><font color="<%=tableContentColor%>"><b>内容：</b><br></font></td>
            <td bgcolor=<%=tableBodyColor%> valign=middle>
              <textarea cols=70 rows=8 name="message" title="">

<%
	if(fwSign) {
%>
============= 在 <%=sendtime%> 您来信中写道： ============
<%=content%>
========================================================<%}%></textarea>
            </td>
          </tr>
          <tr> 
            <td bgcolor=<%=tableTitleColor%> valign=middle colspan=2 align=center> 
              <input type=Submit value="发送" name=Submit>
              &nbsp; 
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
//转发信息
		else if(action.equals("fw")){


	SMSMSG sms=smsManager.getSMSMSG(request,"fw");

%>
<form action="usersms.jsp" method=post name=messager>
  <table cellpadding=0 cellspacing=0 border=0 width=<%=tableWidth%> bgcolor=<%=tableBackColor%> align=center>
    <tr> 
      <td> 
        <table cellpadding=3 cellspacing=1 border=0 width=100%>
          <tr> 
            <td bgcolor=<%=tableTitleColor%> colspan=2 align=center> 
              <input type=hidden name="action" value="send">
              <font color="<%=tableFontColor%>"><b>发送短消息</b>--请完整输入下列信息</font></td>
          </tr>
          <tr> 
            <td bgcolor=<%=tableBodyColor%> valign=middle width=70><font color="<%=tableContentColor%>"><b>收件人：</b></font></td>
            <td bgcolor=<%=tableBodyColor%> valign=middle><font color="<%=tableContentColor%>">
              <input type=text name="touser" value="<%=ParamUtil.getString(request,"touser","")%>" size=50>&nbsp;使用逗号（,）分开，最多5位用户</font>
            </td>
          </tr>
          <tr> 
            <td bgcolor=<%=tableBodyColor%> valign=top><font color="<%=tableContentColor%>"><b>标题：</b></font></td>
            <td bgcolor=<%=tableBodyColor%> valign=middle><font color="<%=tableContentColor%>">
              <input type=text name="title" size=50 maxlength=80 value="Fw：<%=sms.getTitle()%>">&nbsp;请限定50字内</font>
            </td>
          </tr>
          <tr> 
            <td bgcolor=<%=tableBodyColor%> valign=top><font color="<%=tableContentColor%>"><b>内容：</b><br></font></td>
            <td bgcolor=<%=tableBodyColor%> valign=middle>
              <textarea cols=70 rows=8 name="message" title="">


========== 下面是转发信息 =========
原发件人：<%=sms.getSender()%><%="\n\n"%>
<%=sms.getContent()%>
===================================</textarea>
            </td>
          </tr>
          <tr> 
            <td bgcolor=<%=tableTitleColor%> valign=middle colspan=2 align=center> 
              <input type=Submit value="发送" name=Submit>
              &nbsp; 
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
//'更改信息
		else if(action.equals("edit")){

	SMSMSG sms=smsManager.getSMSMSG(request,"edit");
%>
<form action="usersms.jsp" method=post name=messager>
  <table cellpadding=0 cellspacing=0 border=0 width=<%=tableWidth%> bgcolor=<%=tableBackColor%> align=center>
    <tr> 
      <td> 
        <table cellpadding=3 cellspacing=1 border=0 width=100%>
          <tr> 
            <td bgcolor=<%=tableTitleColor%> colspan=2 align=center> 
              <input type=hidden name="action" value="savedit"> 
              <input type=hidden name="id" value="<%=sms.getID()%>">
              <font color="<%=tableFontColor%>"><b>发送短消息</b>--请完整输入下列信息</font></td>
          </tr>
          <tr> 
            <td bgcolor=<%=tableBodyColor%> valign=middle width=70><font color="<%=tableContentColor%>"><b>收件人：</b></font></td>
            <td bgcolor=<%=tableBodyColor%> valign=middle>
              <input type=text name="touser" value="<%=sms.getIncept()%>" size=70>
            </td>
          </tr>
          <tr> 
            <td bgcolor=<%=tableBodyColor%> valign=top><font color="<%=tableContentColor%>"><b>标题：</b></font></td>
            <td bgcolor=<%=tableBodyColor%> valign=middle><font color="<%=tableContentColor%>">
              <input type=text name="title" size=70 maxlength=80 value="<%=sms.getTitle()%>">&nbsp;请限定50字内</font>
            </td>
          </tr>
          <tr> 
            <td bgcolor=<%=tableBodyColor%> valign=top><font color="<%=tableContentColor%>"><b>内容：</b><br></font></td>
            <td bgcolor=<%=tableBodyColor%> valign=middle>
              <textarea cols=70 rows=8 name="message" title=""><%=sms.getContent()%></textarea>
            </td>
          </tr>
          <tr> 
            <td bgcolor=<%=tableTitleColor%> valign=middle colspan=2 align=center> 
              <input type=Submit value="发送" name=Submit>
              &nbsp; 
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
			  
//'读取信息
		else if(action.equals("savedit")){
			smsManager.saveSMS(request);
			response.sendRedirect("usersms.jsp?action=success&msg="+java.net.URLEncoder.encode("发送消息成功，并把他保存在发件箱箱中！"));
		}
		else if(action.equals("delete")){
			smsManager.delete(request);
			response.sendRedirect("usersms.jsp?action=success&msg="+java.net.URLEncoder.encode("删除消息成功，并把他保存在发件箱箱中！"));
		}
		else if(action.equals("read")||action.equals("outread")){


	SMSMSG sms=smsManager.getSMSMSG(request,"read");
%>
<table cellpadding=0 cellspacing=0 border=0 width=<%=tableWidth%> bgcolor=<%=tableBackColor%> align=center>
        <tr>
            <td>
                <table cellpadding=3 cellspacing=1 border=0 width=100%>
                
            <tr>
                <td bgcolor=<%=tableTitleColor%> align=center><font  color="<%=tableFontColor%>"><b>欢迎使用短消息接收，<%=userName%></b></font></td>
            </tr>
                <tr>
                    <td bgcolor=<%=aTableTitleColor%>><font color="<%=tableContentColor%>">
					<%if (action.equals("outread")) {%>
										在<b><%=sms.getSendtime()%></b>，您发送此消息给<b><%=response.encodeURL(sms.getIncept())%></b>！
					<%}else{%>
								在<b><%=sms.getSendtime()%></b>，<b><%=response.encodeURL(sms.getSender())%></b>给您发送的消息！
					<%}%></font></td>
                </tr>
                <tr>
                    <td bgcolor=<%=tableBodyColor%> valign=top align=left><font color=<%=tableContentColor%>>
                    <b>消息标题：<%=response.encodeURL(sms.getTitle())%></b><hr size=1>
                    <%=(new MyFilter(sms.getContent()).getFilterString())%></font>
		    </td>
                </tr>
                </table></td></tr></table>
<%
				}
			else if(action.equals("success")){
			
			%>

    <table cellpadding=0 cellspacing=0 border=0 width=<%=tableWidth%> bgcolor=<%=tableBackColor%> align=center>
        <tr>
            <td>
                <table cellpadding=3 cellspacing=1 border=0 width=100%>
    <tr align="center"> 
      <td width="100%" bgcolor=<%=tableTitleColor%>><font color="<%=tableFontColor%>">成功：短信息</font></td>
    </tr>
    <tr> 
      <td width="100%" bgcolor=<%=tableBodyColor%>><font color="<%=tableContentColor%>"><%=(new String(ParamUtil.getString(request,"msg","").getBytes("ISO-8859-1"),"GBK"))%></font>
      </td>
    </tr>
    </table>   </td></tr></table>
<%
			}
	else if(action.equals("newmsg")){
			%>


    <table cellpadding=0 cellspacing=0 border=0 width=<%=tableWidth%> bgcolor=<%=tableBackColor%> align=center>
        <tr>
            <td>
                <table cellpadding=3 cellspacing=1 border=0 width=100%>
    <tr align="center"> 
      <td width="100%" bgcolor=<%=tableTitleColor%>><font color="<%=tableFontColor%>">短消息通知</font></td>
    </tr>
    <tr> 
      <td width="100%" bgcolor=<%=tableBodyColor%> align=center><br>
<a href=usersms.jsp?action=inbox><img src="<%=picURL%>newmail.gif" border=0>有新的短消息</a><br>
                <br>
                <a href="usersms.jsp?action=inbox">按此查看</a><br><br>
      </td>
    </tr>
    </table>   </td></tr></table>
<%
	}
	else 
				throw new Exception("错误请求！");
	
	}

	else
		throw new Exception("请您先登陆！");
}
catch(Exception e){
	e.printStackTrace();
	String errMsg=e.getMessage();
	%>
	<%@include file="INC/error.jsp"%>
	<%
}%>

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