<%@ page contentType="text/html;charset=GBK"%>
<%@include file="INC/const.jsp"%>

<%	stats="修改个人资料";
%>
<%@ include file="INC/theme.jsp"%>
 <%
	out.println(headLine(forumID,forumName,forumLogo,"",1,stats));
 %>
 <%String action=ParamUtil.getString(request,"action");
	
	if(action!=null&&("update").equals(action)){
		if(foundUser){
			try
			{
				UserManager.updateUser(request);
		

%>
<table cellpadding=0 cellspacing=0 border=0 width=95% bgcolor=<%=aTableBackColor%> align=center>
        <tr>
            <td>
                <table cellpadding=3 cellspacing=1 border=0 width=100%>
    <tr align="center"> 
      <td width="100%" bgcolor=<%=aTableTitleColor%>>成功：修改资料</td>
    </tr>
    <tr> 
      <td width="100%" bgcolor=<%=tableBodyColor%>><b>恭喜您，您的资料修改成功</b><br>
      </td>
    </tr>
    <tr align="center"> 
      <td width="100%" bgcolor=<%=aTableTitleColor%>>
<a href="javascript:history.go(-1)"> << 返回上一页</a>
      </td>
    </tr>  
    </table>   </td></tr></table>
<%
		}
catch(Exception e){
	String errMsg=e.getMessage();
	%>
<%@ include file="INC/error.jsp"%>
	<%
}
}

else{
	String errMsg="<li>对不起，没有此用户";
%>

<%
}
	}
	else
	{
 
 %>
 
 <%
	try{
		if(foundUser){
		User theUser=UserManager.findUser(userName);
%>
<form action="mymodify.jsp?action=update" method=POST name="theForm">
<input type="hidden" name="userName" value="<%=userName%>">
<table cellpadding=0 cellspacing=0 border=0 width=<%=tableWidth%> bgcolor=<%=tableBackColor%> align=center>
        <tr>
            <td>
                <table cellpadding=3 cellspacing=1 border=0 width=100%>
    <tr align="center"> 
      <td colspan="2" width="100%" bgcolor=<%=tableTitleColor%> height=25><font color="<%=tableFontColor%>"><b><%=response.encodeURL(userName)%>修改资料</b></font></td>
    </tr>
      <tr bgcolor=<%=tableBodyColor%>>    
        <td width="40%"><font color="<%=tableContentColor%>"><B>性别</B>：<BR>请选择您的性别</font></td>   
        <td width="60%"><input type="radio" value="1"<%if ("1".equals(theUser.getSex())){%> checked <%}%>name="sex">酷哥
      <input type="radio" name="sex"<%if ("0".equals(theUser.getSex())){%> checked <%}%> value="0">靓妹</td>
</td>   
      </tr>   
      <tr bgcolor=<%=tableBodyColor%>>    
        <td width="40%"><font color="<%=tableContentColor%>"><B>密码</B>：<BR>如要修改请直接输入</font></td>   
        <td width="60%">    
          <input type="password" name="userPassword" value="<%=response.encodeURL(theUser.getUserPassword())%>" size=30 maxlength=13>   
        </td>   
      </tr>   
      
      <tr bgcolor=<%=tableBodyColor%>>    
        <td width="40%"><font color="<%=tableContentColor%>"><B>Email地址</B>：<BR>请输入有效的邮件地址，这将保证您在论坛中的私人资料。</font></td>   
        <td width="60%">    
          <input type="TEXT" name="userEmail" size=30 maxlength=50 value="<%if(theUser.getUserEmail()!=null&&!theUser.getUserEmail().equals("")) {%><%=response.encodeURL(theUser.getUserEmail())%><%}%>">   
        </td>   
      </tr>   
     
<%if (titleFlag!=null&&titleFlag.equals("1")){%>
<%if (theUser.getUserClass()>5){%>
      <tr bgcolor=<%=tableBodyColor%>> 
        <td width="40%"><font color="<%=tableContentColor%>"><B>头衔</B>：</font></td>   
        <td width="60%"> <input type="text" name="title" value="<%if(theUser.getTitle()!=null&&!theUser.getTitle().equals("")){ %><%=response.encodeURL(theUser.getTitle())%><%}%>" size=15 maxlength=13> </td>   
      </tr>   
<%}%>
<%}%>
      <tr bgcolor=<%=tableBodyColor%>>    
        <td width="40%" valign=top><font color="<%=tableContentColor%>"><B>头像</B>：<BR>
您可以选择一个个性图片，当你发表时将显示在您的名字下方。<BR>
如果你填写了下面的自定义头像部分，那么你的头像以自定义的为准。否则，请你留空自定义头像的所有栏目！<BR>
<B>关于自定义头像</B>：<BR>
你也可以在这里给出你自定义头像的 URL 地址，头像的高度和宽度(像素)。 如果不想要自定义头像，请将相应栏目栏目全部留空！</font>
		</td>   
        <td width="60%">    <font color="<%=tableContentColor%>">
<select name=face style="font-family:arial" size=1 onChange="document.images['face'].src=options[selectedIndex].value; parent.document.forms[0].myface.value=options[selectedIndex].value"> 
<% 
	
	int startP=(picURL+"Image").length();
	int oldFaceNum=0;
	try{
		oldFaceNum = Integer.parseInt(theUser.getFace().substring(startP,startP+2));
	}
	catch(Exception e){
		try{
			oldFaceNum = Integer.parseInt(theUser.getFace().substring(startP,startP+1));
		}
		catch(Exception e1){
			oldFaceNum=1;
		}
	}
	
	%>
	<%for(i=1;i<61;i++){%>
<option value='<%=picURL%>Image<%=i%>.gif' <%if(i==oldFaceNum){ out.println("selected");}%>>Image<%=i%></option>
<%}%>
                </select>&nbsp;&nbsp;<img id=face src="<%=theUser.getFace()%>" width=<%=theUser.getWidth()%> height=<%=theUser.getHeight()%>><BR><BR>

		
		
		  图像位置：<input type="TEXT" name="myface" size=20 maxlength=100 value=<%=theUser.getFace()%>><br>
	  宽&nbsp;&nbsp;&nbsp;&nbsp;度：<input type="TEXT" name="width" size=2 maxlength=2 value=<%=theUser.getWidth()%>>20---120的整数<br>
	  高&nbsp;&nbsp;&nbsp;&nbsp;度：<input type="TEXT" name="height" size=2 maxlength=2 value=<%=theUser.getHeight()%>>20---120的整数<br></font>
        </td>   
      </tr>	  
      <tr bgcolor=<%=tableBodyColor%>>    
        <td width="40%"><font color="<%=tableContentColor%>"><B>主页地址</B>：<BR>如果您有主页，请输入主页地址。此项可选</font></td>   
        <td width="60%">    
          <input type="TEXT" name="homePage" value="<%if (theUser.getHomePage()!=null&&!theUser.getHomePage().equals("")){ %><%=response.encodeURL(theUser.getHomePage())%><%}%>" size=30 maxlength=100>   
        </td>   
      </tr>   


      <tr bgcolor=<%=tableBodyColor%>>    
        <td width="40%"><font color="<%=tableContentColor%>"><B>OICQ号码</B>：<BR>如果您有 OICQ，请输入号码。此项可选</font></td>   
        <td width="60%">    
          <input type="TEXT" name="oicq" value="<%if(theUser.getOicq()!=null&&!("").equals(theUser.getOicq())){%><%=response.encodeURL(theUser.getOicq())%><%}%>" size=30 maxlength=20>   
        </td>   
      </tr>
      
      
      
      <tr bgcolor=<%=tableBodyColor%>>    
        <td valign=top width="40%"><font color="<%=tableContentColor%>"><B>签名</B>：<BR>不能超过 300 个字符   
          <br>   
          文字将出现在您发表的文章的结尾处。</font></td>   
        <td width="60%">
		<%
		  String signature="";
		if(theUser.getNoFilterSign()!=null&&!("").equals(theUser.getNoFilterSign()))
			signature=theUser.getNoFilterSign();
		  %>
          <textarea name="sign" rows=5 cols=60 wrap=PHYSICAL><%=signature%></textarea>   
        </td>   
      </tr> 
      
    <tr align="center"> 
      <td colspan="2" width="100%" bgcolor=<%=tableTitleColor%>>
            <input type=Submit value="更 新" name="Submit"> &nbsp; <input type="reset" name="Submit2" value="清 除">
      </td>
    </tr>  
    </table>   </td></tr></table> 
</form>  
<%
 }
	else throw new Exception("<li>对不起，您没有登陆，或者非法登陆了</li>");
	}
	catch(Exception e){
		out.println(e.getMessage());
	}
	}%>
<%@ include file="foot.jsp"%>