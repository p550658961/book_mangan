package com.controller;


import com.domain.Administrator;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;


@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private AdminService adminService;


    /**
     * 校验是否有该管理员
     * @param username
     * @return
     */
    @RequestMapping("/usernameCheck")
    @ResponseBody
    public boolean usernameCheck(String username){
        return adminService.findByUsername(username);
    }

    /**
     * 添加管理员
     * @param administrator
     * @return
     */
    @RequestMapping("/addAdmin")
    @ResponseBody
    public int addAdmin(Administrator administrator){
        if (administrator.getUsername().length()<=0){
            return -1;
        }
        if (administrator.getPassword().length()<=0){
            return -2;
        }
        return adminService.insertAdministrator(administrator);
    }

    /**
     * 分页展示所有管理员
     * @param pn
     * @return
     */
    @RequestMapping("/showAdmin")
    @ResponseBody
    public PageInfo showAdd(@RequestParam(value = "pn",defaultValue = "1") Integer pn){
        // 引入PageHelper分页插件
        // 在查询之前需要调用,传入页码，以及每页大小
        PageHelper.startPage(pn,10);
        // startPage后面紧跟的这个查询就是一个分页查询
        List<Administrator> admin =  adminService.findAll();
        // 使用pageInfo包装查询后的结果
        // 封装了详细的分页信息，包括有我们查询出来的数据，传入连续显示的页数
        PageInfo page = new PageInfo(admin,10);
        return page;
    }


    /**
     * 删除管理员
     * @param id
     * @return
     */
    @RequestMapping("/deleteAdmin")
    @ResponseBody
    public int deleteAdmin(Integer id){
        return adminService.deleteAdminById(id);
    }

}
