<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort() +request.getContextPath()+"/";
%>
<!DOCTYPE html>
<html>
<head>
	<base href="<%=basePath %>">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>分页查询</title>
	<!-- 引入bootstrap分页 -->
	<link rel="stylesheet" href="<%=basePath%>/static/js/bootstrap/bootstrap.css" />
	<script src="<%=basePath%>/static/js/bootstrap/jquery.min.js"></script>
	<script src="<%=basePath%>/static/js/bootstrap/bootstrap.min.js"></script>
	<script src="<%=basePath%>/static/js/bootstrap/bootstrap-paginator.js"></script>
	<script>
	$(function() {
		$('#pagination').bootstrapPaginator({
			bootstrapMajorVersion: 3,
			currentPage: ${requestScope.pageInfo.pageNum },
			totalPages: ${requestScope.pageInfo.pages },
			pageUrl: function(type, page, current) {
				return 'selectSalesByFenYe.do?pageNum=' + page;
			},
			itemTexts: function(type, page, current) {
				switch(type) {
					case "first":
						return "首页";
					case "prev":
						return "上一页";
					case "next":
						return "下一页";
					case "last":
						return "末页";
					case "page":
						return page;
				}
			}
		});
	});
	</script>
</head>
<body>

	<table border="1px" width="600px">
		<tr>
			<td>主键</td>
			<td>单价</td>
			<td>销售数量</td>
			<td>总价格</td>
		</tr>
		<c:forEach items="${requestScope.pageInfo.list }" var="map">
			<tr>
				<td>${map.id }</td>
				<td>${map.price }</td>
				<td>${map.quantity }</td>
				<td>${map.total_price }</td>
			</tr>
		</c:forEach>
	</table>
	
	<!-- 把分页搞出来 -->
	<ul id="pagination"></ul>

</body>
</html>