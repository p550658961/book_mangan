package com.domain;

import java.io.Serializable;
import java.util.Date;

public class Borrow implements Serializable {
    private Integer id;
    private Integer studentId;
    private Integer bookId;
    private Date borrowBookDate;
    private Date returnBookDate;
    private Date dueDate;
    private String status;
    private BookInfo bookInfo;
    private Student student;

    @Override
    public String toString() {
        return "Borrow{" +
                "id=" + id +
                ", studentId=" + studentId +
                ", bookId=" + bookId +
                ", borrowBookDate=" + borrowBookDate +
                ", returnBookDate=" + returnBookDate +
                ", dueDate=" + dueDate +
                ", status=" + status +
                ", bookInfo=" + bookInfo +
                ", student=" + student +
                '}';
    }

    public BookInfo getBookInfo() {
        return bookInfo;
    }

    public void setBookInfo(BookInfo bookInfo) {
        this.bookInfo = bookInfo;
    }

    public Student getStudent() {
        return student;
    }

    public void setStudent(Student student) {
        this.student = student;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getStudentId() {
        return studentId;
    }

    public void setStudentId(Integer studentId) {
        this.studentId = studentId;
    }

    public Integer getBookId() {
        return bookId;
    }

    public void setBookId(Integer bookId) {
        this.bookId = bookId;
    }

    public Date getBorrowBookDate() {
        return borrowBookDate;
    }

    public void setBorrowBookDate(Date borrowBookDate) {
        this.borrowBookDate = borrowBookDate;
    }

    public Date getReturnBookDate() {
        return returnBookDate;
    }

    public void setReturnBookDate(Date returnBookDate) {
        this.returnBookDate = returnBookDate;
    }

    public Date getDueDate() {
        return dueDate;
    }

    public void setDueDate(Date dueDate) {
        this.dueDate = dueDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
