<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <base href="<%=basePath %>">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>酒店管理系统底部</title>
<link href="<%=basePath%>/static/css/style.css" rel="stylesheet" type="text/css" />

</head>

<body>
	<div class="footer">
    <span>天下酒店客房管理系统</span>
    <i>版权所有天下集团</i>    
    </div>    
</body>
</html>
