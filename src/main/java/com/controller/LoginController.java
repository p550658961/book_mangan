package com.controller;

import com.domain.Administrator;
import com.service.LoginService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import java.io.IOException;
import java.util.*;

@Controller
@RequestMapping("/login")
public class LoginController {

    @Autowired
    private LoginService loginService;

    /**
     * 验证码信息
     * @param request
     * @param response
     * @throws IOException
     */
    @RequestMapping("/checkCode")
    public void checkCode(HttpServletRequest request,HttpServletResponse response) throws IOException {
        loginService.checkCode(request,response);
    }

    /**
     * 未登录拦截，跳转到登录页面
     * @return
     */
    @RequestMapping("/international")
    public String international(){
        return "login/login";
    }

    /**
     * 管理员登录校验
     * @param admin 管理员信息
     * @param result jsr303校验
     * @param verifycode 验证码
     * @param locale
     * @param request
     * @return
     */
    @RequestMapping("/loginAdmin")
    @ResponseBody
    public List<Map<Object,Object>> login(@Valid Administrator admin, BindingResult result, String verifycode, Locale locale, HttpServletRequest request){
        // 判断用户名和密码是否为空，如果为空直接返回错误信息
        if (result.hasErrors()) {
            List<Map<Object, Object>> mapList = new ArrayList<Map<Object, Object>>();
            Map<Object, Object> map = new HashMap<Object, Object>();
            // 获取错误信息
            List<FieldError> list = result.getFieldErrors();
            for (FieldError fieldError : list) {
                map.put(fieldError.getField(), fieldError.getDefaultMessage());
            }
            mapList.add(map);
            return mapList;
        }else {
            // 判断登录是否成功
            List<Map<Object, Object>> mapList = loginService.login(admin, verifycode,locale, request);
            for (Map<Object, Object> map : mapList){
                if(map.containsKey("success")){
                    Subject subject = SecurityUtils.getSubject();
                    subject.login(new UsernamePasswordToken(admin.getUsername(),admin.getPassword()));
                }
            }
            return mapList;
        }
    }

    /**
     * 退出登录
     * @return
     */
    @RequestMapping("/logout")
    public String logout(){
        Subject subject = SecurityUtils.getSubject();
        subject.logout();
        return "redirect:/login/international";
    }
}
