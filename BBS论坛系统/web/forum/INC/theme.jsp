<%@ page import ="net.acai.util.*,
		  net.acai.forum.*,
		  java.util.Hashtable"%>
<%! 
public String headLine(int forumID,String forumName,String forumLogo,String forumType,int files,String stats){
	StringBuffer buf=new StringBuffer();
	buf.append("<TABLE border=0 width=\"95%\" align=center><TBODY><TR>"+
			"<TD vAlign=top width=\"30%\"><img border=0 src="+forumLogo+"></TD>"+
			"<TD valign=middle align=top> &nbsp;&nbsp;<img src=pic/closedfold.gif border=0>&nbsp;&nbsp;<a href=index.jsp>"+forumName+"</a><br>");
	switch(files){
	case 1:
	buf.append("&nbsp;&nbsp;<img src=pic/bar.gif border=0 width=15 height=15><img src=pic/closedfold.gif border=0>&nbsp;&nbsp;"+stats);
	break;
	case 2:
	buf.append("&nbsp;&nbsp;<img src=pic/bar.gif border=0 width=15 height=15><img src=pic/closedfold.gif border=0>&nbsp;&nbsp;"+
			"<a href=list.jsp?forumID="+forumID+">"+forumType+"</a>"+ 
			"<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src=pic/bar.gif border=0 width=15 height=15><img src=pic/openfold.gif border=0>&nbsp;&nbsp;"+stats+"");
	break;
	}
	buf.append("<a name=top></a></TD></TR></TBODY></TABLE><br>");
	return buf.toString();
}
%>
<%
	
	lastLogin="";
	userName=GCookie.getCookieValue(request,"UJBBUName","");
	userPassword=GCookie.getCookieValue(request,"UJBBUPSW","");
	if(!"".equals(userName)&&!"".equals(userPassword))
		try{
			User loginUser=SkinUtil.userLogin(userName,userPassword,4);
			
			int userClass=loginUser.getUserClass();
			lastLogin=loginUser.getLastLogin();
			foundUser=true;
			if(userClass==18)
				guibin=true;
			else if(userClass==19)
				forumMaster=true;
			else if(userClass==20)
				master=true;
			else
				foundUser=true;
			
		}
		catch(Exception e){
			foundUser=false;
		}
	if("".equals(lastLogin))	lastLogin=NDate;
		
	

