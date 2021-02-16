<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@  taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
                currentPage: ${sessionScope.pageInfo.pageNum },
                totalPages: ${sessionScope.pageInfo.pages },
                pageUrl: function (type, page, current) {
                    return '/getVipInfo.do?pageNum=' + page;
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
        <li><a href="javaScript:viod(0)">会员管理</a></li>
        <li><a href="javaScript:viod(0)">会员信息查询</a></li>
    </ul>
</div>
<div class="rightinfo">
    <div class="tools">
        <ul class="toolbar">
            <li id="batdel"><span><img src="<%=basePath %>/static/images/t03.png"/></span>删除</li>
        </ul>
        <div class="toolbar1">
            <table>
                <form action="/getVipInfoByCondition.do" method="post" name="serch">
                    <tr>
                        <td class="zi"><span>选择分类：</span></td>
                        <td><select name="type">
                            <option value="0">请选择</option>
                            <option value="1">会员卡号</option>
                            <option value="2">会员姓名</option>
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
            <th>会员卡号</th>
            <th>会员姓名</th>
            <th>性别</th>
            <th>身份证号码</th>
            <th>手机号码</th>
            <th>享受折扣</th>
            <th>创建日期</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${sessionScope.pageInfo.list}" var="vip" varStatus="num">
            <tr>
                <td><input name="ck" type="checkbox" value="${vip.vip_num }"/></td>
                <td>${num.count }</td>
                <td>${vip.vip_num }</td>
                <td>${vip.vip_name }</td>
                <td>
                    <c:if test="${vip.gender=='1'}">
                        男
                    </c:if>
                    <c:if test="${vip.gender=='0'}">
                        女
                    </c:if>
                </td>
                <td>${vip.idcard }</td>
                <td>${vip.phone }</td>
                    <%--                享受的折扣--%>
                <c:if test="${vip.vip_rate == null }">
                    <td>不打折</td>
                </c:if>
                <c:if test="${vip.vip_rate != null }">
                    <td>${vip.vip_rate }折</td>
                </c:if>
                <td>${vip.create_date }</td>
                <td>
                    <a name="changeSimpleVipInfo" vipNum="${vip.vip_num }" vipName="${vip.vip_name}" href="javascript:void(0)" class="tablelink">修改</a>
                    <a num="${vip.vip_num }" name="delBtn" href="javascript:void(0)" class="tablelink"> 删除</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
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
    // 删除会员
    $("[name='delBtn']").click(function () {
        var flag = window.confirm("您确认删除该会员记录吗？");
        if (flag) {
            var vip_num = $(this).attr("num");
            $.ajax({
                url: "/delVip.do",
                type: "POST",
                data: {vipNum: vip_num},
                success: function (result) {
                    if (result) {
                        alert("删除成功！");
                        window.location.reload();
                    } else {
                        alert("删除失败，请重新再试一次！");
                    }
                }
            })
        }
    });

    // 全选复选框
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
        var $chChecked = $("input[name='ck']:checked");
        // 先判断有没有被勾选
        var len = $chChecked.size();
        if (len >= 1) {
            var nums = "";
            $chChecked.each(function (index, dom) {
                var num = $(dom).val();
                nums += num + ",";
            });
            // 将多个num传递到后台
            $.ajax({
                url: "<%=basePath %>/batDelVipInfo.do",
                type: "POST",
                dataType: "JSON",
                data: {numsAttr: nums},
                success: function (result) {
                    if (result) {
                        alert("批量删除成功！");
                        window.location.reload();
                    } else {
                        alert("批量删除失败！");
                    }
                }
            })
        } else {
            alert("请先勾选要删除的会员记录");
        }
    });

    // 修改单个VIP信息
    $("[name='changeSimpleVipInfo']").click(function (){
        var num = $(this).attr("vipNum");
        var name = $(this).attr("vipName");
        $.ajax({
           url:"<%=basePath %>/changeSingleVipInfo.do",
           type:"POST",
           dataType:"JSON",
            data:{vipNum:num, vipName:name},
            success:function (result){
               if(result){
                   <%--alert("${pageContext.request.contextPath}");--%>
                   window.location.href = "<%=basePath %>/pages/admin/vip/updateVipInfo.jsp";
               }else {
                   window.alert("跳转失败，请稍后再试！")
               }
            }
        });
    });
</script>
</body>
</html>
