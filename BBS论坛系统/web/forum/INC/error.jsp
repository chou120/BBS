
<br><table cellpadding=0 cellspacing=0 border=0 width="<%=tableWidth%>" bgcolor="<%=tableBackColor%>" align=center>
		<tr><td><table cellpadding=3 cellspacing=1 border=0 width="100%"><tr align=center>
		<td width="100%" bgcolor="<%=tableTitleColor%>"><font color="<%=tableFontColor%>"><b><%=net.ds.toGBK("论坛错误信息")%></b></font></td>
		</tr><tr><td width="100%" bgcolor="<%=tableBodyColor%>">
		<font color="<%=tableContentColor%>"><b><%=net.ds.toGBK("产生错误的可能原因：")%></b><br><br>
		<li><%=net.ds.toGBK("您是否仔细阅读了")%><a href=help.jsp><font color="<%=tableContentColor%>"><%=net.ds.toGBK("帮助文件")%></font></a>
		<li><%=errMsg%></li></font></td></tr><tr align=center><td width="100%" bgcolor="<%=tableTitleColor%>">
		<a href=javascript:history.go(-1)><font color="<%=tableFontColor%>"> << <%=net.ds.toGBK("返回上一页")%></font></a>
		</td></tr>   </table>   </td></tr></table>