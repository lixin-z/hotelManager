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
    <script src="<%=basePath%>/static/js/bootstrap/bootstrap.min.js"></script>
    <script src="<%=basePath%>/static/js/bootstrap/bootstrap-paginator.js"></script>
    <script>
        $(function () {
            $('#pagination').bootstrapPaginator({
                bootstrapMajorVersion: 3,
                currentPage: ${requestScope.pageInfo.pageNum },
                totalPages: ${requestScope.pageInfo.pages },
                pageUrl: function (type, page, current) {
                    return '/getInRoomInfo.do?pageNum=' + page;
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
<div class="place"><span>位置：</span>
    <ul class="placeul">
        <li><a href="javaScript:viod(0)">入住管理</a></li>
        <li><a href="javaScript:viod(0)">入住信息查询</a></li>
    </ul>
</div>
<div class="rightinfo">
    <div class="tools">
        <ul class="toolbar">
            <li id="batdel"><span><img src="<%=basePath %>/static/images/t03.png"/></span>删除</li>
        </ul>

        <div class="toolbar1">
            <table>
                <form method="post" name="serch" action="<%=basePath %>/getInRoomInfoByCondition.do">
                    <tr>
                        <td class="zi"><span>选择分类：</span></td>
                        <td><select name="type">
                            <option value="0">请选择</option>
                            <option value="1">房间号</option>
                            <option value="2">客人姓名</option>
                            <option value="3">手机号码</option>
                            <option value="4">身份证号码</option>
                        </select></td>
                        <td class="zi"><span>关键字：</span></td>
                        <td><input name="keyWord" type="text" placeholder="与分类关联"/></td>
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
            <th>编号</th>
            <th>房间号</th>
            <th>房间类型</th>
            <th>客人姓名</th>
            <th>性别</th>
            <th>身份证号码</th>
            <th>手机号码</th>
            <th>押金</th>
            <th>入住时间</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${requestScope.pageInfo.list }" var="map" varStatus="num">
            <tr>
                <td><input name="ck" type="checkbox" value="${map.id}"/></td>
                <td>${num.count }</td>
                <td>${map.room_num }</td>
                <td>${map.room_type_name }</td>
                <td>${map.customer_name }</td>
                <c:if test="${map.gender=='1'}">
                    <td>男</td>
                </c:if>
                <c:if test="${map.gender=='0'}">
                    <td>女</td>
                </c:if>
                <td>${map.idcard }</td>
                <td>${map.phone }</td>
                <td>${map.money }</td>
                <td>${map.create_date }</td>
                <td>
                    <a name="outBtn" roomId="${map.id}" roomNum="${map.room_num}" href="javascript:void(0)"
                       class="tablelink">退房</a>
                    <a iri="${map.id }" name="delBtn" href="javascript:void(0)" class="tablelink"> 删除</a>
                </td>
            </tr>
        </c:forEach>··
        </tbody>
    </table>
    <%--bootstrup分页--%>
    <!-- 把分页搞出来 -->
    <ul id="pagination"></ul>
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
    $(function () {
        // 删除操作
        $("[name='delBtn']").click(function () {
            // $("#delBtn").click(function(){     只能删除第一个
            var flag = window.confirm("您确认删除本条记录吗？");
            if (flag) {
                var iri = $(this).attr("iri");
                $.ajax({
                    url: "<%=basePath %>/delInRoomInfo.do",
                    type: "POST",
                    data: {id: iri},
                    dataType: "JSON",
                    success: function (result) {
                        if (result) {//代表删除成功
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
            // 全选
            if (flag) {
                $("input[name='ck']").prop("checked", true);
            }
            //全部取消
            else {
                $("input[name='ck']").prop("checked", false);
            }
        });

        // 批量删除
        $("#batdel").click(
            function () {
                var $chChecked = $("input[name=ck]:checked");
                // 先判断有没有被勾选
                var len = $chChecked.size();
                if (len >= 1) {
                    var ids = "";
                    $chChecked.each(function (index, dom) {
                        var id = $(dom).val();
                        ids += id + ",";
                    });
                    // 将多个id传递给后台
                    $.ajax({
                        url: "<%=basePath %>/batDelInRoomInfo.do",
                        type: "POST",
                        dataType: "JSON",
                        data: {idAttr: ids},
                        success: function (result) {
                            if (result) {
                                alert("删除成功！");
                                window.location.reload();
                            } else {
                                alert("批量删除失败");
                            }
                        }
                    })
                } else {
                    alert("请勾选要删除的记录！");
                }
            }
        );
    });

    $("[name='outBtn']").click(function () {
        var id = $(this).attr("roomId");
        var num = $(this).attr("roomNum");
        $.ajax({
            url: "<%=basePath %>/singleOut.do",
            type: "POST",
            dataType: "JSON",
            data: {roomId: id, roomNum: num},
            success: function (result) {
                if (result) {
                    window.location.href = "<%=basePath %>/pages/admin/bill/out.jsp";
                } else {
                    window.alert("页面跳转失败，请稍后再试！");
                }
            }
        });
    });
</script>
</body>
</html>
