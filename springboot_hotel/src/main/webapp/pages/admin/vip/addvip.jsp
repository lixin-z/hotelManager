<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
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

            $("#name").focus(function () {
                $(this).css("background-color", "#0FF")
                var text = $(this).val();
                if (text == "请填写姓名") {
                    $(this).val("");
                }
            });

            $("#name").blur(function () {
                $(this).css("background-color", "#FFF")
                var text = $(this).val();
                if (text == "") {
                    $(this).val("请填写姓名");
                }
            });


        });

        function checkidentity() {
            var id = $("#identity").val();
            var notice2 = $("#notice2");
            var regid = /^[1-9]{1}[0-9]{16}([0-9]|[xX])$/;
            if (regid.test(id) == false) {
                $(notice2).html("身份证输入不合法");
                return false;
            } else {
                $(notice2).html("");
                return true;
            }
        }

        function checkphone() {
            var id = $("#phone").val();
            var notice3 = $("#notice3");
            var regid = /^[1-9]{8,11}$/;
            if (regid.test(id) == false) {
                $(notice3).html("电话号码输入不合法");
                return false;
            } else {
                $(notice3).html("");
                return true;
            }
        }
    </script>
</head>

<body>

<div class="place">
    <span>位置：</span>
    <ul class="placeul">
        <li><a href="javaScript:viod(0)">会员管理</a></li>
        <li><a href="javaScript:viod(0)">添加会员</a></li>
    </ul>
</div>

<div class="formbody">


    <div id="usual1" class="usual">

        <div class="itab">
            <ul>
                <li><a href="#tab1" class="selected">添加会员</a></li>

            </ul>
        </div>

        <div id="tab1" class="tabson">

            <div class="formtext">Hi，<b>${sessionScope.username }</b>，请填写要添加的会员信息</div>
            <form action="/addVipInfo.do" method="post">
                <ul class="forminfo">
                    <li><label>会员姓名<b>*</b></label>
                        <input name="vipName" type="text" class="dfinput" placeHolder="请填写姓名"
                               value="${sessionScope.errorMap.vipName==null?sessionScope.vipInfo.vipName:''}"
                               id="name"/>
                        <span style="color: red;font-size: 12px">${sessionScope.errorMap.vipName==null?'':sessionScope.errorMap.vipName}</span>
                    </li>

                    <li><label>性别<b>*</b></label>

                        <div style="padding-top:7px ">
                            <input type="radio" value="1" name="gender" checked="checked"/>男
                            <input type="radio" value="0" name="gender"/>女
                        </div>

                    </li>

                    <li>
                        <div style="position:relative">
                            <label>身份证号码<b>*</b></label>
                            <input name="idcard" type="text"
                                   value="${sessionScope.errorMap.idcard==null?sessionScope.vipInfo.idcard:''}"
                                   class="dfinput" onblur="checkidentity()" id="identity"/>
                            <span style="color: red;font-size: 12px">${sessionScope.errorMap.idcard==null?'':sessionScope.errorMap.idcard}</span>
                        </div>
                        <div id="notice2"
                             style=" font-size:14px; color:red;position:absolute; z-index:1000; margin-top:-30px; margin-left:    450px">
                        </div>
                    </li>


                    <li>
                        <div>
                            <label>手机号码<b>*</b></label>

                            <input name="phone" type="text"
                                   value="${sessionScope.errorMap.phone==null?sessionScope.vipInfo.phone:''}"
                                   class="dfinput" value="" id="phone" onblur="checkphone()"/>
                            <span style="color: red;font-size: 12px">${sessionScope.errorMap.phone==null?'':sessionScope.errorMap.phone}</span>

                        </div>
                        <div id="notice3"
                             style=" font-size:14px; color:red;position:absolute; z-index:1000; margin-top:-30px; margin-left:    450px">
                        </div>

                    </li>


                    <%-- <li><label>备注消息</label>


                         <textarea id="content7" name="content"
                                   style="width:700px;height:250px;visibility:hidden;"></textarea>
                     </li>--%>
                    <li><label>&nbsp;</label><input name="" type="submit" class="btn" value="确认"/></li>
                </ul>
            </form>
        </div>

    </div>
</div>
</body>

</html>
