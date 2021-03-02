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
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>无标题文档</title>
    <base href="<%=basePath%>">
    <link href="<%=basePath%>/static/css/style.css" rel="stylesheet"
          type="text/css"/>
    <link href="<%=basePath%>/static/css/select.css" rel="stylesheet"
          type="text/css"/>
    <script type="text/javascript" src="<%=basePath%>/static/js/jquery.js"></script>
    <script type="text/javascript"
            src="<%=basePath%>/static/js/jquery.idTabs.min.js"></script>
    <script type="text/javascript"
            src="<%=basePath%>/static/js/select-ui.min.js"></script>
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

        });

        function checkVipName() {
            var vipName = $("#vipName").val();
            var notice1 = $("#notice1");
            var regid = /^.{2,20}$/;
            if (regid.test(vipName) === false) {
                $(notice1).html("姓名输入不合法");
                return false;
            } else {
                $(notice1).html("");
                return true;
            }
        }

        function checkidentity() {
            var id = $("#identity").val();
            var notice2 = $("#notice2");
            var regid = /^\d{17}[\d|x]|\d{15}$/;
            if (regid.test(id) === false) {
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
            var regid = /^1[35789]\d{9}$/;
            if (regid.test(id) === false) {
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
        <li><a href="javaScript:viod(0)">修改会员信息</a></li>
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

            <div class="formtext">
                Hi，${sessionScope.username}，请填写要修改的会员信息
            </div>

            <form id="fm1" action="<%=basePath%>/updateVipInfo.do" method="POST">
                <ul class="forminfo">
                    <li>
                        <c:choose>
                            <%--                                是单个进行修改--%>
                            <c:when test="${sessionScope.isSingleVipInfo == true}">
                                <input style="display:none" name="vipNum" type="text"
                                       value="${sessionScope.singleVipNum}"/> </c:when>
                            <c:otherwise>
                                <input style="display:none" name="vipNum" type="text" value=""/>
                            </c:otherwise>
                        </c:choose>
                    </li>

                    <li>
                        <label>原会员姓名</label>
                        <div class="vocation">
                            <c:choose>
                                <%--                                是单个进行修改--%>
                                <c:when test="${sessionScope.isSingleVipInfo == true}">
                                    <span style="font-size: 18px">${sessionScope.singleVipName}</span>
                                </c:when>
                                <c:otherwise>
                                    <select class="select1" name="oldVipName">
                                        <option value="0">请选择</option>
                                        <c:forEach items="${vipNames}" var="vip">
                                            <option value="${vip.vip_name}"
                                                    <c:if test="${oldVipName == vip.vip_name}">
                                                        selected="selected"
                                                    </c:if>
                                            >${vip.vip_name}</option>
                                        </c:forEach>
                                    </select>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </li>

                    <li>
                        <label>会员姓名<b>*</b></label>

                        <input id="vipName" required="required" pattern=".{2,20}" placeholder="长度为2-20位的字符"
                               name="vipName" onblur="checkVipName()"
                               type="text"
                               <c:choose>
                                   <c:when test="${sessionScope.isSingleVipInfo == true}">
                                       value="${sessionScope.errorMap.vipName==null?sessionScope.singleVipInfo.vip_name:''}"
                                   </c:when>
                                   <c:otherwise>
                                       value="${sessionScope.errorMap.vipName==null?sessionScope.vipInfo.vipName:''}"
                                   </c:otherwise>
                               </c:choose>
                               class="dfinput"/>
                        <div id="notice1"
                             style="font-size: 14px; color: red; position: absolute; z-index: 1000; margin-top: -30px; margin-left: 450px">
                            <span style="color: red;font-size: 12px">
                                ${sessionScope.errorMap.vipName==null?'':sessionScope.errorMap.vipName}
                            </span>
                        </div>
                    </li>

                    <li><label>性别<b>*</b></label>
                        <div style="padding-top: 7px">

                            <input type="radio" id="man" name="gender" value="1"
                                   <c:choose>
                                       <c:when test="${sessionScope.isSingleVipInfo == true}">
                                           <c:if test="${sessionScope.singleVipInfo.gender == '1'}">
                                               checked="checked"
                                           </c:if>
                                       </c:when>
                                       <c:otherwise>
                                           <c:if test="${sessionScope.vipInfo.gender == '1'}">
                                               checked="checked"
                                           </c:if>
                                       </c:otherwise>
                                   </c:choose>
                            />男
                            <input type="radio" id="woman" name="gender" value="0"
                                   <c:choose>
                                       <c:when test="${sessionScope.isSingleVipInfo == true}">
                                           <c:if test="${sessionScope.singleVipInfo.gender == '0'}">
                                               checked="checked"
                                           </c:if>
                                       </c:when>
                                       <c:otherwise>
                                           <c:if test="${sessionScope.vipInfo.gender == '0'}">
                                               checked="checked"
                                           </c:if>
                                       </c:otherwise>
                                   </c:choose>
                            />女
                        </div>
                    </li>

                    <!-- 折扣率 -->
                    <li>
                        <label>打折<b>*</b></label>
                        <div class="vocation">
                            <select class="select1" name="vipRate">
                                <c:forEach items="${rateList }" var="rate">
                                    <option id="${rate.rate }" value="${rate.rate }"
                                    <c:if test="${rate.rate == 9}">
                                        selected="selected"
                                    </c:if>
                                    > ${rate.rate }</option>
                                </c:forEach>
                            </select>
                        </div>
                        <span style="color: #5bc0de" font-size: 14px>请务必重新选择此项</span>
                    </li>
                    <li>
                        <div style="position: relative">
                            <label>身份证号码<b>*</b></label>
                            <input required="required" pattern="\d{17}[0-9X]"
                                   <c:choose>
                                       <c:when test="${sessionScope.isSingleVipInfo == true}">
                                           value="${sessionScope.errorMap.idcard==null?sessionScope.singleVipInfo.idcard:''}"
                                       </c:when>
                                       <c:otherwise>
                                           value="${sessionScope.errorMap.idcard==null?sessionScope.vipInfo.idcard:''}"
                                       </c:otherwise>
                                   </c:choose>
                                   placeholder="请输入正确的身份证号" name="idcard" type="text"
                                   class="dfinput" onblur="checkidentity()" id="identity"/>
                        </div>
                        <div id="notice2"
                             style="font-size: 14px; color: red; position: absolute; z-index: 1000; margin-top: -30px; margin-left: 450px">
                            <span style="color: red;font-size: 12px">${sessionScope.errorMap.idcard==null?'':sessionScope.errorMap.idcard}</span>
                        </div>
                    </li>
                    <li>
                        <div>
                            <label>手机号码<b>*</b></label>
                            <input required="required" pattern="1[35789]\d{9}"
                                   <c:choose>
                                       <c:when test="${sessionScope.isSingleInRoomInfo == true}">
                                           value="${sessionScope.errorMap.phone==null?sessionScope.singleVipInfo.phone:''}"
                                       </c:when>
                                       <c:otherwise>
                                           value="${sessionScope.errorMap.phone==null?sessionScope.vipInfo.phone:''}"
                                       </c:otherwise>
                                   </c:choose>
                                   placeholder="请输入正确的手机格式" name="phone" type="text"
                                   class="dfinput" id="phone" onblur="checkphone()"/>
                        </div>
                        <div id="notice3"
                             style="font-size: 14px; color: red; position: absolute; z-index: 1000; margin-top: -30px; margin-left: 450px">
                            <span style="color: red;font-size: 12px">${sessionScope.errorMap.phone==null?'':sessionScope.errorMap.phone}</span>
                        </div>

                    </li>
                    <li><label>备注消息</label>
                        <textarea id="content7" name="content"
                                  style="width:700px;height:250px;visibility:hidden;"></textarea>
                    </li>
                    <li><label>&nbsp;</label><input type="submit"
                                                    class="btn" value="确认"/></li>
                </ul>
            </form>

        </div>
        <script type="text/javascript">
            $(function () {
                $("input[type=text]").focus(function () {
                    $(".errorMsg").html("");
                });

                /* 防止表单重复提交 */
                $("#fm1").submit(function () {
                    $("input[type=submit]").attr("disabled", "disabled");
                    $("input[type=submit]").css({
                        background: '#ccc'
                    });
                });
            });

            // 根据选择的姓名填充其他信息
            $("[name='oldVipName']").change(function () {
                // 选择的会员名字
                var name = $(this).val();
                // 没有选择名字
                if (name === '0') {
                    $("input[name='vipName']").val('');
                    $("input[name='idcard']").val('');
                    $("input[name='phone']").val('');
                } else {
                    $.ajax({
                        url: "<%=basePath%>/getVipInfoByName.do",
                        type: "POST",
                        dataType: "JSON",
                        data: {vipName: name},
                        success: function (result) {
                            var rs = JSON.parse(result);
                            $("input[name='vipNum']").val(rs.vip_num);
                            $("input[name='vipName']").val(rs.vip_name);
                            if (rs.gender == '1') {
                                $("#man").attr("checked", "checked");
                            } else {
                                $("#woman").attr("checked", "checked");
                            }
                            $("input[name='idcard']").val(rs.idcard);
                            $("input[name='phone']").val(rs.phone);
                        }
                    });
                }
            });

        </script>
    </div>
</div>
</body>

</html>
