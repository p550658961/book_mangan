package com.dao;

import com.domain.Administrator;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.mybatis.spring.annotation.MapperScan;



public interface LoginDao {

    /**
     * 根据管理员名称和密码登录
     * @param username
     * @param password
     * @return
     */
    @Select("select * from administrator where username=#{username} and password=#{password}")
    Administrator login(@Param("username") String username, @Param("password") String password);

    /**
     * 根据管理员名称查询该管理员的信息
     * @param username
     * @return
     */
    Administrator findByRoleName(String username);

}
