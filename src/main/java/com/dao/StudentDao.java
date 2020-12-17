package com.dao;

import com.domain.Student;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface StudentDao {

    /**
     * 添加学生信息
     * @param student
     * @return
     */
    int insertStudentInfo(Student student);

    /**
     * 查询所有学号
     * @return
     */
    List<String> findStudentNumber();


    /**
     * 模糊查询
     * @param
     * @return
     */
    List<Student> findByNameOrClasses(@Param("name") String name,@Param("classes") String classes);

    /**
     * 根据id删除学生信息
     * @param id
     * @return
     */
    int byIdDeleteStudent(Integer id);

    int deleteStudentIds(List<Integer> ids);
}
