package com.controller;


import com.domain.Student;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.validation.Valid;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/student")
public class StudentController {

    @Autowired
    private StudentService studentService;

    /**
     * 添加学生信息，并校验学生信息不能为空
     * @param student
     * @param result
     * @return
     */
    @RequestMapping("/addStudent")
    @ResponseBody
    public Map<Object,Object> addStudentInfo(@Valid Student student, BindingResult result){
        return studentService.studentCheck(student,result);
    }


    /**
     * 检查学号是否存在
     * @param number
     * @return
     */
    @RequestMapping("/studentNumberCheck")
    @ResponseBody
    public Map<Object,Object> studentNumberCheck(String number){
        return studentService.nameCheck(number);
    }


    /**
     * 模糊查询的分页展示
     * @param pn
     * @param name
     * @param classes
     * @return
     */
    @RequestMapping("/pageShowStudent")
    @ResponseBody()
    public PageInfo<Student> pageShowStudent(@RequestParam(value = "pn",defaultValue = "1") Integer pn,String name,String classes) {
        // 引入PageHelper分页插件
        // 在查询之前需要调用,传入页码，以及每页大小
        PageHelper.startPage(pn, 8);
        // startPage后面紧跟的这个查询就是一个分页查询
        List<Student> students = studentService.findByNameOrClasses(name,classes);
        // 使用pageInfo包装查询后的结果
        // 封装了详细的分页信息，包括有我们查询出来的数据，传入连续显示的页数
        PageInfo page = new PageInfo(students, 8);
        return page;
    }


    /**
     * 单个批量二合一 删除学生
     * @param del_idstr
     * @return
     */
    @ResponseBody
    @RequestMapping("/deleteStudentIds")
    public int deleteStudentIds(String del_idstr){
       return studentService.deleteStudentIds(del_idstr);
    }


}
