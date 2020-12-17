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

<h3>办理借阅</h3>
<div style="margin-left: 20%">
    <form class="form-horizontal" id="myform" onsubmit="return false" action="##" method="post">
        <div class="form-group">
            <label for="username" class="col-sm-6 control-label">学生姓名</label>
            <div id="nameerror" class="col-sm-6">
                <input name="name" type="username" class="form-control" id="username" placeholder="请输入借书的学生姓名">
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">学号</label>
            <div id="numbererror" class="col-sm-6">
                <input name="number" id="number" type="text" class="form-control"  placeholder="请输入借书的学生学号">
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">图书名</label>
            <div  class="col-sm-6">
                <input name="bookName" id="bookName" type="text" class="form-control"  placeholder="请输入学生所借的图书名">
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">作者</label>
            <div  class="col-sm-6">
                <input name="author" id="author" type="text" class="form-control"  placeholder="请输入图书的作者">
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">待归还日期</label>
            <div  class="col-sm-6">
                <input name="dueDate" type="datetime-local" class="form-control"  placeholder="请输入待归还日期">
            </div>
        </div>
        <div style="margin: 0 auto" class="form-group">
            <div class="col-sm-offset-2 col-sm-10">
                <input id="submit" type="submit" value="借 出" class=" btn btn-success"/>
            </div>
        </div>
    </form>
</div>
</body>
</html>

<script>
    $(function () {
        $("#submit").click(function () {
            $.ajax({
                url:"<%=basePath%>/borrow/borrowBook",
                type:"post",
                data:$("#myform").serialize(),
                success:function (result) {
                    if (result.success == "success"){
                        window.location.href="<%=basePath%>/pages/borrow/borrowRecord.jsp";
                    }else{
                        alert(result.error)
                    }
                }
            })
        })
    })
</script>