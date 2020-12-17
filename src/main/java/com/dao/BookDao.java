package com.dao;

import com.domain.BookInfo;
import com.domain.BookType;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface BookDao {

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
    List<BookInfo> findBookInfo(@Param("bookName") String bookName, @Param("type") String type);

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
     * @param total
     * @return
     */
    int updateById(@Param("id") Integer id,@Param("total") Integer total);
}
