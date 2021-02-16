<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <base href="<%=basePath %>">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>结账退房</title>
    <link href="<%=basePath %>/static/css/style.css" rel="stylesheet" type="text/css"/>
    <link href="<%=basePath %>/static/css/select.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="<%=basePath %>/static/js/jquery.js"></script>
    <script type="text/javascript" src="<%=basePath %>/static/js/jquery.idTabs.min.js"></script>
    <script type="text/javascript" src="<%=basePath %>/static/js/select-ui.min.js"></script>
    <script type="text/javascript" src="<%=basePath %>/static/editor/kindeditor.js"></script>
    <script type="text/javascript" src="<%=basePath %>/static/js/laydate/laydate.js"></script>
    <script type="text/javascript">
        KE.show({
            id: 'content7',
            cssPath: './index.css'
        });
    </script>
    <script type="text/javascript">
        $(document).ready(function (e) {
            $(".select1").uedSelect({
                width: 345
            });
            $(".select2").uedSelect({
                width: 167
            });
            $(".select3").uedSelect({
                width: 100
            });
        });

    </script>
</head>

<body>
<div class="place"><span>位置：</span>
    <ul class="placeul">
        <li><a href="javaScript:viod(0)">入住管理</a></li>
        <li><a href="javaScript:viod(0)">结账退房</a></li>
    </ul>
