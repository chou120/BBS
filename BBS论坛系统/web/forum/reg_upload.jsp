<%@ page contentType="text/html;charset=GBK"%>
<%@ include  file="INC/const.jsp"%>
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<STYLE type=text/css></STYLE>
<LINK href="forum.css" rel=stylesheet>
</head>

<body bgcolor=<%=tableBodyColor%>  text="#000000" leftmargin="0" topmargin="0">

<script>
<!--
parent.theForm.Submit.disabled=false;
parent.theForm.Submit2.disabled=false;
-->
</script>
<form name="form" method="post" action="upfile.jsp" enctype="multipart/form-data" >
<input type="hidden" name="filepath" value="uploadFace">
<input type="hidden" name="act" value="upload">
<br>
<input type="file" name="file1">
<input type=submit name=Submit value="Upload" onclick="parent.theForm.Submit.disabled=true,parent.theForm.Submit2.disabled=true">
</form>
</body>
</html>