%>
<html>
<head>
<meta NAME=GENERATOR Content=\"Microsoft FrontPage 4.0\" CHARSET=GB2312>
<title><%=forumName%>--<%=stats%></title>
<link rel=stylesheet type=text/css href=forum.css>
<style>
	TABLE {BORDER-TOP: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 1px; }
	TD {BORDER-RIGHT: 0px; BORDER-TOP: 0px; color: #000000; }
</style>

</head>
<%@include file="js.jsp"%>
<body bgcolor=#ffffff alink=#333333 vlink=#333333 link=#333333 topmargin=0>
<script Language="JavaScript">
//***********默认设置定义.*********************
tPopWait=50;//停留tWait豪秒后显示提示。
tPopShow=5000;//显示tShow豪秒后关闭提示
showPopStep=20;
popOpacity=99;

//***************内部变量定义*****************
sPop=null;
curShow=null;
tFadeOut=null;
tFadeIn=null;
tFadeWaiting=null;

document.write("<style type='text/css'id='defaultPopStyle'>");
document.write(".cPopText {  background-color: #F8F8F5;color:#000000; border: 1px #000000 solid;font-color: font-size: 12px; padding-right: 4px; padding-left: 4px; height: 20px; padding-top: 2px; padding-bottom: 2px; filter: Alpha(Opacity=0)}");
document.write("</style>");
document.write("<div id='dypopLayer' style='position:absolute;z-index:1000;' class='cPopText'></div>");


function showPopupText(){
var o=event.srcElement;
	MouseX=event.x;
	MouseY=event.y;
	if(o.alt!=null && o.alt!=""){o.dypop=o.alt;o.alt=""};
        if(o.title!=null && o.title!=""){o.dypop=o.title;o.title=""};
	if(o.dypop!=sPop) {
			sPop=o.dypop;
			clearTimeout(curShow);
			clearTimeout(tFadeOut);
			clearTimeout(tFadeIn);
			clearTimeout(tFadeWaiting);	
			if(sPop==null || sPop=="") {
				dypopLayer.innerHTML="";
				dypopLayer.style.filter="Alpha()";
				dypopLayer.filters.Alpha.opacity=0;	
				}
			else {
				if(o.dyclass!=null) popStyle=o.dyclass 
					else popStyle="cPopText";
				curShow=setTimeout("showIt()",tPopWait);
			}
			
	}
}

function showIt(){
		dypopLayer.className=popStyle;
		dypopLayer.innerHTML=sPop;
		popWidth=dypopLayer.clientWidth;
		popHeight=dypopLayer.clientHeight;
		if(MouseX+12+popWidth>document.body.clientWidth) popLeftAdjust=-popWidth-24
			else popLeftAdjust=0;
		if(MouseY+12+popHeight>document.body.clientHeight) popTopAdjust=-popHeight-24
			else popTopAdjust=0;
		dypopLayer.style.left=MouseX+12+document.body.scrollLeft+popLeftAdjust;
		dypopLayer.style.top=MouseY+12+document.body.scrollTop+popTopAdjust;
		dypopLayer.style.filter="Alpha(Opacity=0)";
		fadeOut();
}

function fadeOut(){
	if(dypopLayer.filters.Alpha.opacity<popOpacity) {
		dypopLayer.filters.Alpha.opacity+=showPopStep;
		tFadeOut=setTimeout("fadeOut()",1);
		}
		else {
			dypopLayer.filters.Alpha.opacity=popOpacity;
			tFadeWaiting=setTimeout("fadeIn()",tPopShow);
			}
}

function fadeIn(){
	if(dypopLayer.filters.Alpha.opacity>0) {
		dypopLayer.filters.Alpha.opacity-=1;
		tFadeIn=setTimeout("fadeIn()",1);
		}
}
document.onmouseover=showPopupText;
</script>
<table width=95% align=center cellspacing=0 cellpadding=1  border=0 bgcolor="<%=tableBackColor%>">
	<tr><td>
		<table style=color:<%=tableFontColor%> width=100% cellspacing=0 cellpadding=4 border=0 >
			<tr bgcolor="<%=tableTitleColor%>">
			<td valign=middle ><FONT COLOR="<%=tableFontColor%>"> >> 

<%
if(userName.equals(""))
	out.println(""+(new String("欢迎您，".getBytes("ISO-8859-1"),"GBK"))+"<a href=login.jsp><FONT COLOR="+tableFontColor +">"+(new String("请先登陆".getBytes("ISO-8859-1"),"GBK"))+"</FONT></a> | <a href=reg.jsp><FONT COLOR="+ tableFontColor +">"+(new String("注册".getBytes("ISO-8859-1"),"GBK"))+"</FONT></a>");
else
	out.println(""+(new String("欢迎您，".getBytes("ISO-8859-1"),"GBK"))+"<b>"+userName +"</b> "+(new String("：".getBytes("ISO-8859-1"),"GBK"))+"<a href=login.jsp><FONT COLOR="+ tableFontColor +">"+(new String("重登陆".getBytes("ISO-8859-1"),"GBK"))+"</FONT></a> | <a href=mymodify.jsp?name="+ java.net.URLEncoder.encode(userName) +">"+
				"<FONT COLOR="+ tableFontColor +">"+(new String("更改信息".getBytes("ISO-8859-1"),"GBK"))+"</FONT></a> | <a href=\"usersms.jsp?action=inbox\" ><FONT COLOR="+ tableFontColor +">"+(new String("短消息".getBytes("ISO-8859-1"),"GBK"))+"</FONT></a> | "+
				"<a href=favlist.jsp><FONT COLOR="+ tableFontColor +">"+(new String("收藏".getBytes("ISO-8859-1"),"GBK"))+"</FONT></a>");

			
out.println(" | <a href=toplist.jsp?orders=1 ><FONT COLOR="+ tableFontColor +">"+(new String("发贴排行".getBytes("ISO-8859-1"),"GBK"))+"</FONT></a> | <a href=query.jsp?forumID="+forumID+"><FONT COLOR="+ tableFontColor +">"+(new String("搜索".getBytes("ISO-8859-1"),"GBK"))+"</FONT></a>");
out.println(" | <a href=help.jsp><FONT COLOR="+ tableFontColor +">"+(new String("帮助".getBytes("ISO-8859-1"),"GBK"))+"</FONT></a> | <a href=logout.jsp><FONT COLOR="+ tableFontColor +">"+(new String("退出".getBytes("ISO-8859-1"),"GBK"))+"</FONT></a>");
if(master||forumMaster)
out.println(" | <a href=elogin.jsp><FONT COLOR="+ tableFontColor +">"+(new String("管理".getBytes("ISO-8859-1"),"GBK"))+"</FONT></a>");


out.println("</td><td valign=middle align=right><FONT COLOR="+ tableFontColor +
			"><a href='"+ forumURL +"'><img src=pic/gohome.gif border=0></a></FONT>"+
			"</td></tr></table></td></tr></table>"+
			"<center><iframe src=\"stat.jsp?stats="+stats+"\" width=\"95%\" height=25 marginwidth=0 marginheight=0 hspace=0 vspace=0 frameborder=0 scrolling=NO></iframe></center>");

	
%>