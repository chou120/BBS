<%@ page language="java"  contentType="text/html; charset=gb2312"%>
<%@ include file="INC/const.jsp"%>
<%@ page import = "java.util.Vector"%>
<%
	stats=forumName+"论坛搜索结果";
	forumID=ParamUtil.getInt(request,"forumID",0);
	int perPage=ParamUtil.getInt(request,"perPage",10);
	int Page=ParamUtil.getInt(request,"Page",1);
	int startPage=((Page-1)/10)*10+1;
	int start=(Page-1)*perPage+1;
	
	
%>

<%@ include file="INC/theme.jsp"%>
<%
out.println(headLine(1,forumName,forumLogo,"",1,stats));
%>
<%
	try{

			ForumSearch forumSearch=new ForumSearch();
			Vector searchTopics=forumSearch.getResult(request,response);
			forumID=ParamUtil.getInt(request,"forumID",0);
			int sType=ParamUtil.getInt(request,"sType");
			int pSearch=ParamUtil.getInt(request,"pSearch",0);
			int nSearch=ParamUtil.getInt(request,"nSearch",0);
			String keyword=ParamUtil.getString(request,"keyword","");
			int searchDateLimit=30;
			String searchDate=ParamUtil.getString(request,"SearchDate");
			String orderName=forumSearch.getOrderName();
			int totalNum=forumSearch.getSearchTopicNum();
%>
            <table cellpadding=0 cellspacing=0 border=0 width="<%=tableWidth%>" align=center>
            <tr><td><font color="<%=bodyFontColor%>">查询<%=searchDateLimit%>天内的帖子，<%=orderName%>共查询到<font color=<%=alertFontColor%>><%=totalNum%></font>个结果</font>
		</td>
            </tr>
            </table>
            <table cellpadding=0 cellspacing=0 border=0 width="<%=tableWidth%>" bgcolor=<%=tableBackColor%> align=center>
            <tr><td height=1>
		</td>
            </tr>
            </table>
<TABLE bgColor="<%=tableBackColor%>" border=0 cellPadding=0 cellSpacing=0 width="<%=tableWidth%>" align=center>
  <TBODY>
  <TR>
    <td bgcolor=<%=tableBackColor%> valign=middle width=1></td>
    <TD align=middle height=25 bgColor="<%=tableTitleColor%>" width=32><font color=<%=tableFontColor%>>状态</font></TD> 
    <td bgcolor=<%=tableBackColor%> valign=middle width=1></td>
    <TD align=middle bgColor="<%=tableTitleColor%>" width=*><font color=<%=tableFontColor%>>主 题  (点心情符为开新窗浏览)</font></TD> 
    <td bgcolor=<%=tableBackColor%> valign=middle width=1></td>
    <TD align=middle bgColor="<%=tableTitleColor%>" width=80><font color=<%=tableFontColor%>>作 者 </font></TD> 
    <td bgcolor=<%=tableBackColor%> valign=middle width=1></td>
    <TD align=middle bgColor="<%=tableTitleColor%>" width=64><font color=<%=tableFontColor%>>回复/人气</font></TD>
    <td bgcolor=<%=tableBackColor%> valign=middle width=1></td> 
    <TD align=middle bgColor="<%=tableTitleColor%>" width=195><font color=<%=tableFontColor%>>作者 | 发表时间</font></TD>
    <td bgcolor=<%=tableBackColor%> valign=middle width=1></td></TR> 
</TBODY></TABLE>
            <table cellpadding=0 cellspacing=0 border=0 width="<%=tableWidth%>" bgcolor=<%=tableBackColor%> align=center>
            <tr><td height=1>
		</td>
            </tr>
            </table>
<%
	
			
	for(i=0;i<searchTopics.size();i++){
		ForumTopic theTopic=(ForumTopic)searchTopics.get(i);
%>
<TABLE bgColor="<%=tableBackColor%>" border=0 cellPadding=0 cellSpacing=0 width="<%=tableWidth%>" align=center>
  <TBODY>
  <TR> 
    <td bgcolor=<%=tableBackColor%> valign=middle width=1 height=24></td>
    <TD align=middle bgColor="<%=tableBodyColor%>" width=32><font color=<%=tableContentColor%>>
<%if (theTopic.getLockTopic()){%><img src=<%=picURL%>lockfolder.gif alt="本主题已锁定"><%} else {%><%if (theTopic.getChildNum()>10) {%><img src=<%=picURL%>hotfolder.gif><%}else{%><img src=<%=picURL%>folder.gif><%}%><%}%></font>
    </TD> 
    <td bgcolor=<%=tableBackColor%> valign=middle width=1></td>
    <TD bgColor=<%=tableBodyColor%> width=*><font color=<%=tableContentColor%>><a href='dispbbs.jsp?forumID=<%=theTopic.getForumID()%>&rootID=<%=theTopic.getRootID()%>&announceID=<%=theTopic.getAnnounceID()%>&skin=1' target=_blank><img src='<%=faceURL%><%if(theTopic.getExpression()!=null&&!"".equals(theTopic.getExpression())){%><%=theTopic.getExpression()%><%}else{%>face1.gif<%}%>' border=0 alt="开新窗口浏览此主题"></a> <a href='dispbbs.jsp?forumID=<%=theTopic.getForumID()%>&rootID=<%=theTopic.getRootID()%>&announceID=<%=theTopic.getAnnounceID()%>'><%=theTopic.getNoFilterTopic()%></a></font>    </TD> 
    <td bgcolor=<%=tableBackColor%> valign=middle width=1></td>
    <TD align=middle bgColor="<%=tableBodyColor%>"  width=80><font color=<%=tableContentColor%>><a href="javascript:openScript('dispuser.jsp?name=<%=response.encodeURL(theTopic.getUserName())%>',350,300)"><%=response.encodeURL(theTopic.getUserName())%></a></font></TD> 
    <td bgcolor=<%=tableBackColor%> valign=middle width=1></td>
    <TD align=middle bgColor="<%=tableBodyColor%>" width=64><font color=<%=tableContentColor%>><%=theTopic.getChildNum()%>/<%=theTopic.getHits()%></font></TD> 
    <td bgcolor=<%=tableBackColor%> valign=middle width=1></td>
    <TD bgColor=<%=tableBodyColor%> width=195><font color=<%=tableContentColor%>>&nbsp;
<%=theTopic.getDateAndTime()%>
&nbsp;<font color="<%=alertFontColor%>">|</font>&nbsp;
<a href="javascript:openScript('dispuser.jsp?name=<%=response.encodeURL(theTopic.getUserName())%>',350,300)"><%=response.encodeURL(theTopic.getUserName())%></a>
</FONT></TD>
    <td bgcolor=<%=tableBackColor%> valign=middle width=1></td></TR> 
</TBODY></TABLE>
            <table cellpadding=0 cellspacing=0 border=0 width="<%=tableWidth%>" bgcolor=<%=tableBackColor%>  align=center>
            <tr><td height=1>
		</td>
            </tr>
            </table>
<%
}
	

	int n;
	
  	if (totalNum % perPage==0)
     		n= totalNum/perPage;
  	else
     		n= totalNum / perPage+1;
  
%>
   <script language="Javascript">
	function viewPage(ipage){
        document.frmList2.Page.value=ipage
        document.frmList2.submit() 
	}
		
   </script>
<table border="0" cellpadding="0" cellspacing="3" width="<%=tableWidth%>" align="center">
<form method="post" action="queryresult.jsp" name="frmList2">
  <tr>
    <td valign="middle" nowrap><font color="<%=bodyFontColor%>">页次：<b><%=Page%></b>/<b><%=n%></strong>页 每页<b><%=perPage%></b> 总贴数<b><%=totalNum%></b></td>
    <td valign="middle" nowrap><font color="<%=bodyFontColor%>">
      <div align="right"><p>分页：

<%
	  
	   for(int p=1;p<n+1;p++){
	   if (p<10){
	       if (p==Page){
	          out.println( "["+p+"] ");
		   }
		   else
		      out.println( "<a href='javascript:viewPage("+p+")' language='javascript'>["+p+"]</a>   ");
		   
		}
	}
%>
<span class="smallFont">转到:<input type="text" name="Page" size=3 maxlength=10  value="<%=Page%>"><input type="button" value="Go" language="javascript" onclick="viewPage(document.frmList2.Page.value)" id="button1" name="button1"></span></p>      
      </div>    </font>
    </td>
  </tr>	
<input type="hidden" name="sType" value="<%=sType%>">
<input type="hidden" name="pSearch" value="<%=pSearch%>">
<input type="hidden" name="nSearch" value="<%=nSearch%>">
<input type="hidden" name="keyword" value="<%=keyword%>">
<input type="hidden" name="SearchDate" value="<%=ParamUtil.getString(request,"SearchDate")%>">
<input type="hidden" name="forumID" value="<%=forumID%>">
</form>
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