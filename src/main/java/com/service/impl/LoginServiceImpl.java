package com.service.impl;

import com.dao.LoginDao;
import com.domain.Administrator;
import com.service.LoginService;
import org.apache.shiro.crypto.hash.Md5Hash;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.*;
import java.util.List;


@Service
public class LoginServiceImpl implements LoginService {

    @Resource
    private LoginDao loginDao;
    // 获取验证码
    public void checkCode(HttpServletRequest request, HttpServletResponse response) throws IOException {
        //服务器通知浏览器不要缓存
        response.setHeader("pragma","no-cache");
        response.setHeader("cache-control","no-cache");
        response.setHeader("expires","0");

        //在内存中创建一个长80，宽30的图片，默认黑色背景
        //参数一：长
        //参数二：宽
        //参数三：颜色
        int width = 90;
        int height = 35;
        BufferedImage image = new BufferedImage(width,height,BufferedImage.TYPE_INT_RGB);

        //获取画笔
        Graphics g = image.getGraphics();
        //设置画笔颜色为灰色
        g.setColor(Color.GRAY);
        //填充图片
        g.fillRect(0,0, width,height);

        //产生4个随机验证码，12Ey
        String checkCode = getCheckCode();
        //将验证码放入HttpSession中
        request.getSession().setAttribute("CHECKCODE_SERVER",checkCode);

        //设置画笔颜色为黄色
        g.setColor(Color.YELLOW);
        //设置字体的小大
        g.setFont(new Font("黑体",Font.BOLD,24));
        //向图片上写入验证码
        g.drawString(checkCode,15,25);

        //将内存中的图片输出到浏览器
        //参数一：图片对象
        //参数二：图片的格式，如PNG,JPG,GIF
        //参数三：图片输出到哪里去
        ImageIO.write(image,"PNG",response.getOutputStream());
    }

    /**
     * 判断用户名和密码是否正确，以及验证码是否正确
     * @param verifycode
     * @param request
     * @return
     */
    public List<Map<Object, Object>> login(Administrator admin, String verifycode,Locale locale, HttpServletRequest request) {
        List<Map<Object, Object>> mapList = new ArrayList<Map<Object, Object>>();
        Map<Object,Object> map = new HashMap<Object, Object>();
        // 3.验证码校验
        HttpSession session = request.getSession();
        String checkcode_server = (String) session.getAttribute("CHECKCODE_SERVER");
        String locale1 = locale.toString();
        // 判断验证码是否正确，如果错误就直接返回错误信息
        if (!checkcode_server.equalsIgnoreCase(verifycode) && verifycode != null) {
            // 验证码不正确
            // 提示信息
            map.put("check_msg",locale1.equals("en_US") ? "verification error":"验证码错误");
        }else {
            // 获取数据库中保存的真实加密密码
            Md5Hash md5Hash = new Md5Hash(admin.getPassword(),loginDao.findByRoleName(admin.getUsername()).getSalt(),1024);
            //4.调用Service查询
            Administrator administrator = loginDao.login(admin.getUsername(), md5Hash.toHex());
            //5.判断是否登录成功
            if (administrator != null ) {
                // 登录成功,返回true
                map.put("success","登录成功");
                request.getSession().setAttribute("admin",admin.getUsername());
            } else {
                //登录失败
                //提示信息
                map.put("login_msg", locale1.equals("en_US") ? "username or password error":"用户名或密码错误");
            }
        }
        // 把错误信息保存在map中
        mapList.add(map);
        // 返回错误信息
        return mapList;
    }

    /**
     * 查询管理员所有信息
     * @param username
     * @return
     */
    public Administrator findByRoleName(String username) {
        return loginDao.findByRoleName(username);
    }


    /**
     * 产生4位随机字符串
     */
    private String getCheckCode() {
        String base = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
        int size = base.length();
        Random r = new Random();
        StringBuffer sb = new StringBuffer();
        for(int i=1;i<=4;i++){
            //产生0到size-1的随机值
            int index = r.nextInt(size);
            //在base字符串中获取下标为index的字符
            char c = base.charAt(index);
            //将c放入到StringBuffer中去
            sb.append(c);
        }
        return sb.toString();
    }
}
