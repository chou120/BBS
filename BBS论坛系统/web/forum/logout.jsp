<%@include file="INC/const.jsp"%>

<%
	try{
		SkinUtil.userLogout(response,request);
		response.sendRedirect("index.jsp");
	}
	catch(Exception e){
		e.printStackTrace();
		response.sendRedirect("index.jsp");
	}
	
%>