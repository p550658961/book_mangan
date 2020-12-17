package com.service.impl;

import com.dao.StudentDao;
import com.domain.Student;
import com.service.StudentService;
import org.springframework.stereotype.Service;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;

import javax.annotation.Resource;
import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class StudentServiceImpl implements StudentService {

    @Resource
    private StudentDao studentDao;

    public int insertStudentInfo(Student student) {
        return studentDao.insertStudentInfo(student);
    }

    public boolean findStudentNumber(String number) {
        List<String> studentNumber = studentDao.findStudentNumber();
        // 遍历所有学号
        for (String string : studentNumber) {
            // 当数据库存有该学号是，返回true表示学号以存在
            if (string.equals(number)){
                return true;
            }
        }
        return false;
    }


    public Map<Object, Object> nameCheck(String number) {
        HashMap<Object, Object> map = new HashMap<Object, Object>();
        if (number.length()==0){
            map.put("error","");
            return map;
        }else if (number.length()!=10){
            map.put("error","学号的长度必须为10");
            return map;
        }
        if (!number.matches("^\\d+$")){
            map.put("error","学号必须是数字");
            return map;
        }
        map.put("error",this.findStudentNumber(number));
        return map;
    }

    public Map<Object, Object> studentCheck(@Valid Student student, BindingResult result) {
        Map<Object, Object> map = new HashMap<Object, Object>();
        System.out.println(student);
        if (result.hasErrors()){
            // 获取错误信息
            List<FieldError> list = result.getFieldErrors();
            for (FieldError fieldError : list) {
                map.put(fieldError.getField(), fieldError.getDefaultMessage());
                System.out.println(fieldError.getField()+"----"+fieldError.getDefaultMessage());
            }
            return map;
        }
        map.put("insert",this.insertStudentInfo(student));
        return map;
    }


    public List<Student> findByNameOrClasses(String name, String classes) {
        return studentDao.findByNameOrClasses(name,classes);
    }


    public int deleteStudentIds(String id) {
        int i;
        if (id.contains("-")){
            List<Integer> ids = new ArrayList<Integer>();
            String[] split = id.split("-");
            for (String s : split){
                ids.add(Integer.parseInt(s));
            }
            i = studentDao.deleteStudentIds(ids);
        }else {
            i = studentDao.byIdDeleteStudent(Integer.parseInt(id));
        }

        return i;
    }




}
