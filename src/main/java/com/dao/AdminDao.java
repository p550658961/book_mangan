package com.dao;

import com.domain.Administrator;
import com.domain.Role;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface AdminDao {

    /**
     * 查询管理员名称
     * @return
     */
    @Select("select username from administrator")
    List<String> findByUsername();

    /**
     * 添加管理员
     * @param administrator
     * @return
     */
    int insertAdministrator(Administrator administrator);

    /**
     * 查询所有管理员
     * @return
     */
    List<Administrator> findAll();

    /**
     * 根据id删除管理员，只有超级管理员才有此权限
     * @param id
     * @return
     */
    int deleteAdminById(Integer id);

}
