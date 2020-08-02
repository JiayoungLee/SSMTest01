package com.hqyj.service.impl;

import com.hqyj.dao.DeparmentMapper;
import com.hqyj.pojo.Deparment;
import com.hqyj.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * author  Jayoung
 * createDate  2020/7/21 0021 11:09
 * version 1.0
 */
@Service
public class DepartmentServiceImpl implements DepartmentService {
    @Autowired
    private DeparmentMapper dao;
    @Override
    public Deparment selectByPrimaryKey(Integer id) {
        return dao.selectByPrimaryKey(id);
    }

    @Override
    public List<Deparment> selectAllDept() {
        return dao.selectAllDept();
    }
}
