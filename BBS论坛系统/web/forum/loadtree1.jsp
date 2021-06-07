<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="net.acai.util.*,
		 net.acai.forum.*,
		 net.acai.forum.util.*,
		 java.util.Vector"%>
<%@ include file="INC/const.jsp"%>

<html>
<body>
<%
	String outtext="&nbsp;&nbsp;";
	forumID=ParamUtil.getInt(request,"forumID");
	int rootID=ParamUtil.getInt(request,"rootID");

	Vector followTopics=Forum.getFollowTopics(forumID,rootID);

%>
<script>
	parent.followTd<%=rootID%>.innerHTML='<TABLE bgColor="<%=tableBackColor%>" border=0 cellPadding=0 cellSpacing=0 width="100%" align=center><TBODY><%for(i=0;i<followTopics.size();i++){ForumTopic forumMSG=(ForumTopic)followTopics.get(i);%><TR><TD align=middle bgColor="<%=aTableBodyColor%>" width=32 height=27><font color="<%=tableContentColor%>"></font></TD><td bgcolor=<%=tableBackColor%> valign=middle width=1></td><TD bgcolor="<%=tableBodyColor%>" width=*><font color=<%=tableContentColor%>><%for (int j=2;j<=forumMSG.getLayer();j++){%><%=outtext%><%}%><img src="<%=picURL%>nofollow.gif"><a href="dispbbs.jsp?forumID=<%=forumID%>&rootID=<%=forumMSG.getRootID()%>&announceID=<%=forumMSG.getAnnounceID()%>&skin=1#<%=forumMSG.getAnnounceID()%>" title="<%=response.encodeURL(forumMSG.getNoFilterTopic())%>"><%=forumMSG.getNoFilterTopic()%></font></a> -- <a href="dispuser.jsp?name=<%=response.encodeURL(forumMSG.getUserName())%>"><%=response.encodeURL(forumMSG.getUserName())%></a></font><font color=<%=tableContentColor%>>(<%=forumMSG.getChildNum()%>/<%=forumMSG.getHits()%>)</font></tr><%
	}
	%></TBODY></TABLE>';
	parent.followImg<%=rootID%>.loaded="yes";
</script>
</body>
</html>