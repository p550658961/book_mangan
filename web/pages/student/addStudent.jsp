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

    <h3>添加学生信息</h3>
    <div style="margin-left: 20%">
        <form class="form-horizontal" id="myform" onsubmit="return false" action="##" method="post">
            <div class="form-group">
                <label for="username" class="col-sm-6 control-label">学生姓名</label>
                <div id="nameerror" class="col-sm-6">
                    <input name="name" type="username" class="form-control" id="username" placeholder="请输入学生姓名">
                    <span style="color: red"></span>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">学号</label>
                <div id="numbererror" class="col-sm-6">
                    <input name="number" id="number" type="text" class="form-control"  placeholder="请输入学生学号">
                    <span style="color: red"></span>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">年级</label>
                <div class="col-sm-6" class="vocation">
                    <select  class="select1 form-control" name="grade">
                        <option value="七年级">七年级</option>
                        <option value="八年级">八年级</option>
                        <option value="九年级">九年级</option>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">班级</label>
                <div id="classeserror" class="col-sm-6">
                    <input name="classes" type="text" class="form-control"  placeholder="请输入学生所在班级">
                    <span style="color: red"></span>
                </div>
            </div>
            <div style="margin-left: 20px" class="form-group">
                <label class="col-sm-6 control-label">性别</label>
                <div style="margin-left: 20px" class="col-sm-10">
                    <label class="radio-inline">
                        <input checked  type="radio" name="gender" value="1">  男
                    </label>
                    <label class="radio-inline" style="margin-left: 20px">
                        <input type="radio" name="gender" value="2"> 女
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
        // 检查学号是否存在,并检验学号是否合法
        $("#number").change(function () {
            $.ajax({
                url: "<%=basePath%>/student/studentNumberCheck?number=" + $(this).val(),
                success: function (rs) {
                    $("#numbererror").find("span").text("");
                    if (rs.error == false) {
                        $("#submit").removeAttr("disabled");
                    }else if (rs.error == rs.error){
                        $("#numbererror").find("span").text(rs.error==true?"学号以存在":rs.error);
                        $("#submit").attr("disabled", "true");
                    }
                }
            })
        })

        // 添加学生信息，并且学生信息为空时不能提交
        $("#submit").click(function () {
            $.ajax({
                url:"<%=basePath%>/student/addStudent",
                type:"post",
                dataType: "json",
                data:$('#myform').serialize(),
                success:function (rs) {

                    studentInfoCheck($("#nameerror"),rs.name);
                    studentInfoCheck($("#numbererror"),rs.number);
                    studentInfoCheck($("#classeserror"),rs.classes);
                    if (rs.insert>=1){
                        window.location.href="<%=basePath%>/pages/student/listStudent.jsp";
                    }
                }
            })
        })
        function studentInfoCheck(ele,rs) {
            $(ele).find("span").text("");
            if (rs == rs){
                $(ele).find("span").text(rs);
            }
        }
    })
</script>