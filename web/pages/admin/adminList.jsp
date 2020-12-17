<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <title>Title</title>
    <script src="<%=basePath%>/static/js/jquery.min.js"></script>
    <script language="JavaScript" src="<%=basePath%>/static/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="<%=basePath%>/static/css/bootstrap.css"/>
</head>
<body>
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <table id="admin_table" class="table table-hover">
                    <thead>
                        <tr>
                            <th>序号</th>
                            <th>管理员名称</th>
                            <th>添加时日期</th>
                            <th>是否为超级管理员</th>
                            <shiro:hasRole name="admin">
                                <th>操作</th>
                            </shiro:hasRole>
                        </tr>
                    </thead>
                    <tbody>

                    </tbody>
                </table>
            </div>
        </div>
        <%--显示分页信息--%>
        <div class="row">
            <div class="col-md-6" id="page_nav_area">

            </div>
        </div>
    </div>
</body>
</html>

<script>
    $(function () {
        // 去首页
        to_Page(1)
    });

    // 分页
    function to_Page(pn) {
        $.ajax({
            url:"<%=basePath%>/admin/showAdmin",
            data:"pn="+pn,
            type:"GET",
            success:function (result) {
                // 1、解析并显示员工数据
                build_emp_table(result);
                // // 2、解析并显示分页信息
                // build_page_info(result)
                // 3、解析并显示分页条数据
                build_page_nav(result)
            }
        })
    }

    // 解析页面信息
    function build_emp_table(result) {
        // 清空
        $("#admin_table tbody").empty();
        var emps = result.list;
        $.each(emps,function (index,item) {
            var countId = $("<td></td>").append(index+1);
            var username = $("<td></td>").append(item.username);
            var id = $("<input type='hidden' value='"+item.id+"'/>").addClass("hidden_ids");
            var unixTimestamp = new Date(item.createDate) ;
            var commonTime = unixTimestamp.toLocaleString();
            var createDate = $("<td></td>").append(commonTime);
            var gender = item.rid=='1'?"是":"否"
            var ifAdmin = $("<td></td>").append(gender);
            var deleteBtn = $("<td></td>").append($("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash"))
                .append(" 删除"));
            // 为删除按钮添加一个自定义的属性，来表示当前删除的id
            deleteBtn.attr("del-id",item.id);

            $("<tr></tr>").append(countId).append(username).append(id)
                .append(createDate).append(ifAdmin).append(<shiro:hasRole name="admin">deleteBtn</shiro:hasRole>).appendTo("#admin_table tbody");

        })
        console.log(result);
    }

    // 格式化日期
    Date.prototype.toLocaleString = function() {
        return this.getFullYear() + "年"
            + (this.getMonth() >= 10 ? this.getMonth() +1 : "0"+(this.getMonth()+1)) + "月"
            + (this.getDate() >=10?this.getDate():("0"+this.getDate())) + "日 "
            + (this.getHours() >=10?this.getHours():("0"+this.getHours()))+ "点"
            + (this.getMinutes() >=10?this.getMinutes():("0"+this.getMinutes()))+ "分";
    };

    // 根据id删除管理员，只有超级管理员才有此权限
    $(document).on("click",".delete_btn",function () {
        var id = $(this).parent("td").attr("del-id");
        var username = $(this).parents("tr").find("td:eq(1)").text();
        if (confirm("确认删除【"+username+"】吗？")){
            // 确认，发送ajax请求
            $.ajax({
                url:"<%=basePath%>/admin/deleteAdmin?id="+id,
                type:"get",
                success:function (result) {
                    if (result > 0){
                        to_Page(1)
                    }
                }
            })
        }
    })


    // 解析分页条
    function build_page_nav(result) {
        $("#page_nav_area").empty()
        var ul = $("<ul></ul>").addClass("pagination");
        // 首页
        var  firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
        var  prePageLi = $("<li></li>").append($("<a></a>").attr("href","#").append("&laquo;"));

        // 判断是否有上一页，没有则禁用
        if (result.hasPreviousPage == false){
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        } else {
            // 点击首页来到第一页
            firstPageLi.click(function () {
                to_Page(1)
            })
            // 点击来到上一页
            prePageLi.click(function () {
                to_Page(result.pageNum-1)
            })
        }
        var nextPageLi = $("<li></li>").append($("<a></a>").attr("href","#").append("&raquo;"));
        // 末页
        var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
        // 判断是否有下一页，没有则禁用
        if (result.hasNextPage == false){
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        }else {
            // 点击来到下一页
            nextPageLi.click(function () {
                to_Page(result.pageNum+1)
            })
            // 点击来到最后一页
            lastPageLi.click(function () {
                to_Page(result.pages)
            })
        }
        // 添加首页和前一页的提示
        ul.append(firstPageLi).append(prePageLi);
        // 页码号
        $.each(result.navigatepageNums,function (index,item) {
            var numLi =  $("<li></li>").append($("<a></a>").attr("href","#").append(item));
            if (item == result.pageNum){
                numLi.addClass("active");
            }
            numLi.click(function () {
                to_Page(item)
            })
            // 添加页码号
            ul.append(numLi);
        })
        // 添加末页和后一页的提示
        ul.append(nextPageLi).append(lastPageLi);
        var navEle = $("<nav></nav>").append(ul);
        navEle.appendTo("#page_nav_area");
    }
</script>