<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
<head>
    <title>Bootstrap 实例</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="<%=basePath%>/static/css/bootstrap.min.css">
    <script src="<%=basePath%>/static/js/jquery.min.js"></script>
    <script src="<%=basePath%>/static/js/popper.min.js"></script>
    <script src="<%=basePath%>/static/js/bootstrap.min.js"></script>

    <style>
        .carousel-inner img {
            width: 100%;
            height: 100%;
        }
    </style>

    <script type="text/javascript">
        //切换验证码
        function refreshCode(){
            //1.获取验证码图片对象
            var vcode = document.getElementById("vcode");

            //2.设置其src属性，加时间戳
            vcode.src = "<%=basePath%>/login/checkCode?time="+new Date().getTime();
        }
        $('.carousel').carousel({interval: 2000})
    </script>
</head>
<body>

<h1 style="text-align: center;margin-bottom: 2%"><fmt:message key="h1"/> </h1>
<div class="container-fluid">
    <div class="row">
        <div id="demo" class="col-sm-6 carousel slide" data-ride="carousel">
            <!-- 指示符 -->
            <ul class="carousel-indicators">
                <li data-target="#demo" data-slide-to="0" class="active"></li>
                <li data-target="#demo" data-slide-to="1"></li>
                <li data-target="#demo" data-slide-to="2"></li>
            </ul>

            <!-- 轮播图片 -->
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <img src="<%=basePath%>/static/image/Minna no Mori-Gifu Media Cosmos _ WORKS _ HARA DESIGN INSTITUTE.jpg">
                </div>
                <div class="carousel-item">
                    <img src="<%=basePath%>/static/image/u=685826676,733443790&fm=26&gp=0.jpg">
                </div>
                <div class="carousel-item">
                    <img src="<%=basePath%>/static/image/">
                </div>
            </div>

            <!-- 左右切换按钮 -->
            <a class="carousel-control-prev" href="#demo" data-slide="prev">
                <span class="carousel-control-prev-icon"></span>
            </a>
            <a class="carousel-control-next" href="#demo" data-slide="next">
                <span class="carousel-control-next-icon"></span>
            </a>
        </div>
        <div class="col-sm-4" style="margin-left: 10%">
            <h3 style="text-align: center;"><fmt:message key="manage"/> </h3>
            <form id="myform" onsubmit="return false" action="##" method="post">
                <div id="username" class="form-group">
                    <label><fmt:message key="username"/>：</label>
                    <input type="text" name="username" class="form-control"  placeholder="<fmt:message key="inputUsername"/>"/>
                </div>

                <div id="password" class="form-group">
                    <label><fmt:message key="password"/>：</label>
                    <input type="password" name="password" class="form-control" placeholder="<fmt:message key="inputPassword"/>"/>
                </div>

                <div id="yzm" class="form-inline">
                    <label><fmt:message key="code"/>：</label>
                    <input type="text" name="verifycode" class="form-control" id="verifycode" placeholder="<fmt:message key="inputCode"/>" style="width: 120px;"/>
                    <a href="javascript:refreshCode();" style="margin-left: 10px;">
                        <img src="<%=basePath%>/login/checkCode" title="<fmt:message key="title"/>" id="vcode"/>
                    </a>

                </div>
                <hr/>
                <div id="btn" class="form-group" style="text-align: center;">
                    <input id="submit" class="btn btn-primary btn-lg" type="submit" value="<fmt:message key="btn"/>">
                </div>
            </form>
            <div>
                <a id="china" href="<%=basePath%>/login/international?locale=zh_CN">中文</a>
                <a id="english" href="<%=basePath%>/login/international?locale=en_US">English</a>
            </div>

        </div>
    </div>

</div>

</body>
</html>

<script>
    $(function () {
        $("#submit").click(function () {
            $.ajax({
                url:"<%=basePath%>/login/loginAdmin",
                type:"post",
                dataType: "json",
                data:$('#myform').serialize(),
                success:function (rs) {
                    for(var i in rs){
                        $("#yzm").find("p").remove()
                        $("#btn").find("p").remove()
                        $("#username").find("p").remove()
                        $("#password").find("p").remove()
                        $("#username").append("<p style='color: red;margin-top: 5px'><fmt:message key="username"/> "+rs[i].username+"</p>");
                        $("#password").append("<p style='color: red;margin-top: 5px'><fmt:message key="password"/> "+rs[i].password+"</p>");
                        if (rs[i].username == undefined) {
                            $("#username").find("p").remove()
                        }
                        if (rs[i].password == undefined) {
                            $("#password").find("p").remove()
                        }
                        $("#btn").append("<p style='color: #ff0000;margin-top: 5px'>"+rs[i].login_msg+"</p>");
                        if (rs[i].login_msg == undefined){
                            $("#btn").find("p").remove()
                        }
                        $("#yzm").append("<p style='color: red;margin-top: 5px'>"+rs[i].check_msg+"</p>");
                        if (rs[i].check_msg == undefined){
                            $("#yzm").find("p").remove()
                        }
                        if (rs[i].success == '登录成功'){
                            window.location.href="<%=basePath%>/pages/index.jsp";
                        }
                    }
                }
            })
        })
    })
</script>