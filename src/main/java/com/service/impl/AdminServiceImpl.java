package com.service.impl;

import com.dao.AdminDao;
import com.domain.Administrator;
import com.service.AdminService;
import com.utils.MD5Utils;
import org.apache.shiro.crypto.hash.Md5Hash;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;


@Service
public class AdminServiceImpl implements AdminService {

    @Resource
    private AdminDao adminDao;

    public boolean findByUsername(String username) {
        List<String> usernames = adminDao.findByUsername();
        for (String s : usernames) {
            if (username.equals(s) == true){
                return true;
            }
        }
        return false;
    }

    /**
     * 添加管理员
     * @param administrator
     * @return
     */
    public int insertAdministrator(Administrator administrator) {
        String s = MD5Utils.md5();
        // 加密密码
        Md5Hash md5Hash = new Md5Hash(administrator.getPassword(),s,1024);
        administrator.setPassword(md5Hash.toHex());
        administrator.setSalt(s);
        administrator.setCreateDate(new Date());
        int i = adminDao.insertAdministrator(administrator);
        return i;
    }

    public List<Administrator> findAll() {
        return adminDao.findAll();
    }

    public int deleteAdminById(Integer id) {
        return adminDao.deleteAdminById(id);
    }
}
