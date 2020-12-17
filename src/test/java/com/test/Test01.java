package com.test;

import com.alibaba.druid.sql.visitor.ExportParameterizedOutputVisitor;
import com.alibaba.druid.support.json.JSONUtils;
import com.dao.AdminDao;
import com.dao.BookDao;
import com.dao.BorrowDao;
import com.dao.StudentDao;
import com.domain.Administrator;
import com.domain.BookInfo;
import com.domain.Borrow;
import com.domain.Student;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.utils.MD5Utils;
import org.apache.shiro.crypto.hash.Md5Hash;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;
import java.lang.reflect.Array;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "classpath:applicationContext.xml")
public class Test01 {

    @Resource
    BookDao bookDao;
    @Resource
    BorrowDao borrowDao;
    @Resource
    private AdminDao adminDao;
    @Resource
    private StudentDao studentDao;

    @Test
    public void test01() {
        List<Administrator> all = adminDao.findAll();
        for (Administrator administrator : all) {
            SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            Date date = administrator.getCreateDate();
            String format = simpleDateFormat.format(date);
            System.out.println(format);
        }
    }

    @Test
    public void test02() {
        String s = MD5Utils.md5();
        Md5Hash md5Hash = new Md5Hash("123", s, 1024);
        System.out.println(md5Hash);

    }

    @Test
    public void test03() {
        Administrator administrator = new Administrator();
        String s = MD5Utils.md5();
        Md5Hash md5Hash = new Md5Hash("123", s, 1024);
        administrator.setUsername("lisi");
        administrator.setPassword(md5Hash.toHex());
        administrator.setSalt(s);
        administrator.setRid(2);
        administrator.setCreateDate(new Date());
        adminDao.insertAdministrator(administrator);
    }

    @Test
    public void test04() {
        List<Administrator> all = adminDao.findAll();
        for (Administrator administrator : all) {
            System.out.println(administrator);
        }
    }

    @Test
    public void test05() {
        PageHelper.startPage(1, 5);
        // startPage后面紧跟的这个查询就是一个分页查询
        List<Administrator> admin = adminDao.findAll();
        // 使用pageInfo包装查询后的结果
        // 封装了详细的分页信息，包括有我们查询出来的数据，传入连续显示的页数
        PageInfo page = new PageInfo(admin, 5);
        System.out.println(page);
    }

    @Test
    public void test06() {
        String number = "201818030x";
        if (number.length() != 10) {
            System.out.println("学号不正确");
        } else {
            if (!number.matches("^\\d+$")) {
                System.out.println("学号必须是数字");
            }
        }
        System.out.println("合法");
    }

    @Test
    public void test07() {

        List<Student> students = studentDao.findByNameOrClasses("张", "15");
        for (Student student : students) {
            System.out.println(student);
        }
    }

    @Test
    public void test08() {
        List<Integer> ids = Arrays.asList(6);
        int i = studentDao.deleteStudentIds(ids);
        System.out.println(i);
    }

    @Test
    public void test09() {
        List<BookInfo> bookInfo = bookDao.findBookInfo("", "");
        for (BookInfo info : bookInfo) {
            System.out.println(info);
        }
    }

    @Test
    public void test10() {
        BookInfo byId = bookDao.findById(2);
        System.out.println(byId);
    }

    @Test
    public void test11() {
        borrowDao.updateBookInfo(8);
        Borrow borrow = new Borrow();
        borrow.setStudentId(9);
        borrow.setBookId(8);
        borrow.setBorrowBookDate(new Date());
        borrow.setReturnBookDate(new Date());
        borrowDao.insertBorrow(borrow);
    }

    @Test
    public void test12() {
        BookInfo bookInfo = borrowDao.findByBookNameAuthor("西游记", "吴承恩");
        System.out.println(bookInfo);
    }

    @Test
    public void test13() {
        Student 李四 = borrowDao.findByNameNumber("李四", "2018180102");
        System.out.println(李四);
    }

    @Test
    public void test14() throws ParseException {
        String s = "2020-12-07T15:23";
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm");
        String replace = s.replace('T', ' ');
        Date parse = simpleDateFormat.parse(replace);
        System.out.println(parse);
    }

    @Test
    public void test15() {
        List<Borrow> dimAll = borrowDao.findDimAll("", "", "");
        for (Borrow borrow : dimAll) {
            System.out.println(borrow);
        }
    }

    @Test
    public void test16() throws ParseException {
        List<Map<String, Object>> overDue = borrowDao.findOverDue(new Date());
        for (Map<String, Object> map : overDue) {
            for (String s : map.keySet()){
                if (s.equals("due_date")){
                    Date date = (Date) map.get(s);
                    long day, hour, min;
                    long nd = 1000 * 24 * 60 * 60;// 一天的毫秒数
                    long nh = 1000 * 60 * 60;// 一小时的毫秒数
                    long nm = 1000 * 60;
                    Date d1 = new Date();
                    long diff = d1.getTime() - date.getTime();// 这样得到的差值是微秒级别
                    day = diff / nd;// 计算差多少天
                    hour = diff % nd / nh + day * 24;// 计算差多少小时
                    min = diff % nd % nh / nm + day * 24 * 60;// 计算差多少分钟
                    String overdue = (day==0?"":day+ "天")  + ((hour - day * 24)==0?"": (hour - day * 24)+ "小时")
                            + ((min - day * 24 * 60)==0?"":(min - day * 24 * 60) + "分钟");
                    map.put("due_date",overdue);
                }
            }
        }

        for (Map<String, Object> map : overDue){
            for (String s : map.keySet()){
                Object o = map.get(s);
                System.out.println(s+"===="+o);
            }
        }
    }

    @Test
    public void test17() throws ParseException {


    }
}
