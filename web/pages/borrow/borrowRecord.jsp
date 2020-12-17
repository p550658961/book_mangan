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

    <style>
        .black_overlay{
            display: none;
            position: absolute;
            top: 0%;
            left: 0%;
            width: 100%;
            height: 100%;
            background-color: black;
            z-index:1001;
            -moz-opacity: 0.8;
            opacity:.80;
            filter: alpha(opacity=88);
        }
        .white_content {
            display: none;
            position: absolute;
            top: 15%;
            left: 25%;
            width: 55%;
            height: 40%;
            padding: 20px;
            border: 10px solid orange;
            background-color: white;
            z-index:1002;
            overflow: auto;
        }
    </style>
</head>
<body>
<div class="container">
    <div style="margin-top: 10px">
        <form class="form-inline" id="myform" action="##" onsubmit="return false">
            <div class="form-group">
                <label>学生姓名</label>
                <input id="name" name="bookName" type="text" class="form-control" placeholder="请输入你要查找的图书名">
            </div>
            <div style="margin-left: 20px" class="form-group">
                <label>图书名</label>
                <input id="bookName" name="type" type="text" class="form-control"  placeholder="请输入你要查找的图书类别">
            </div>
            <div style="margin-left: 20px" class="form-group">
                <label>借书状态</label>
                <input id="status" name="type" type="text" class="form-control"  placeholder="请输入你要查找的图书类别">
            </div>
            <input id="dimselect" type="submit" class="btn btn-default" value="查 询" >
        </form>
    </div>
    <div class="row">
        <div class="col-md-12">
            <table id="borrow_table" class="table table-hover">
                <thead>
                <tr>
                    <th>学生姓名</th>
                    <th>班级</th>
                    <th>学号</th>
                    <th>图书名</th>
                    <th>作者</th>
                    <th>借书日期</th>
                    <th>还书日期</th>
                    <th>待归还日期</th>
                    <th>借书状态</th>
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
            url:"<%=basePath%>/borrow/showAllInfo",
            type:"get",
            data:{"pn":pn,"name":$("#name").val(),"bookName":$("#bookName").val(),"status":$("#status").val()},
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
        $("#borrow_table tbody").empty();
        var emps = result.list;

        $.each(emps,function (index,item) {
            var name = $("<td></td>").append(item.student.name);
            var classes = $("<td></td>").append(item.student.classes);
            var number = $("<td></td>").append(item.student.number);
            var bookName = $("<td></td>").append(item.bookInfo.bookName);
            var author = $("<td></td>").append(item.bookInfo.author);
            var date1 = new Date(item.borrowBookDate);
            var borrowBookDate = $("<td></td>").append(date1.toLocaleString());
            var date2 = item.returnBookDate == null ? item.returnBookDate:new Date(item.returnBookDate)
            var returnBookDate = $("<td></td>").append(date2 == null ? date2 : date2.toLocaleString());
            var date3 = new Date(item.dueDate);
            var dueDate = $("<td></td>").append(date3.toLocaleString());
            var status = $("<td></td>").append(item.status);

            $("<tr></tr>").append(name).append(classes).append(number)
                .append(bookName).append(author).append(borrowBookDate).append(returnBookDate)
                .append(dueDate).append(status).appendTo("#borrow_table tbody");
        })
    }

    // 格式化日期
    Date.prototype.toLocaleString = function() {
        return this.getFullYear() + "年"
            + (this.getMonth() >= 10 ? this.getMonth() +1 : "0"+(this.getMonth()+1)) + "月"
            + (this.getDate() >=10?this.getDate():("0"+this.getDate())) + "日 "
            + (this.getHours() >=10?this.getHours():("0"+this.getHours()))+ "点"
            + (this.getMinutes() >=10?this.getMinutes():("0"+this.getMinutes()))+ "分";
    };

    // 解析显示分页信息
    function build_page_info(result) {
        $("#page_info_area").empty()
        $("#page_info_area").append("当前 "+result.pageNum+" 页，总 "+ result.pages+" 页，总 "+result.total+" 条记录");
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
</script>