</div>
<div class="formbody">
    <div class="formtitle"><span>结账退房</span></div>
    <div id="usual1" class="usual">
        <div id="tab1" class="tabson">
            <form action="/out.do">
                <ul class="forminfo">
                    <li>
                        <label>房间号<b>*</b></label>
                        <div class="vocation">
                            <c:choose>
                                <c:when test="${sessionScope.isSingleInRoomInfo == true}">
                                    <input name="roomId" style="display:none"
                                           value="${sessionScope.singleRoomId}"/>${sessionScope.singleRoomNum}
                                </c:when>
                                <c:otherwise>
                                    <select class="select1" name="roomId">
                                        <option value="0">请选择</option>
                                        <c:forEach items="${roomList}" var="room">
                                            <option value="${room.id}">${room.room_num}</option>
                                        </c:forEach>
                                    </select>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </li>
                    <li style="margin-top:20px;">
                        <label for="name">客人姓名<b>*</b></label>
                        <div class="vocation">
                            <c:choose>
                                <c:when test="${sessionScope.isSingleInRoomInfo == true}">
                                    <input readonly="readonly" name="customerName" type="text" class="dfinput"
                                           value="${sessionScope.singleInRoomInfo.customer_name}" style="width:344px;"/>
                                </c:when>
                                <c:otherwise>
                                    <input name="customerName" type="text" class="dfinput" value="客户姓名"
                                           style="width:344px;"/>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </li>
                    <br/> <br/>
                    <li>
                        <label for="price" style="cursor:pointer">单价<b>*</b></label>
                        <div class="vocation">
                            <c:choose>
                                <c:when test="${sessionScope.isSingleInRoomInfo == true}">
                                    <input readonly="readonly" name="price" id="price" class="dfinput"
                                           value="${sessionScope.singleInRoomInfo.singlePrice}" style="width:344px;"/>
                                </c:when>
                                <c:otherwise>
                                    <input name="price" id="price" class="dfinput" value="" style="width:344px;"/>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </li>
                    <br/>
                    <li>
                        <label for="yajin" style="cursor:pointer">押金<b>*</b></label>
                        <div class="vocation">
                            <c:choose>
                                <c:when test="${sessionScope.isSingleInRoomInfo == true}">
                                    <input readonly="readonly" name="money" id="yajin" type="text" class="dfinput"
                                           value="${sessionScope.singleInRoomInfo.money}" style="width:344px;"/>
                                </c:when>
                                <c:otherwise>
                                    <input name="money" id="yajin" type="text" class="dfinput" value=""
                                           style="width:344px;"/>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </li>
                    <br/>
                    <li>
                        <label for="qita" style="cursor:pointer">其他消费<b>*</b></label>
                        <div class="vocation">
                            <c:choose>
                                <c:when test="${sessionScope.isSingleInRoomInfo == true}">
                                    <input name="qita" id="qita" type="text" class="dfinput" disabled="disabled"
                                           value="${sessionScope.singleInRoomInfo.otherConsume == null ? '0' : sessionScope.singleInRoomInfo.otherConsume}"
                                           style="width:344px;"/>
                                </c:when>
                                <c:otherwise>
                                    <input name="qita" id="qita" type="text" class="dfinput" value=""
                                           style="width:344px;"/>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </li>
                    <br/>
                    <li>
                        <label for="date1" style="cursor:pointer">入住时间<b>*</b></label>
                        <div class="vocation">
                            <c:choose>
                                <c:when test="${sessionScope.isSingleInRoomInfo == true}">
                                    <input readonly="readonly" type="text" name="date1" id="date1" class="dfinput"
                                           value="${sessionScope.singleInRoomInfo.create_date}" style="width:344px;"/>
                                </c:when>
                                <c:otherwise>
                                    <input name="date1" id="date1" class="dfinput" value="" style="width:344px;"/>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </li>
                    <br/>
                    <li>
                        <label for="Calendar" style="cursor:pointer">退房时间<b>*</b></label>
                        <div class="vocation">
                            <input type="text" class="laydate-icon span1-1" id="Calendar"
                                   style="width:324px; height:30px; line-height:28px; text-indent:10px; "/>
                        </div>
                        <br/>
                    </li>
                    <li>
                        <label>&nbsp;</label>
                        <input name="" type="submit" class="btn" value="提交"/>
                    </li>
                </ul>
            </form>
        </div>
    </div>
    <script type="text/javascript">

        $("#usual1 ul").idTabs();
    </script>
    <script type="text/javascript">
        $('.tablelist tbody tr:odd').addClass('odd');

        !function () {
            laydate.skin('qianhuang');
            laydate({elem: '#Calendar'});
            laydate.skin('qianhuang');
            laydate({elem: '#Calendar2'});
        }();
        $(function dd() {
            var d = new Date(), str = "";
            str += (d.getFullYear() + "-");
            str += "0";
            str += (d.getMonth() + 1 + "-");
            str += d.getDate();
            $("#Calendar").attr("value", str);
            $("#Calendar2").attr("value", str);
        });

    </script>
    <script type="text/javascript">
        $(function () {
            // 根据房间号事件触发动作
            $("select[name=roomId]").change(function () {
                var roomId = $("select[name=roomId]>option:selected").val();
                if (roomId == '0') {
                    // 回显信息
                    $("input[name=customerName]").val('');
                    // 将状态设置为不可修改
                    $("input[name=customerName]").attr("disabled", "disabled");
                    $("input[name=price]").val('');
                    $("input[name=price]").attr("disabled", "disabled");
                    $("input[name=money]").val('');
                    $("input[name=money]").attr("disabled", "disabled");
                    $("input[name=date1]").val('');
                    $("input[name=date1]").attr("disabled", "disabled");
                    $("input[name=qita]").val('');
                    $("input[name=qita]").attr("disabled", "disabled");
                } else {
                    $.ajax({
                        url: "<%=basePath %>/getInRoomInfoByRoomId.do",
                        type: "POST",
                        dataType: "JSON",
                        data: {roomId: roomId},
                        success: function (result) {
                            var rs = JSON.parse(result);
                            // 回显信息
                            $("input[name=customerName]").val(rs.customer_name);
                            // 将状态设置为不可修改
                            $("input[name=customerName]").attr("disabled", "disabled");
                            $("input[name=price]").val(rs.price);
                            $("input[name=price]").attr("disabled", "disabled");
                            $("input[name=money]").val(rs.money);
                            $("input[name=money]").attr("disabled", "disabled");
                            // 将后台得到的毫秒数时间转化为日期
                            var time = new Date(rs.create_date);
                            commonTime = time.toLocaleString();
                            $("input[name=date1]").val(commonTime);
                            $("input[name=date1]").attr("disabled", "disabled");
                            if (rs.otherConsume == null || rs.otherConsume === '') {
                                $("input[name=qita]").val('0');
                            } else {
                                $("input[name=qita]").val(rs.otherConsume);
                            }
                            $("input[name=qita]").attr("disabled", "disabled");
                        }
                    });
                }
            });
        });
    </script>

</div>
</body>
</html>
