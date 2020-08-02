package com.hqyj.service;

import com.hqyj.pojo.Employer;

import java.util.HashMap;
import java.util.List;

/**
 * author  Jayoung
 * createDate  2020/7/20 0020 14:34
 * version 1.0
 */
public interface EmployerService {
    public HashMap<String, Object> selectByPage(Employer emp);

    Employer selectByPrimaryKey(Integer id);

    int updateByEmployer(Employer record);

    int deleteByPrimaryKey(Integer id);

    int insert(Employer record);
    //批量删除
    int deleteAll(List<String> allId);

}
