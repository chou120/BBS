<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="net.acai.forum.util.*"%>
<%@ include file="INC/const.jsp"%>

<%
	stats="用户注册";
%>
<%@ include file="INC/theme.jsp"%>
<%
	userName=ParamUtil.getString(request,"userName","");
	try
	{
		ForumFactory.addUser(request,wealthReg,epReg,cpReg);	

%>
<table cellpadding=0 cellspacing=0 border=0 width=500 bgcolor=<%=aTableBackColor%> align=center>
<tr> 
<td> 
      <table cellpadding=3 cellspacing=1 border=0 width=500>
        <TBODY> 
        <TR align=middle bgcolor=<%=aTableTitleColor%>> 
          <TD colSpan=2 height=24><b>用户注册成功</b></TD>
        </TR>
        <TR bgcolor=<%=tableBodyColor%>> 
          <TD colspan=2><center><b> 

      <%if (emailFlag==0) {%><center>
            <b>欢迎使用本系统，有任何问题，请与网管(<a href=mailto:<%=systemEmail%>><%=systemEmail%></A>)联系!</b> 
            <%}else if (emailFlag==1) {
    out.println( "<center><b> 一封注册信已经发送到你您注册时填写的信箱，请查收！</b>");
  	}
  	%>
        
          </TD>
        </TR>
        <TR bgcolor=<%=tableBodyColor%>> 
          <TD width=35% height="32">注 册 名**</TD>
          <TD><%=userName%></TD>
        </TR>
        <TR bgcolor=<%=tableBodyColor%>> 
          <TD height="32" width="150">性 别</TD>
          <TD> 
            <%if (ParamUtil.getInt(request,"sex",0)==1) {%>
            男 
            <%} else {%>
            女 
            <%}%>
          </TD>
        </TR>
        <TR bgcolor=<%=tableBodyColor%>> 
          <TD height="32" width="150">密&nbsp;&nbsp;&nbsp;&nbsp;码**</TD>
          <TD><%=ParamUtil.getString(request,"userPassword","")%> </TD>
        </TR>
        <TR bgcolor=<%=tableBodyColor%>> 
          <TD height=32 width="150">Email地址 **</TD>
          <TD><%=ParamUtil.getString(request,"userEmail","")%></TD>
        </TR>
        <TR bgcolor=<%=tableBodyColor%>> 
          <TD height=32 width="150">形象**</TD>
          <TD><img src="<%=ParamUtil.getString(request,"face","")%>"> 
        </TR>
        <TR bgcolor=<%=tableBodyColor%>> 
          <TD height="32" width="150">财 产</TD>
          <TD><%=wealthReg%> 
        </TR>
        <TR bgcolor=<%=tableBodyColor%>> 
          <TD height="32" width="150">经验值</TD>
          <TD><%=epReg%> 
        </TR>
        <TR bgcolor=<%=tableBodyColor%>> 
          <TD height="32" width="150">魅力值</TD>
          <TD><%=cpReg%> 
        </TR>
        <tr bgcolor=<%=tableBodyColor%>> 
          <td height="32" width="150">有回帖时是否提示</td>
          <td> 
<%if (ParamUtil.getInt(request,"showRe",0)==1)
out.println( "提示");
else
out.println("不提示");

%>
        </tr>
        <TR bgcolor=<%=tableBodyColor%>> 
          <TD height="32" width="150">OICQ号码</TD>
          <TD> 
            <%if (ParamUtil.getString(request,"oicq","").equals("")){%>
            未注册 
            <% }else {%>
            <%=ParamUtil.getString(request,"oicq","")%> 
            <%}%>
          </TD>
        </TR>
        <TR bgcolor=<%=tableBodyColor%>> 
          <TD width=150>签 名<BR>
            <BR>
            文字将出现在您发表的文章的结尾处。体现您的个性。 </TD>
          <TD> 
            <%if (ParamUtil.getString(request,"sign","").equals("")) {%>
            未填写 
            <%} else {%>
            <%=(new String(ParamUtil.getString(request,"sign","").getBytes("ISO-8859-1"),"GBK"))%> 
            <%}%>
          </TD>
        </TR>
        
        <TR align=middle bgcolor=<%=aTableTitleColor%>> 
          <TD colSpan=2 align=center> <a href=login.jsp>请登陆论坛</a> </TD>
        </TR>
        </TBODY> 
      </TABLE>
</td>
</tr>
</table>
<%

	}
	catch(Exception e){
		e.printStackTrace();
		out.print(e.getMessage());
	}
	
%>
<%@ include file="foot.jsp"%>
