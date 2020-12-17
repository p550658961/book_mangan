<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="<%=basePath%>/static/css/bootstrap.min.css">
    <script src="<%=basePath%>/static/js/jquery.js"></script>
    <style>
        h3{
            margin-left: 4%;
            margin-top: 30px;
        }

    </style>


</head>
<body>

<h3>添加图书信息</h3>
<div style="margin-left: 20%">
    <form class="form-horizontal" id="myform" action="<%=basePath%>/book/addBookInfo" method="post">
        <div class="form-group">
            <label  class="col-sm-6 control-label">书名</label>
            <div id="nameerror" class="col-sm-6">
                <input name="bookName" type="text" class="form-control" id="bookName" placeholder="请输入图书名">
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">作者</label>
            <div class="col-sm-6">
                <input name="author" id="author" type="text" class="form-control"  placeholder="请输入图书的作者">
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">类别</label>
            <div class="col-sm-6" class="vocation">
                <select id="type" class="select1 form-control" name="typeId">
                </select>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">数量</label>
            <div  class="col-sm-6">
                <input id="count" name="count" type="text" class="form-control"  placeholder="请输入图书的数量">
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-2 control-label">出版社</label>
            <div  class="col-sm-6">
                <input name="publishing" type="text" class="form-control"  placeholder="请输入图书的出版社">
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
        $("#type").mouseenter(function () {
            if ($("#type")[0].options.length ==0){
                $.ajax({
                    url:"<%=basePath%>/book/findBookType",
                    type:"post",
                    dataType:"json",
                    success:function (result) {
                        var str = "<option style='display:none'></option>";
                        $.each(result, function (index, item) {
                            //访问每一个的属性，根据属性拿到值
                            str+="<option value="+item.typeId+">"+item.type+"</option>"
                        });
                        $("#type").html(str)
                    }
                })
            }
        })
    })
</script>
