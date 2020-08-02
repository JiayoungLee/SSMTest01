package com.hqyj.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.hqyj.dao.EmployerMapper;
import com.hqyj.pojo.Employer;
import com.hqyj.service.EmployerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;

/**
 * author  Jayoung
 * createDate  2020/7/20 0020 14:34
 * version 1.0
 */
@Service
public class EmployerServiceImpl implements EmployerService {
    @Autowired
    private EmployerMapper dao;

    @Override
    public HashMap<String, Object> selectByPage(Employer emp) {
        PageHelper.startPage(emp.getPage(), emp.getRow());
        //2查询自定义的sql
        List<Employer> list = dao.selectByPage(emp);
        //3 转换成分页对象
        PageInfo<Employer> pageInfo = new PageInfo<Employer>(list, 2);

        //构建数据类型
        HashMap<String, Object> map = new HashMap<String, Object>();
        map.put("list", pageInfo.getList());
        //总记录数
        map.put("count", pageInfo.getTotal());
        map.put("prePage", pageInfo.getPrePage());
        map.put("nextPage", pageInfo.getNextPage());
        map.put("indexPage", pageInfo.getFirstPage());
        //每页的数量
        map.put("numPerPage", pageInfo.getPageSize());
        //当前页码
        map.put("currentPage", pageInfo.getPageNum());
        //总页码
        map.put("totalPageNum", pageInfo.getPages());
        for (Employer e : list) {
            System.out.println("---------------EmployerInfo-------------" + e.getdId()+"----"+e.getEmpName());
        }
        map.put("navigatepageNums", pageInfo.getNavigatepageNums());
        return map;
    }

    @Override
    public Employer selectByPrimaryKey(Integer id) {
        return dao.selectByPrimaryKey(id);
    }

    @Override
    public int updateByEmployer(Employer record) {
        return dao.updateByPrimaryKeySelective(record);
    }

    @Override
    public int deleteByPrimaryKey(Integer id) {
        return dao.deleteByPrimaryKey(id);
    }

    @Override
    public int insert(Employer record) {
        return dao.insert(record);
    }

    @Override
    public int deleteAll(List list) {
        return dao.deleteAll(list);
    }
}
