<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
            + request.getContextPath() + "/";
%>
<!DOCTYPE html>
<html>
<head>
    <base href="<%=basePath%>">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>无标题文档</title>
    <link href="<%=basePath %>/static/css/style.css" rel="stylesheet" type="text/css"/>
    <!-- 引入bootstrap分页 -->
    <link rel="stylesheet" href="<%=basePath%>/static/js/bootstrap/bootstrap.css"/>
    <script src="<%=basePath%>/static/js/bootstrap/jquery.min.js"></script>
    <script src="<%=basePath%>/static/js/bootstrap/bootstrap.min.js"></script>
    <script src="<%=basePath%>/static/js/bootstrap/bootstrap-paginator.js"></script>
    <script>
        $(function () {
            $('#pagination').bootstrapPaginator({
                bootstrapMajorVersion: 3,
                currentPage: ${requestScope.pageInfo.pageNum },
                totalPages: ${requestScope.pageInfo.pages },
                pageUrl: function (type, page, current) {
                    return '/getOrderInfo.do?pageNum=' + page;
                },
                itemTexts: function (type, page, current) {
                    switch (type) {
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
    <script type="text/javascript">
        $(document).ready(function () {
            $(".click").click(function () {
                $(".tip").fadeIn(200);
            });

            $(".tiptop a").click(function () {
                $(".tip").fadeOut(200);
            });

            $(".sure").click(function () {
                $(".tip").fadeOut(100);
            });

            $(".cancel").click(function () {
                $(".tip").fadeOut(100);
            });

        });
    </script>
</head>

<body>
<div class="place">
    <span>位置：</span>
    <ul class="placeul">
        <li><a href="javaScript:viod(0)">订单管理</a></li>
        <li><a href="javaScript:viod(0)">订单信息查询</a></li>
    </ul>
</div>
<div class="rightinfo">
    <div class="tools">
        <ul class="toolbar">
            <li id="batdel"><span><img src="<%=basePath %>/static/images/t03.png"/></span>删除</li>
        </ul>
        <div class="toolbar1">
            <table>
                <form method="get" name="serch" action="/getOrderInfoByCondition.do">
                    <tr>
                        <td class="zi"><span>选择分类：</span></td>
                        <td><select name="type">
                            <option value="0">请选择</option>
                            <option value="3">房间号</option>
                            <option value="4">已结算</option>
                            <option value="5">未结算</option>
                            <option value="1">订单编号</option>
                            <option value="2">客人姓名</option>
                        </select></td>
                        <td class="zi"><span>关键字：</span></td>
                        <td><input type="text" name="keyWord" placeholder="与分类关联"/></td>
                        <td><input type="submit" value="查询" class="button"/></td>
                    </tr>
                </form>
            </table>
        </div>

    </div>
    <table class="tablelist">
        <thead>
        <tr>
            <th><input id="selectAll" type="checkbox" value=""/></th>
            <th>序号</th>
            <th>订单编号</th>
            <th>房间号</th>
            <th>客人姓名</th>
            <th>物品名称</th>
            <th>物品数量</th>
            <th>金额</th>
            <th>结算状态</th>
            <th>下单时间</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${pageInfo.list }" var="order" varStatus="num">
            <tr>
                <td><input name="ck" type="checkbox" value="${order.order_num}"/></td>
                <td>${num.count }</td>
                <td>${order.order_num }</td>
                <td>${order.room_num }</td>
                <td>${order.customer_name }</td>
                <td>${order.consume_name}</td>
                <td>${order.consume_count}</td>
                <td>${order.order_money }</td>
                <td>${order.order_status=='1'?'已结算':'未结算' }</td>
                <td>${order.create_date }</td>
                <c:if test="${order.order_status=='1'}">
                <td><a iri="${order.order_num }" name="delBtn" href="javascript:void(0)" class="tablelink"> 删除</a>
                    </c:if>
                    <c:if test="${order.order_status=='0'}">
                <td><a iri="${order.order_num }" name="peyOrderBtn" href="javascript:void(0)" class="tablelink"> 结算</a>
                    </c:if>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <!-- 把分页搞出来 -->
    <ul id="pagination"></ul>

    <div class="tip">
        <div class="tiptop">
            <span>提示信息</span><a></a>
        </div>
        <div class="tipinfo">
            <span><img src="<%=basePath %>/static/images/ticon.png"/></span>
            <div class="tipright">
                <p>是否确认对信息的修改 ？</p>
                <cite>如果是请点击确定按钮 ，否则请点取消。</cite>
            </div>
        </div>
        <div class="tipbtn">
            <input name="" type="button" class="sure" value="确定"/> &nbsp; <input
                name="" type="button" class="cancel" value="取消"/>
        </div>
    </div>
</div>
<script type="text/javascript">
    $('.tablelist tbody tr:odd').addClass('odd');
    // 结算操作
    $("[name='peyOrderBtn']").click(function () {
        var flag = window.confirm("您确认结算该订单吗？");
        if (flag) {
            // 获取订单编号
            var iri = $(this).attr("iri");
            $.ajax({
                url: "<%=basePath %>/peyOrder.do",
                type: "POST",
                data: {orderNum: iri},
                dataType: "JSON",
                success: function (result) {
                    if (result) {//代表删除成功
                        alert("结算成功！")
                        window.location.reload();
                    } else {
                        window.alert("结算失败，请您重新试一次!");
                    }
                }
            });
        }
    });


    // 删除操作
    $("[name='delBtn']").click(function () {
        var flag = window.confirm("您确认删除本条记录吗？");
        if (flag) {
            // 获取订单编号
            var iri = $(this).attr("iri");
            $.ajax({
                url: "<%=basePath %>/delOrderInfo.do",
                type: "POST",
                data: {orderNum: iri},
                dataType: "JSON",
                success: function (result) {
                    if (result) {//代表删除成功
                        alert("删除成功！")
                        window.location.reload();
                    } else {
                        window.alert("删除失败，请您重新试一次!");
                    }
                }
            });
        }
    });


    // 全选的复选框
    $("#selectAll").change(function () {
        var flag = $(this).prop("checked");
        if (flag) {
            $("input[name='ck']").prop("checked", true);
        } else {
            $("input[name='ck']").prop("checked", false);
        }
    });

    // 批量删除
    $("#batdel").click(function () {
        // 变量名前面加$就代表是jquery对象，如果不加则代表是js对象
        var $chChecked = $("input[name=ck]:checked");
        // 判断有没有被勾选
        var len = $chChecked.size();
        if (len >= 1) {
            var nums = "";
            $chChecked.each(function (index, dom) {
                var num = $(dom).val();
                nums += num + ",";
            });
            // 利用ajax将多个id传递给后台
            $.ajax({
                url: "<%=basePath%>/batdel.do",
                type: "POST",
                dataType: "JSON",
                data: {numAttr: nums},
                success: function (result) {
                    if (result) {
                        alert('批量删除成功！');
                        window.location.reload();
                    } else {
                        alert("批量删除失败！")
                    }
                }
            });
        } else {
            alert("请勾选要删除的记录！");
        }
    })
</script>
</body>
</html>
