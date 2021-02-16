<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
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
                    return '/getAllRoomInfo.do?pageNum=' + page;
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
        <li><a href="javaScript:viod(0)">客房管理</a></li>
        <li><a href="javaScript:viod(0)">客房信息查询</a></li>
    </ul>
</div>
<div class="rightinfo">
    <div class="tools">
        <ul class="toolbar">
            <li id="batDel"><span><img src="<%=basePath %>/static/images/t03.png"/></span>删除</li>
        </ul>

        <div class="toolbar1">
            <table>
                <form method="post" name="serch" action="<%=basePath%>/getHouseInfoByCondition.do">
                    <tr>
                        <td class="zi"><span>选择分类：</span></td>
                        <td>
                            <select id="condition" name="type">
                                <option value="0">请选择</option>
                                <option value="1">房间类型</option>
                                <option value="2">房间状态</option>
                            </select>
                        </td>
                        <td class="zi"><span>关键字：</span></td>
                        <td>
                            <select id="kw" name="keyWord">
                                <option value="0">请选择</option>
                            </select>
                        </td>
                        <td><input type="submit" value="查询" class="button"/></td>
                    </tr>
                </form>
            </table>
        </div>

    </div>
    <table class="tablelist">
        <thead>
        <tr>
            <th><input id="selectAll" name="" type="checkbox" value=""/></th>
            <th>编号</th>
            <th>房间号</th>
            <th>房间类型</th>
            <th>房间单价</th>
            <th>房间状态</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${requestScope.pageInfo.list }" var="map" varStatus="num">
            <tr>
                <td><input name="ck" type="checkbox" value="${map.room_num }"/></td>
                <td>${num.count }</td>
                <td>${map.room_num }</td>
                <td>${map.room_type_name }</td>
                <td>${map.room_price }</td>
                <td>
                    <c:if test="${map.room_status=='0' }"><span style="color:blue">空闲</span></c:if>
                    <c:if test="${map.room_status=='1' }"><span style="color:red">已入住</span></c:if>
                    <c:if test="${map.room_status=='2' }"><span style="color:green">打扫</span></c:if>
                </td>
                <td>
<%--                    <a href="out.html" roomNum="${map.room_num }" class="tablelink">修改</a>--%>
                    <a iri="" id="delBtn" roomNum="${map.room_num }" href="javascript:void(0)" class="tablelink">删除</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <!-- bootstrap的分页 -->
    <!-- 把分页搞出来 -->
    <ul id="pagination"></ul>

    <div class="tip">
        <div class="tiptop"><span>提示信息</span><a></a></div>
        <div class="tipinfo"><span><img src="images/ticon.png"/></span>
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

    // 全选复选框
    $("#selectAll").click(function () {
        var flag = $(this).prop("checked");
        if (flag) {
            $("[name=ck]").prop("checked", true);
        } else {
            $("[name=ck]").prop("checked", false);
        }
    });

    $(function () {
        /* 给选择分类添加事件 */
        $("#condition").change(function () {
            var flag = $("#condition>option:selected").val();
            if (flag == 1) {//房间类型
                $("#kw>option").remove();
                //触发ajax事件，动态获取数据
                $.ajax({
                    url: "<%=basePath %>/getRoomType.do",
                    type: "POST",
                    dataType: "json",
                    success: function (result) {
                        var content = "<option value=\"0\">请选择</option>";
                        for (var i in result) {
                            content += "<option value='" + result[i].id + "'>" + result[i].room_type_name + "</option>";
                        }
                        $("#kw").append(content);
                    }
                });
            } else if (flag == 2) {//房间状态
                $("#kw>option").remove();
                $("#kw").append("<option value=\"0\">请选择</option><option value='0'>空闲</option><option value='1'>已入住</option><option value='2'>打扫</option>");
            }
        });
    });

    // 删除房间信息
    $("#delBtn").click(function () {
        let b = window.confirm("您确定要删除这个房间吗？");
        if (b) {
            var num = $(this).attr("roomNum");
            // 将房间号传到后台
            $.ajax({
                url: "<%=basePath %>/delRoomByRoomNum.do",
                type:"POST",
                dataType: "JSON",
                data:{roomNum:num},
                success:function (result){
                    if (result){
                        window.alert("删除成功！");
                        window.location.reload();
                    }else {
                        window.alert("删除失败，请稍后再试！");
                    }
                }
            });
        }
    });



    // 批量删除
    $("#batDel").click(function (){
        var $chChecked = $("input[name=ck]:checked");
        var len = $chChecked.size();
        if(len >= 1){
            var ids = '';
            $chChecked.each(function (index, dom){
                var id = $(dom).val();
                ids += id + ",";
            });
            var flag = window.confirm("确认删除" + ids.substring(0, ids.length - 1) + "房间吗？");
            if(flag){
                // 触发ajax
                $.ajax({
                    url:"<%=basePath %>/batDelRoom.do",
                    type:"POST",
                    dataType:"JSON",
                    data:{numAttr:ids},
                    success:function (result){
                        if(result == 1){
                            window.alert("删除成功！");
                            window.location.reload();
                        }else if(result == 2){
                            window.alert("所选房间中含有已经入住了的房间，请重新选择！");
                            window.location.reload();
                        }else{
                            window.alert("删除失败，请稍后再试！");
                            window.location.reload();
                        }
                    }
                });
            }
        }else {
            alert("请先勾选要删除的房间！");
        }
    });
</script>
</body>
</html>
