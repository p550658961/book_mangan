package com.service;


import com.domain.Administrator;

import java.util.List;

public interface AdminService {

    /**
     * 查询是否有该管理员
     * @param username
     * @return
     */
    boolean findByUsername(String username);

    /**
     * 添加管理员
     * @param administrator
     * @return
     */
    int insertAdministrator(Administrator administrator);

    /**
     * 查询所有管理员信息
     * @return
     */
    List<Administrator> findAll();


    /**
     * 根据id删除管理员
     * @return
     */
    int deleteAdminById(Integer id);

}
