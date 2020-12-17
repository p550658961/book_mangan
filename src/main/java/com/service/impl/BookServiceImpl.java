package com.service.impl;

import com.dao.BookDao;
import com.domain.BookInfo;
import com.domain.BookType;
import com.service.BookService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

@Service
public class BookServiceImpl implements BookService {

    @Resource
    private BookDao bookDao;

    public List<BookType> findBookType() {
        return bookDao.findBookType();
    }

    public void insertBookInfo(BookInfo bookInfo) {
        bookInfo.setNewTime(new Date());
        bookDao.insertBookInfo(bookInfo);
    }

    public List<BookInfo> findBookInfo(String bookName, String type) {
        return bookDao.findBookInfo(bookName,type);
    }

    public int deleteById(Integer id) {
        return bookDao.deleteById(id);
    }

    public BookInfo findById(Integer id) {
        return bookDao.findById(id);
    }

    public int updateById(Integer id, Integer total) {
        BookInfo byId = bookDao.findById(id);
        int i = total - byId.getBorrow();
        if (i < 0){
            return -2;
        }
        return bookDao.updateById(id,total);
    }
}
