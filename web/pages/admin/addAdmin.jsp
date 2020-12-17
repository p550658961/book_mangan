<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="<%=basePath%>/static/css/bootstrap.min.css">
    <script src="<%=basePath%>/static/js/jquery.min.js"></script>
    <style>
        h3{
            margin-left: 4%;
            margin-top: 30px;
        }

    </style>
</head>
<body>

<h3>添加管理员信息</h3>
    <div style="margin-left: 20%">
        <form class="form-horizontal" id="myform" onsubmit="return false" action="##" method="post">
            <div class="form-group">
                <label for="username" class="col-sm-6 control-label">管理员名称</label>
                <div id="usernameerror" class="col-sm-6">
                    <input name="username" type="username" class="form-control" id="username" placeholder="管理员名称">
                </div>
            </div>
            <div class="form-group">
                <label   class="col-sm-2 control-label">密码</label>
                <div id="passworderror" class="col-sm-6">
                    <input name="password" type="password" class="form-control"  placeholder="密码">
                </div>
            </div>
            <div style="margin-left: 20px" class="form-group">
                <label class="col-sm-6 control-label">是否为超级管理员</label>
                <div style="margin-left: 20px" class="col-sm-10">
                    <label class="radio-inline">
                        <input  type="radio" name="rid" value="1">  是
                    </label>
                    <label class="radio-inline" style="margin-left: 20px">
                        <input checked  type="radio" name="rid" value="2"> 否
                    </label>
                </div>
            </div>
            <div style="margin: 0 auto" class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                    <input id="submit" type="submit" value="添 加" class=" btn btn-success"/>
                </div>
            </div>
        </form>
    </div>
</body>
</html>

<script>
    $(function () {
        // 检查管理员是否存在
        $("#username").change(function () {
            $.ajax({
                url:"<%=basePath%>/admin/usernameCheck?username="+$(this).val(),
                success:function (rs) {
                    if (rs == true){
                        $("#usernameerror").find("p").remove()
                        $("#usernameerror").append("<p style='color: red;margin-top: 5px'>管理员已存在</p>")
                        // 当管理员名称已存在时，禁用提交按钮
                        $("#submit").attr("disabled", "true")
                    }else {
                        $("#usernameerror").find("p").remove()
                        $("#submit").removeAttr("disabled");
                    }
                }
            })
        })

        // 添加管理员，只有超级管理员才有这个权限
        $("#submit").click(function () {
            $.ajax({
                url:"<%=basePath%>/admin/addAdmin",
                type:"post",
                dataType: "json",
                data:$('#myform').serialize(),
                success(rs){
                    if (rs == -1){
                        $("#usernameerror").find("p").remove()
                        $("#usernameerror").append("<p style='color: red;margin-top: 5px'>管理员名称不能为空</p>")
                    }else if (rs == -2){
                        $("#passworderror").find("p").remove()
                        $("#passworderror").append("<p style='color: red;margin-top: 5px'>密码不能为空</p>")
                    }
                    else {
                        window.location.href="<%=basePath%>/pages/admin/adminList.jsp";
                    }
                }
            })
        })
    })
</script>
