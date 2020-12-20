package com.controller;


import com.domain.BookInfo;
import com.domain.Borrow;
import com.domain.Student;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.service.BorrowService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.text.ParseException;
import java.util.List;
import java.util.Map;


@Controller
@RequestMapping("/borrow")
public class BorrowController {

    @Autowired
    private BorrowService borrowService;

    /**
     * 借书操作
     * @param student
     * @param bookInfo
     * @param dueDate
     * @return
     * @throws ParseException
     */
    @RequestMapping("/borrowBook")
    @ResponseBody
    public Map<Object, Object> borrowBook(Student student, BookInfo bookInfo, String dueDate) throws ParseException {
        return borrowService.borrowBook(student,bookInfo,dueDate);
    }

    /**
     * 归还图书和借阅记录二合一的分页展示
     * @param pn
     * @param name
     * @param bookName
     * @param status
     * @return
     */
    @RequestMapping("/showAllInfo")
    @ResponseBody
    public PageInfo<Borrow> showAllInfo(@RequestParam(value = "pn",defaultValue = "1") Integer pn,String name ,String bookName,String status){
        // 引入PageHelper分页插件
        // 在查询之前需要调用,传入页码，以及每页大小
        PageHelper.startPage(pn, 8);
        // startPage后面紧跟的这个查询就是一个分页查询
        List<Borrow> borrows;
        if (bookName == null && status == null){
            borrows = borrowService.findDimAll(name,"","未还");
        }else{
            borrows = borrowService.findDimAll(name,bookName,status);
        }
        // 使用pageInfo包装查询后的结果
        // 封装了详细的分页信息，包括有我们查询出来的数据，传入连续显示的页数
        PageInfo page = new PageInfo(borrows, 8);
        return page;
    }


    /**
     * 归还图书
     * @param id
     * @param bookName
     * @param author
     * @return
     */
    @RequestMapping("/returnBook")
    @ResponseBody
    public int returnBook(Integer id,String bookName,String author){
        return borrowService.updateBorrow(id,bookName,author);
    }

    /**
     * 查询借书逾期的信息，分页展示
     * @param pn
     * @return
     */
    @RequestMapping("/overDue")
    @ResponseBody
    public PageInfo<Map<String,Object>> overDue(@RequestParam(value = "pn",defaultValue = "1") Integer pn){
        PageHelper.startPage(pn, 8);
        // startPage后面紧跟的这个查询就是一个分页查询
        List<Map<String, Object>> borrows = borrowService.findOverDue();
        // 使用pageInfo包装查询后的结果
        // 封装了详细的分页信息，包括有我们查询出来的数据，传入连续显示的页数
        PageInfo page = new PageInfo(borrows, 8);
        return page;
    }


    /**
     * 是否续借
     * @return
     */
    @RequestMapping("/updateBorrowInfo")
    @ResponseBody
    public int updateBorrowInfo(Integer id,String dueDate) throws ParseException {
        if(dueDate.length()<=0){
            return -1;
        }
        return borrowService.updateBorrowBookTime(id,dueDate);
    }
}
