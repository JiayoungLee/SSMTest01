package com.hqyj.dao;

import com.hqyj.pojo.Deparment;

import java.util.List;

public interface DeparmentMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Deparment record);

    int insertSelective(Deparment record);

    Deparment selectByPrimaryKey(Integer id);

    List<Deparment> selectAllDept();

    int updateByPrimaryKeySelective(Deparment record);

    int updateByPrimaryKey(Deparment record);
}