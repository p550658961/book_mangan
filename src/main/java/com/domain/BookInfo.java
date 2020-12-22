package com.domain;


import java.io.Serializable;
import java.util.Date;

public class BookInfo implements Serializable {

    private Integer id;
    private Integer typeId;
    private String bookName;
    private String author;
    private Integer count;
    private Date newTime;
    private String publishing;
    private Integer borrow;
    private BookType bookType;
    private Integer total;

    public Integer getTotal() {
        return total;
    }

    public void setTotal(Integer total) {
        this.total = total;
    }

    public BookType getBookType() {
        return bookType;
    }

    public void setBookType(BookType bookType) {
        this.bookType = bookType;
    }

    public Integer getBorrow() {
        return borrow;
    }

    public void setBorrow(Integer borrow) {
        this.borrow = borrow;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getTypeId() {
        return typeId;
    }

    public void setTypeId(Integer typeId) {
        this.typeId = typeId;
    }

    public String getBookName() {
        return bookName;
    }

    public void setBookName(String bookName) {
        this.bookName = bookName;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public Integer getCount() {
        return count;
    }

    public void setCount(Integer count) {
        this.count = count;
    }

    public Date getNewTime() {
        return newTime;
    }

    public void setNewTime(Date newTime) {
        this.newTime = newTime;
    }

    public String getPublishing() {
        return publishing;
    }

    public void setPublishing(String publishing) {
        this.publishing = publishing;
    }

    @Override
    public String toString() {
        return "BookInfo{" +
                "id=" + id +
                ", typeId=" + typeId +
                ", bookName='" + bookName + '\'' +
                ", author='" + author + '\'' +
                ", count=" + count +
                ", newTime=" + newTime +
                ", publishing='" + publishing + '\'' +
                ", borrow=" + borrow +
                ", bookType=" + bookType +
                ", total=" + total +
                '}';
    }
}
