<%
	session.removeAttribute("adminFlag");
	session.removeAttribute("adminName");
	response.sendRedirect("index.jsp");
%>
