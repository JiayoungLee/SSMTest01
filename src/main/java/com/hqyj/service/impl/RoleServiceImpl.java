package com.hqyj.service.impl;

import com.hqyj.dao.RoleMapper;
import com.hqyj.pojo.Role;
import com.hqyj.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * author  Jayoung
 * createDate  2020/7/21 0021 16:11
 * version 1.0
 */
@Service
public class RoleServiceImpl implements RoleService {

    @Autowired
    private RoleMapper roleDao;
    @Override
    public List<Role> selectAllRole() {
        return roleDao.selectAllRole();
    }
}
