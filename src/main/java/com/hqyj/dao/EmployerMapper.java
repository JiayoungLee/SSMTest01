package com.hqyj.dao;

import com.hqyj.pojo.Employer;

import java.util.List;

public interface EmployerMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Employer record);

    int insertSelective(Employer record);

    Employer selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Employer record);

    int updateByPrimaryKey(Employer record);

    List<Employer> selectByPage(Employer emp);
    //批量删除
    int deleteAll(List<String> list);
}