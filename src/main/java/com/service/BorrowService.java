package com.service;

import com.domain.BookInfo;
import com.domain.Borrow;
import com.domain.Student;
import org.apache.ibatis.annotations.Param;

import java.text.ParseException;
import java.util.Date;
import java.util.List;
import java.util.Map;

public interface BorrowService {

    /**
     * 根据学生姓名和学号查询
     * @param name
     * @param number
     * @return
     */
    Student findByNameNumber(String name, String number);

    /**
     * 根据书名和作者查询
     * @param bookName
     * @param author
     * @return
     */
    BookInfo findByBookNameAuthor(String bookName, String author);

    /**
     * 借书，修改库存和已借数量
     * @param id
     * @return
     */
    int updateBookInfo(Integer id);

    /**
     * 将借书信息保存
     * @param borrow
     * @return
     */
    int insertBorrow(Borrow borrow);

    /**
     * 借书操作
     * @param student
     * @param bookInfo
     * @param dueDate
     * @return
     * @throws ParseException
     */
    Map<Object,Object> borrowBook(Student student, BookInfo bookInfo, String dueDate) throws ParseException;

    /**
     * 模糊查询，借阅记录
     * @param name
     * @param bookName
     * @param status
     * @return
     */
    List<Borrow> findDimAll(String name, String bookName, String status);

    int updateBorrow(Integer id,String bookName,String author);

    /**
     * 还书，修改库存和已借数量
     * @param id
     * @return
     */
    int updateBookInfo2(Integer id);

    /**
     * 查询是否逾期
     * @return
     */
    List<Map<String,Object>> findOverDue();

    int updateBorrowBookTime(Integer id,String dueDate) throws ParseException;


}
