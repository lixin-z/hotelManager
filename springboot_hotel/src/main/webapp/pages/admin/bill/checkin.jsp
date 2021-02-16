<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
>
<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort();
%>
<!DOCTYPE html>
<head>
    <base href="<%=basePath %>">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>无标题文档</title>
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
    <style type="text/css">
        .errorMes {
            color: red;
            font-size: 12px;
        }
    </style>
</head>

<body>
<div class="place"><span>位置：</span>
    <ul class="placeul">
        <li><a href="javaScript:viod(0)">入住管理</a></li>
        <li><a href="javaScript:viod(0)">添加入住信息</a></li>
    </ul>
</div>
<div class="formbody">
    <div class="formtitle"><span>入住信息</span></div>
    <div id="usual1" class="usual">
        <div id="tab1" class="tabson">
            <form action="/addInRoomInfo.do" method="post">
                <ul class="forminfo">
                    <li>
                        <label>房间号<b>*</b></label>
                        <div class="vocation">
                            <select class="select1" name="roomNum" id="roomIdSelect">
                                <option value="0">请选择</option>
                                <c:forEach items="${allFreeRoom }" var="map">
                                    <option value="${map.room_num }"
                                            <c:if test="${sessionScope.inRoomInfo.roomNum==map.room_num}">
                                                selected="selected"
                                            </c:if>>
                                            ${map.room_num }
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                    </li>
                    <br/>
                    <li style="margin-top:20px;">
                        <%--@declare id="name"--%><label for="name">客人姓名<b>*</b></label>
                        <div class="vocation">
                            <input required="required" name="customerName" pattern=".{2, 20}"
                                   value="${sessionScope.errorMap.customerName==null?sessionScope.inRoomInfo.customerName:''}"
                                   type="text" class="dfinput" placeholder="长度为2-20" style="width:344px;"/>
                            <span class="errorMes">
                                ${sessionScope.errorMap.customerName==null?"":sessionScope.errorMap.customerName}
                            </span>
                        </div>
                    </li>
                    <br/>
                    <li>
                        <%--@declare id="sex"--%><label for="sex">性别<b>*</b></label>
                        <input name="gender" required="required" type="radio" value="1" checked="checked"/>
                        男&nbsp;&nbsp;&nbsp;&nbsp;
                        <input name="gender" required="required" type="radio" value="0"/>
                        女
                    </li>
                    <br/>
                    <li><cite>
                        <label for="sex">会员<b>*</b></label>
                        <input name="isVip" required="required" type="radio" value="1"/>
                        是&nbsp;&nbsp;&nbsp;&nbsp;
                        <input name="isVip" required="required" type="radio" value="0" checked="checked"/>
                        否</cite></li>
                    <br/>
                    <li>
                        <label for="name">身份证号码<b>*</b></label>
                        <div class="vocation">
                            <input name="idcard"
                                   value="${sessionScope.errorMap.idcard==null?sessionScope.inRoomInfo.idcard:''}"
                                   required="required" pattern="\d{17}[0-9X]" type="text" class="dfinput"
                                   placeholder="请填写客户身份证号码" style="width:344px;"/>
                        </div>
                        <span class="errorMes">
                            ${sessionScope.errorMap.idcard==null?"":sessionScope.errorMap.idcard}
                        </span>
                    </li>
                    <br/>
                    <li>
                        <label for="name">手机号码<b>*</b></label>
                        <div class="vocation">
                            <input name="phone" value="${sessionScope.errorMap.phone==null?inRoomInfo.phone:''}"
                                   required="required" pattern="1[35789]\d{9}" type="text" class="dfinput"
                                   placeholder="请填写客户手机号码" style="width:344px;"/>
                        </div>
                        <span class="errorMes">
                            ${sessionScope.errorMap.phone==null?"":sessionScope.errorMap.phone}
                        </span>
                    </li>
                    <br/>
                    <li>
                        <label for="name">押金<b>*</b></label>
                        <div class="vocation">
                            <input name="money" id="autoInputMoney"
                                   value="${sessionScope.errorMap.money==null?sessionScope.inRoomInfo.money:''}"
                                   required="required" pattern="^[+]{0,1}(\d+)$|^[+]{0,1}(\d+\.\d+)$" type="text"
                                   class="dfinput"
                                   placeholder="请输入一个正数" style="width:344px;"/>
                        </div>
                        <span class="errorMes">
                            ${sessionScope.errorMap.money==null?"":sessionScope.errorMap.money}
                        </span>
                    </li>
                    <br/>
                    <li>
                        <%--@declare id="date"--%><label for="date">入住时间<b>*</b></label>
                        <div class="vocation">
                            <input name="createDate"
                                   value="${sessionScope.errorMap.createDate==null?sessionScope.inRoomInfo.createDate:''}"
                                   type="text" required="required" class="laydate-icon span1-1"
                                   id="Calendar"
                                   style="width:324px; height:30px; line-height:28px; text-indent:10px; "/>
                        </div>
                        <span class="errorMes">
                            ${sessionScope.errorMap.createDate==null?"":sessionScope.errorMap.createDate}
                        </span>
                    </li>
                    <br/>
                    <li>
                        <label>&nbsp;</label>
                        <input type="submit" class="btn" value="入住"/>
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
</div>
</body>
</html>
