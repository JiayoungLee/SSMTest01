package com.hqyj.service;

import com.hqyj.pojo.Deparment;

import java.util.List;

/**
 * author  Jayoung
 * createDate  2020/7/21 0021 11:08
 * version 1.0
 */
public interface DepartmentService {
    Deparment selectByPrimaryKey(Integer id);
    List<Deparment> selectAllDept();
}
