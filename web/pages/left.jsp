<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%
  String path = request.getContextPath();
  String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>系统菜单</title>

<script src="<%=basePath%>/static/js/jquery.min.js"></script>
<script language="JavaScript" src="<%=basePath%>/static/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="<%=basePath%>/static/css/bootstrap.css"/>
<script type="text/javascript">
$(function(){
	
	$('.title').click(function(){
		var $ul = $(this).next('ul');
		$('dd').find('.menuson').slideUp();
		if($ul.is(':visible')){
			$(this).next('.menuson').slideUp();
            $(this).find("span").removeClass("glyphicon glyphicon-menu-down").addClass("glyphicon glyphicon-menu-right");
		}else{
			$(this).next('.menuson').slideDown();
          $(this).find("span").addClass("glyphicon glyphicon-menu-down");
          $(this).parent("dd").siblings().find(".title").find("span").removeClass("glyphicon glyphicon-menu-down").addClass("glyphicon glyphicon-menu-right")
		}
    
	});

 
  $("li").click(function(){
      $(this).addClass("active");
      $(this).siblings("li").removeClass("active")
      $(this).parents("dd").siblings().find("li").removeClass("active")
  })
    
})	
</script>

<style>
    *{
        margin: 0px;
        padding: 0px;
    }

    .lefttop{
        width: 100%;
        background-color: burlywood;
        height: 50px;
       
    }
    .lefttop span{
        line-height: 50px;
        font-size: 18px;
    }
    .lefttop span:first-child{
      margin-left: 15px;
    }

    .title{
        background-color:lightsalmon;
        height: 40px;
        border-bottom: 1px solid black;
        padding-left: 15px;
        line-height: 40px;
        font-weight: bolder;
        cursor:pointer;
    }

    ul{
        margin-bottom: 0px;
        display: none;
    }
    ul li{
        height: 30px;
        line-height: 30px;
        padding-left: 15px;
        list-style: none;
    }
    ul li a{
        text-decoration: none;
        display: block;
        color: black;
    }
    ul li a:hover{
        text-decoration: none;    
        color: chocolate;
    }
    .active{
        background-color: burlywood;
    }
    

</style>
</head>

<body style="background-color:#fff3e1">
<div class="lefttop"><span class="glyphicon glyphicon-menu-down"></span><span style="margin-left: 15px">功能菜单</span></div>
<dl class="leftmenu">
  <dd>
    <div class="title"><span style="margin-right: 5px" class="glyphicon glyphicon-menu-right"></span>图书借阅管理</div>
    <ul class="menuson">
      <li>
        <div class="header"><a href="<%=basePath%>/pages/borrow/manageBorrow.jsp" target="rightFrame"><span class="glyphicon glyphicon-menu-right"></span> 办理借阅</a> <i></i> </div>
      </li>
      <li>
        <div class="header"><a href="<%=basePath%>/pages/borrow/borrowRecord.jsp" target="rightFrame"><span class="glyphicon glyphicon-menu-right"></span> 借阅记录</a> <i></i> </div>
      </li>
      <li>
        <div class="header"><a href="<%=basePath%>/pages/borrow/overdue.jsp" target="rightFrame"><span class="glyphicon glyphicon-menu-right"></span> 借阅逾期</a> <i></i> </div>
      </li>
      <li>
        <div class="header"><a href="<%=basePath%>/pages/borrow/returnBook.jsp" target="rightFrame"><span class="glyphicon glyphicon-menu-right"></span> 归还图书</a> <i></i> </div>
      </li>
    </ul>
  </dd>
  <dd>
    <div class="title"><span style="margin-right: 5px" class="glyphicon glyphicon-menu-right"></span>学生信息管理</div>
    <ul class="menuson">
      <li><div class="header"><a href="<%=basePath%>/pages/student/listStudent.jsp" target="rightFrame"><span class="glyphicon glyphicon-menu-right"></span> 学生列表</a><i></i></div></li>
      <li><div class="header"><a href="<%=basePath%>/pages/student/addStudent.jsp" target="rightFrame"><span class="glyphicon glyphicon-menu-right"></span> 添加学生信息</a><i></i></div></li>
    </ul>
  </dd>

  <dd>
    <div class="title"><span style="margin-right: 5px" class="glyphicon glyphicon-menu-right"></span>图书信息管理</div>
    <ul class="menuson">
        <li><div class="header"><a href="<%=basePath%>/pages/book/listBookInfo.jsp" target="rightFrame"><span class="glyphicon glyphicon-menu-right"></span> 图书列表</a><i></i></div></li>
        <li><div class="header"><a href="<%=basePath%>/pages/book/addBook.jsp" target="rightFrame"><span class="glyphicon glyphicon-menu-right"></span> 新增图书</a><i></i></div></li>
    </ul>
  </dd>

  <dd>
    <div class="title"><span style="margin-right: 5px" class="glyphicon glyphicon-menu-right"></span>管理员管理</div>
    <ul class="menuson">
        <li><div class="header"><a href="<%=basePath%>/pages/admin/adminList.jsp" target="rightFrame"><span class="glyphicon glyphicon-menu-right"></span> 管理员列表</a><i></i></div></li>
      <shiro:hasRole name="admin">
        <li><div class="header"><a href="<%=basePath%>/pages/admin/addAdmin.jsp" target="rightFrame"><span class="glyphicon glyphicon-menu-right"></span> 添加管理员</a><i></i></div></li>
      </shiro:hasRole>
    </ul>
  </dd>
</dl>
</body>
</html>