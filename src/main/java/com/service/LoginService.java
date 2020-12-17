package com.service;

import com.domain.Administrator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Locale;
import java.util.Map;

public interface LoginService {

    /**
     * 验证码
     * @param httpServletRequest
     * @param response
     * @throws IOException
     */
    void checkCode(HttpServletRequest httpServletRequest, HttpServletResponse response) throws IOException;

    /**
     * 管理员登录
     * @param admin
     * @param verifycode
     * @param locale
     * @param request
     * @return
     */
    List<Map<Object, Object>> login(Administrator admin, String verifycode, Locale locale, HttpServletRequest request);


    /**
     * 查询此管理员的所有信息
     * @param username
     * @return
     */
    Administrator findByRoleName(String username);
}
