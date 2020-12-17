package com.controller;


import com.domain.BookInfo;
import com.domain.BookType;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.service.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/book")
public class BookController {

    @Autowired
    private BookService bookService;


    /**
     * 查询图书类型
     * @return
     */
    @RequestMapping("/findBookType")
    @ResponseBody
    public List<BookType> findBookType(){
        return bookService.findBookType();
    }

    /**
     * 添加图书
     * @param bookInfo
     * @return
     */
    @RequestMapping("/addBookInfo")
    public String addBookInfo(BookInfo bookInfo){
        bookService.insertBookInfo(bookInfo);
        return "book/listBookInfo";
    }

    /**
     * 分页展示所有图书信息（模糊查询）
     * @param pn
     * @param bookName
     * @param type
     * @return
     */
    @RequestMapping("/pageShowBookInfo")
    @ResponseBody
    public PageInfo<BookInfo> showBookInfo(@RequestParam(value = "pn",defaultValue = "1") Integer pn, String bookName, String type){
        // 引入PageHelper分页插件
        // 在查询之前需要调用,传入页码，以及每页大小
        PageHelper.startPage(pn, 8);
        // startPage后面紧跟的这个查询就是一个分页查询
        List<BookInfo> bookInfo = bookService.findBookInfo(bookName,type);
        // 使用pageInfo包装查询后的结果
        // 封装了详细的分页信息，包括有我们查询出来的数据，传入连续显示的页数
        PageInfo page = new PageInfo(bookInfo, 8);
        return page;
    }

    /**
     * 删除图书
     * @param id
     * @return
     */
    @RequestMapping("/deleteBookInfo")
    @ResponseBody
    public int deleteBookInfo(Integer id){
        return bookService.deleteById(id);
    }

    /**
     * 根据id查询图书
     * @param id
     * @return
     */
    @RequestMapping("/findById")
    @ResponseBody
    public BookInfo findById(Integer id){
        return bookService.findById(id);
    }

    @RequestMapping("/updateBookInfo")
    @ResponseBody
    public int updateById(Integer id,Integer total){
        if (total <0){
            return -1;
        }
        return bookService.updateById(id,total);
    }
}
