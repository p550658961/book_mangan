<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    <link rel="stylesheet" href="<%=basePath%>/static/css/bootstrap.css">
    <script src="<%=basePath%>/static/js/jquery.min.js"></script>
    <script src="<%=basePath%>/static/js/bootstrap.min.js"></script>
    <script>
        //获取系统时间
        function current(){ 
            var d= new Date(),str=''; 
            str +=d.getFullYear()+'年'; //获取当前年份 
            str +=d.getMonth()+1+'月'; //获取当前月份（0——11） 
            str +=d.getDate()+'日'; 
            str +=d.getHours()+'时'; 
            str +=d.getMinutes()+'分'; 
            str +=d.getSeconds()+'秒'; 
            return str;
        } 
        setInterval(function(){
            $("#systime").html(current)
        },100);	
    </script>
        

    <style>
       .topRight ul li {
            float:right;
            list-style: none;
            margin-right: 3%;
       }
       .row{
            background: coral;
            height: 80px;
       }
       .topRight div{
            width: 40%;
            height: 30px;
            clear: both;
            float:right;
            margin-right: 1%;
            margin-top: 2%;
            border: 1px solid white;
            border-radius: 20px;
            line-height: 30px;
            text-align: center;
            color: white;
       }
    </style>
    </head>
    <body>

        <div class="container-fluid" style="min-width: 980px">
            <div class="row">
                <div class="col-sm-4">
                    <h3>欢迎进入世纪星管理系统</h3>
                </div>
                <div class="col-sm-4">
                    <div class="systime" style="text-align:right;line-height: 80px">
                        <span id="systime" style="font-size: 20px"></span>
                    </div>
                </div>
                <div class="col-sm-4">
<%--                    <div class="topLeft">--%>
<%--                        <ul>--%>
<%--                            <li><a class="btn btn-primary" target="mainFrame" data-toggle="modal" data-target="#exampleModal" data-whatever="@getbootstrap">修改密码</a></li>--%>
<%--                        </ul>--%>
<%--                    </div>--%>

                    <div class="topRight">
                        <ul>
                            <li><a href="<%=basePath%>/login/logout" target="_top">退出登录</a></li>
                        </ul>
                    <div class="user"> <span class="glyphicon glyphicon-user"></span>&nbsp;&nbsp;&nbsp;<span>当前管理员, ${sessionScope.admin}</span> </div>
                              
                </div>
            </div>
            </div>
        </div>


        <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="exampleModalLabel">New message</h4>
                    </div>
                    <div class="modal-body">
                        <form>
                            <div class="form-group">
                                <label for="recipient-name" class="control-label">Recipient:</label>
                                <input type="text" class="form-control" id="recipient-name">
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-primary">Send message</button>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>