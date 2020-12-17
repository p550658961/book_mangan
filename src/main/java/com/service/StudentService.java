package com.service;

import com.domain.BookInfo;
import com.domain.Student;
import org.springframework.validation.BindingResult;

import java.util.List;
import java.util.Map;

public interface StudentService {

    /**
     * 添加学生信息
     * @param student
     * @return
     */
    int insertStudentInfo(Student student);

    /**
     *
     * @param number
     * @return
     */
    boolean findStudentNumber(String number);


    /**
     * 检查学生学号
     * @param number
     * @return
     */
    Map<Object,Object> nameCheck(String number);

    /**
     * 检查学生信息不能为空
     * @param student
     * @param result
     * @return
     */
    Map<Object,Object> studentCheck(Student student, BindingResult result);


    /**
     * 模糊查询学生信息
     * @param name
     * @param classes
     * @return
     */
    List<Student> findByNameOrClasses(String name,String classes);


    int deleteStudentIds(String id);

}
