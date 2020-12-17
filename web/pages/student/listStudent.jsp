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
    <div style="margin-top: 10px">
        <form class="form-inline" id="myform" action="##" onsubmit="return false">
            <div class="form-group">
                <label>学生姓名</label>
                <input id="studentname" name="name" type="text" class="form-control" placeholder="请输入学生姓名">
            </div>
            <div style="margin-left: 20px" class="form-group">
                <label>班级</label>
                <input id="studentclasses" name="classes" type="text" class="form-control"  placeholder="请输入学生所在班级">
            </div>
            <input id="dimselect" type="submit" class="btn btn-default" value="查 询" >
        </form>
        <button class="btn btn-danger" id="student_delete_all_btn">全部删除</button>
    </div>
    <div class="row">
        <div class="col-md-12">
            <table id="student_table" class="table table-hover">
                <thead>
                <tr>
                    <th><input type="checkbox" id="check_all"></th>
                    <th>序号</th>
                    <th>学生姓名</th>
                    <th>学号</th>
                    <th>年级</th>
                    <th>班级</th>
                    <th>性别</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>
    <%--显示分页信息--%>
    <div class="row">


        <%--分页文字信息--%>
        <div class="col-md-6" id="page_info_area">

        </div>
        <%--分页条信息--%>
        <div class="col-md-6" id="page_nav_area">

        </div>
    </div>
</div>
</body>
</html>

<script>

    var totalRecord,currentPage;
    $(function () {
        // 去首页
        to_dimPage(1)
    });

    // 分页查询模糊数据
    $("#dimselect").click(function () {
        to_dimPage(1)
    })

    function to_dimPage(pn){
        $.ajax({
            url:"<%=basePath%>/student/pageShowStudent",
            type:"get",
            data:{"pn":pn,"name":$("#studentname").val(),"classes":$("#studentclasses").val()},
            success:function (result) {
                // 1、解析并显示学生数据
                build_emp_table(result);
                // // 2、解析并显示分页信息
                build_page_info(result);
                // 3、解析并显示分页条数据
                build_dimpage_nav(result);
            }
        })
    }

    // 解析页面信息
    function build_emp_table(result) {
        // 清空
        $("#student_table tbody").empty();
        var emps = result.list;
        $.each(emps,function (index,item) {
            var checkBoxId = $("<td><input type='checkbox' class='check_item'/></td>")
            var countId = $("<td></td>").append(index+1);
            var username = $("<td></td>").append(item.name);
            var id = $("<input type='hidden' value='"+item.id+"'/>").addClass("hidden_ids");
            var number = $("<td></td>").append(item.number);
            var grade = $("<td></td>").append(item.grade);
            var classes = $("<td></td>").append(item.classes);
            var gender = $("<td></td>").append(item.gender=='1'?"男":"女");
            var deleteBtn = $("<td></td>").append($("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash"))
                .append(" 删除"));
            // 为删除按钮添加一个自定义的属性，来表示当前删除的id
            deleteBtn.attr("del-id",item.id);

            $("<tr></tr>").append(checkBoxId).append(countId).append(username).append(id)
                .append(number).append(grade).append(classes).append(gender).append(deleteBtn).appendTo("#student_table tbody");

        })
    }

    // 解析显示分页信息
    function build_page_info(result) {
        $("#page_info_area").empty()
        $("#page_info_area").append("当前页数为第 "+result.pageNum+" 页，总 "+ result.pages+" 页，总 "+result.total+" 条记录")
        totalRecord = result.total;
        currentPage = result.pageNum;
    }

    // 解析分页条
    function build_dimpage_nav(result) {
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
                to_dimPage(1)
            })
            // 点击来到上一页
            prePageLi.click(function () {
                to_dimPage(result.pageNum-1)
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
                to_dimPage(result.pageNum+1)
            })
            // 点击来到最后一页
            lastPageLi.click(function () {
                to_dimPage(result.pages)
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
                to_dimPage(item)
            })
            // 添加页码号
            ul.append(numLi);
        })
        // 添加末页和后一页的提示
        ul.append(nextPageLi).append(lastPageLi);
        var navEle = $("<nav></nav>").append(ul);
        navEle.appendTo("#page_nav_area");
    }

    // 根据id删除学生信息
    $(document).on("click",".delete_btn",function () {
        var id = $(this).parent("td").attr("del-id");
        var name = $(this).parents("tr").find("td:eq(2)").text();
        if (confirm("确认删除【"+name+"】吗？")){
            // 确认，发送ajax请求
            $.ajax({
                url:"<%=basePath%>/student/deleteStudentIds?del_idstr="+id,
                type:"get",
                success:function (result) {
                    if (result > 0){
                        to_dimPage(currentPage)
                    }
                }
            })
        }
    })

    // 完成全选/全不选
    $("#check_all").click(function () {
        $(".check_item").prop("checked",$(this).prop("checked"))
    })
    // 当不在当前页面全选框不被选中
    $(document).on("click",".pagination li a",function () {
        $("#check_all").prop("checked",false)
    })
    // 当复选框都被选中时全选框也被选中
    $(document).on("click",".check_item",function () {
        var flag = ($(".check_item:checked").length == $(".check_item").length)
        $("#check_all").prop("checked",flag)
    })

    // 点击全部删除，就批量删除
    $("#student_delete_all_btn").click(function () {
        var name = "";
        var del_idstr = "";
        $.each($(".check_item:checked"),function () {
            name += $(this).parents("tr").find("td:eq(2)").text()+",";
            // 组装员工id的字符串
            del_idstr += $(this).parents("tr").find(".hidden_ids").val()+"-"
        })
        // 去除名字多余的,
        name = name.substring(0,name.length-1)
        // 去除id多余的-
        del_idstr = del_idstr.substring(0,del_idstr.length-1)
        if (name.length>=1){
            if (confirm("确认删除【"+name+"】吗？")){
                // 发送ajax请求
                $.ajax({
                    url:"<%=basePath%>/student/deleteStudentIds?del_idstr="+del_idstr,
                    type:"get",
                    success:function (result) {
                        if (result > 0){
                            to_dimPage(currentPage)
                        }
                    }
                })
            }
        }else {
            alert("请勾选你要删除的学生");
        }
    })
</script>