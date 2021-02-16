<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort();
%>
<!DOCTYPE html>
<html>
<head>
    <base href="<%=basePath %>">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>无标题文档</title>
    <link href="<%=basePath %>/static/css/style.css" rel="stylesheet" type="text/css"/>
    <!-- 引入bootstrap分页 -->
    <link rel="stylesheet" href="<%=basePath%>/static/js/bootstrap/bootstrap.css"/>
    <script src="<%=basePath%>/static/js/bootstrap/jquery.min.js"></script>
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
<div class="place"><span>位置：</span>
    <ul class="placeul">
        <li><a href="javaScript:viod(0)">入住管理</a></li>
        <li><a href="javaScript:viod(0)">消费记录</a></li>
    </ul>
</div>
<div class="rightinfo">
    <div class="tools">
        <div class="toolbar">
            <label style="color: #5bc0de; font-size: 16px">房间号</label>
            <form action="/getConsumeInfoByRoomId.do" method="post">
                <select class="select1" name="roomId">
                    <option value="0">请选择</option>
                    <c:forEach items="${occupyRooms }" var="map">
                        <option value="${map.id }">
                                ${map.room_num }
                        </option>
                    </c:forEach>
                </select>
                <button><input type="submit" value="搜索"></button>
            </form>
        </div>

    </div>
    <table class="tablelist">
        <thead>
        <tr>
            <th>编号</th>
            <th>订单编号</th>
            <th>房间号</th>
            <th>客人姓名</th>
            <th>手机号码</th>
            <th>消费名称</th>
            <th>数量</th>
            <th>金额</th>
            <th>是否结算</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${sessionScope.consumeInfo }" var="order" varStatus="num">
            <tr>
                <td>${num.count }</td>
                <td>${order.order_num}</td>
                <td>${order.room_num }</td>
                <td>${order.customer_name }</td>
                <td>${order.phone }</td>
                <td>${order.consume_name }</td>
                <td>${order.consume_count }</td>
                <td>${order.order_money }</td>
                <td>
                    <c:if test="${order.order_status == '1'}">
                        是
                    </c:if>
                    <c:if test="${order.order_status == '0'}">
                        否
                    </c:if>
                </td>
                <td>
                    <c:if test="${order.order_status == '1'}">
                        <a iri="${order.order_num }" name="delBtn" href="javascript:void(0)" class="tablelink"> 删除</a>
                    </c:if>
                    <c:if test="${order.order_status == '0'}">
                        <a iri="${order.order_num }" name="setStatus" href="javascript:void(0)" class="tablelink">
                            结算</a>
                    </c:if>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <div class="tip">
        <div class="tiptop"><span>提示信息</span><a></a></div>
        <div class="tipinfo"><span><img src="<%=basePath %>/static/images/ticon.png"/></span>
            <div class="tipright">
                <p>是否确认对信息的修改 ？</p>
                <cite>如果是请点击确定按钮 ，否则请点取消。</cite></div>
        </div>
        <div class="tipbtn">
            <input name="" type="button" class="sure" value="确定"/>
            &nbsp;
            <input name="" type="button" class="cancel" value="取消"/>
        </div>
    </div>
</div>
<script type="text/javascript">
    $('.tablelist tbody tr:odd').addClass('odd');
    // 删除按钮
    $("[name=delBtn]").click(function () {
        var flag = window.confirm("确定删除该订单记录吗？");
        if (flag) {
            // 获取订单编号
            var num = $(this).attr("iri");
            // 将编号传到后台，做删除操作
            $.ajax({
                url: "<%=basePath%>/delOrderInfo.do",
                dataType: "JSON",
                type: "POST",
                data: {orderNum: num},
                success: function (result) {
                    if (result) {
                        // 刷新操作
                        window.location.reload();
                    } else {
                        window.alert("删除操作失败，请稍后再试！");
                    }
                }
            });
        }
    });

    // 结算
    $("[name=setStatus]").click(function () {
        let b = window.confirm("您是否要结算此订单？");
        if (b) {
            // 获取订单编号
            var num = $(this).attr("iri");
            // 将编号传到后台，做结算操作
            $.ajax({
                url: "<%=basePath%>/peyOrder.do",
                dataType: "JSON",
                type: "POST",
                data: {orderNum: num},
                success: function (result) {
                    if (result) {
                        // 刷新操作
                        window.location.reload();
                    } else {
                        window.alert("结算操作失败，请稍后再试！");
                    }
                }
            });
        }
    });
</script>
</body>
</html>
