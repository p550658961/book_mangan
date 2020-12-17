package com.service.impl;

import com.dao.BorrowDao;
import com.domain.BookInfo;
import com.domain.Borrow;
import com.domain.Student;
import com.service.BorrowService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class BorrowServiceImpl implements BorrowService {

    @Resource
    private BorrowDao borrowDao;

    public Student findByNameNumber(String name, String number) {
        return borrowDao.findByNameNumber(name,number);
    }

    public BookInfo findByBookNameAuthor(String bookName, String author) {
        return borrowDao.findByBookNameAuthor(bookName,author);
    }

    public int updateBookInfo(Integer id) {
        return borrowDao.updateBookInfo(id);
    }

    public int insertBorrow(Borrow borrow) {
        return borrowDao.insertBorrow(borrow);
    }

    @Transactional
    public Map<Object,Object> borrowBook(Student student, BookInfo bookInfo, String dueDate) throws ParseException {
        Student s = this.findByNameNumber(student.getName(), student.getNumber());
        Map<Object,Object> map = new HashMap<Object, Object>();
        if (s == null){
            map.put("error","请输入学生的正确信息或者添加学生信息");
            return map;
        }
        BookInfo b = this.findByBookNameAuthor(bookInfo.getBookName(), bookInfo.getAuthor());
        System.out.println(b);
        if (b == null ){
            map.put("error","没有你所要借的图书");
            return map;
        }
        if (b.getCount() == 0){
            map.put("error","你所借的书都以借完");
            return map;
        }
        if (dueDate.length() <=0){
            map.put("error","请填写待归还日期");
            return map;
        }
        this.updateBookInfo(b.getId());
        Borrow borrow = new Borrow();
        borrow.setStudentId(s.getId());
        borrow.setBookId(b.getId());
        borrow.setBorrowBookDate(new Date());
        // 解析字符串，转换为日期格式
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm");
        String replace = dueDate.replace('T', ' ');
        Date parse = simpleDateFormat.parse(replace);
        borrow.setDueDate(parse);
        this.insertBorrow(borrow);
        map.put("success","success");
        return map;
    }

    public List<Borrow> findDimAll(String name, String bookName, String status) {
        return borrowDao.findDimAll(name,bookName,status);
    }

    /**
     * 原子性操作所有要添加事务，
     * @param id
     * @param bookName
     * @param author
     * @return
     */
    @Transactional
    public int updateBorrow(Integer id,String bookName,String author) {
        // 归还图书，根据书名和作者修改库存和已借数量
        BookInfo bookInfo = this.findByBookNameAuthor(bookName, author);
        int i = this.updateBookInfo2(bookInfo.getId());
        if (i>0){
            // 根据id修改归还时间
            return borrowDao.updateBorrow(id,new Date());
        }
        return 0;
    }

    public int updateBookInfo2(Integer id) {
        return borrowDao.updateBookInfo2(id);
    }

    /**
     * 模糊查询
     * @return
     */
    public List<Map<String, Object>> findOverDue() {
        List<Map<String, Object>> overDue = borrowDao.findOverDue(new Date());
        // 遍历保存的信息，将逾期时间转化为天和分钟的单位
        for (Map<String, Object> map : overDue) {
            for (String s : map.keySet()){
                if (s.equals("due_date")){
                    Date date = (Date) map.get(s);
                    long day, hour, min;
                    long nd = 1000 * 24 * 60 * 60;// 一天的毫秒数
                    long nh = 1000 * 60 * 60;// 一小时的毫秒数
                    long nm = 1000 * 60; //一分钟的毫秒数
                    Date d1 = new Date();
                    long diff = d1.getTime() - date.getTime();
                    day = diff / nd;// 计算差多少天
                    hour = diff % nd / nh + day * 24;// 计算差多少小时
                    min = diff % nd % nh / nm + day * 24 * 60;// 计算差多少分钟
                    String overdue = (day==0?"":day+ "天")  + ((hour - day * 24)==0?"": (hour - day * 24)+ "小时")
                            + ((min - day * 24 * 60)==0?"":(min - day * 24 * 60) + "分钟");
                    map.put("due_date",overdue);
                }
            }
        }
        return overDue;
    }

    public int updateBorrowBookTime(Integer id, String dueDate) throws ParseException {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm");
        String replace = dueDate.replace('T', ' ');
        Date parse = simpleDateFormat.parse(replace);
        return borrowDao.updateBorrowBookTime(id,new Date(),parse);
    }

}
