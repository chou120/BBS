<%@ page contentType="text/html;charset=GBK"%>
<%@ page import = "net.acai.forum.SkinUtil,
			net.acai.util.*,
			net.acai.forum.*"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta HTTP-EQUIV="Expires" CONTENT="0">
<meta http-equiv="Refresh" content="300;URL=?stats=<%=ParamUtil.getString(request,"stats","论坛首页")%>">
</head>
<body bgcolor=#ffffff alink=#333333 vlink=#333333 link=#333333 topmargin=0 leftmargin=0>
<script>
function openScript(url, width, height){
	var Win = window.open(url,"openScript",'width=' + width + ',height=' + height + ',resizable=1,scrollbars=yes,menubar=no,status=yes' );
}
</script>
<%
	SkinUtil.checkUserStats(request,response);
	if(SMSManager.checkSMS(request)){
		SMSMSG sms=SMSManager.getNewSMS(request);
		if(sms!=null){
		out.println("<div align=\"right\" style=\"font-size:9pt;\">><img src=pic/newmail.gif><a href=javascript:openScript('usersms.jsp?action=read&id="+sms.getID()+"&sender="+sms.getSender()+"',420,320)>您有新短消息</a></div>");
		/*out.println("<script language=JavaScript>openScript('usersms.jsp?action=read&id="+sms.getID()+"&sender="+sms.getSender()+"',420,320)</script>");*/
		}
	}
	
	
%>
</body>
</html>