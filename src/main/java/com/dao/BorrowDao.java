package com.dao;

import com.domain.BookInfo;
import com.domain.Borrow;
import com.domain.Student;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;
import java.util.Map;

public interface BorrowDao {

    /**
     * 根据学生和学号查询
     * @param name
     * @param number
     * @return
     */
    Student findByNameNumber(@Param("name") String name, @Param("number") String number);

    /**
     * 根据书名和作者查询
     * @param bookName
     * @param author
     * @return
     */
    BookInfo findByBookNameAuthor(@Param("bookName") String bookName,@Param("author") String author);

    /**
     * 借书，修改库存和已借数量
     * @param id
     * @return
     */
    int updateBookInfo(Integer id);

    /**
     * 借书，将借书信息保存
     * @param borrow
     * @return
     */
    int insertBorrow(Borrow borrow);

    /**
     * 根据学生姓名和书名以及状态模糊查询
     * @param name
     * @param bookName
     * @param status
     * @return
     */
    List<Borrow> findDimAll(@Param("name") String name,@Param("bookName") String bookName,@Param("status") String status);

    /**
     * 根据id修改归还图书
     * @param id
     * @param returnBookDate
     * @return
     */
    int updateBorrow(@Param("id") Integer id, @Param("returnBookDate")Date returnBookDate);

    /**
     * 还书，修改库存和已借数量
     * @param id
     * @return
     */
    int updateBookInfo2(Integer id);

    /**
     * 查询是否逾期
     * @param date
     * @return
     */
    List<Map<String,Object>> findOverDue(Date date);

    /**
     * 续借功能
     * @param id
     * @param borrowBookDate
     * @param dueDate
     * @return
     */
    int updateBorrowBookTime(@Param("id") Integer id,@Param("borrowBookDate") Date borrowBookDate,@Param("dueDate") Date dueDate);
}
