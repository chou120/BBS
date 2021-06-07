<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="INC/const.jsp"%>
<%@ page import = "java.util.Vector"%>
<%
	stats=forumName+"论坛搜索";
	forumID=ParamUtil.getInt(request,"forumID",0);
	
	
%>
<%@ include file="INC/theme.jsp"%>
<%
out.println(headLine(1,forumName,forumLogo,"",1,stats));
%>



 <table cellpadding=0 cellspacing=0 border=0 width="<%=tableWidth%>" bgcolor="<%=tableBackColor%>" align=center>
    <tr><td>
    <table cellpadding=5 cellspacing=1 border=0 width=100%>
    
						<tr>
						<td bgcolor="<%=tableTitleColor%>" valign=middle colspan=2 align="center">
						<p><form action="queryresult.jsp" method="post">
						<font color="<%=tableFontColor%>"><b>请输入要搜索的关键字</b></font></td></tr>
						<tr>
						<td bgcolor="<%=tableBodyColor%>" colspan=2 align="center" valign="middle"><font  color="<%=tableContentColor%>">
						(同时查询多个条件使用'<font  color="<%=alertFontColor%>">or</font>' 分隔关键字，查询同时满足某条件使用'<font  color="<%=alertFontColor%>">and</font>'分隔关键字)</font><br><br><input type=text size=40 name="keyword"></td></tr>
                        <tr>
						<td bgcolor="<%=aTableBodyColor%>" valign=middle colspan=2 align=center><font  color="<%=tableContentColor%>"><b>搜索选项</b></font></td></tr>

                        <tr>
						<td bgcolor="<%=tableBodyColor%>" align="right" valign="middle"><font color="<%=tableContentColor%>">
                        <b>作者搜索</b></font>&nbsp;<input name="sType" type="radio" value="1">
                        </td>
                        <td bgcolor="<%=tableBodyColor%>" align="left" valign="middle">
                        <select name="nSearch">
						                  <option value=1>搜索主题作者
						                  <option value=2>搜索回复作者
						                  <option value=3>两者都搜索
						                  </select>
						                  
                        </td>
                        </tr>
                        <tr>
                        <td bgcolor="<%=tableBodyColor%>" align="right" valign="middle"><font color="<%=tableContentColor%>">
                        <b>关键字搜索</b></font>&nbsp;<input name="sType" type="radio" value="2" checked>
                        </td>
                        <td bgcolor="<%=tableBodyColor%>" align="left" valign="middle">
                        <select name="pSearch">
						                  <option value=1>在主题中搜索关键字
						                  
						                  </select>
						                  
                        </td>
                        </tr>
                        <tr>
                        <td bgcolor="<%=tableBodyColor%>" align="right" valign="middle"><font color="<%=tableContentColor%>">
                        <b>日期范围</b></font>
                        </td>
                        <td bgcolor="<%=tableBodyColor%>" align="left" valign="middle">
<select name=SearchDate class=smallsel> <option value=ALL>所有日期<option value=1>昨天以来<option  selected value=5>5天以来<option value=10>10天以来<option value=30>30天以来</option></select> 
						                  
                        </td>
                        </tr>
                        <tr>
						<td bgcolor="<%=aTableBodyColor%>" valign="middle" colspan=2 align=center><font color="<%=tableContentColor%>"><b>请选择要搜索的论坛 (不要选那些用 >> 和 << 括起来的，那只是类别名，不是论坛)</b></font></td></tr>
						<tr>
						<td bgcolor="<%=tableBodyColor%>" colspan="2" valign="middle" align="center"><font color="<%=tableContentColor%>">
                        <b>搜索论坛： &nbsp; 
<select name=forumID size=1>
<option value=0 <%if(forumID==0){out.println("selected");}%>>所有论坛</option>
<%
	try{
		Vector gateWayVector=GateWayFactory.getGateWays();
		for( i=0;i<gateWayVector.size();i++)
		{
    			GateWay gateWay=(GateWay)gateWayVector.get(i);
    			int gateWayID=gateWay.getGateWayID();
    			String gateWayName=gateWay.getGateWayName();
				out.println("<option style=BACKGROUND-COLOR:#99ccff>╋ "+gateWayName+"</option>");
				try{
					Vector forumVector=ForumFactory.getForums(gateWayID);
					for(int j=0;j<forumVector.size();j++){
						Forum theListForum=(Forum)forumVector.get(j);
						
						out.println("<option");
						if(forumID==theListForum.getForumID())
							out.println("selected");
							out.println("value=\""+theListForum.getForumID()+"\">　├"+theListForum.getForumType()+"</option>");
					}
				}
				catch(Exception e){
					e.printStackTrace();
				}
		}
	}
	catch(Exception e){
		e.printStackTrace();
	}
	%>
</select>
						</b></td>
						</tr>
						<tr>
						<td bgcolor="<%=tableTitleColor%>" valign=middle colspan=2 align=center>
						<input type=submit value="开始搜索">
						</td></form></tr></table></td></tr></table>

<%@include file="foot.jsp"%>
