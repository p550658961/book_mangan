package com.service;

import com.domain.BookInfo;
import com.domain.BookType;

import java.util.List;

public interface BookService {

    /**
     * 查询图书类型
     * @return
     */
    List<BookType> findBookType();

    /**
     * 添加图书
     * @param bookInfo
     */
    void insertBookInfo(BookInfo bookInfo);

    /**
     * 模糊查询
     * @param bookName
     * @param type
     * @return
     */
    List<BookInfo> findBookInfo(String bookName,String type);

    /**
     * 删除图书
     * @param id
     * @return
     */
    int deleteById(Integer id);

    /**
     * 根据id查询图书
     * @param id
     * @return
     */
    BookInfo findById(Integer id);

    /**
     * 根据id修改库存
     * @param id
     * @param count
     * @return
     */
    int updateById(Integer id,Integer count);

}
