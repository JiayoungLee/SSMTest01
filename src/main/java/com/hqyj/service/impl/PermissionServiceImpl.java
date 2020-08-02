package com.hqyj.service.impl;

import com.hqyj.dao.PermissionMapper;
import com.hqyj.pojo.Permission;
import com.hqyj.service.PermissionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * author  Jayoung
 * createDate  2020/7/30 0030 16:01
 * version 1.0
 */
@Service
public class PermissionServiceImpl implements PermissionService {
    @Autowired
    private PermissionMapper permissionMapper;
    @Override
    public List<Permission> selectPermissionByPermissionName(String permissionName) {
        return null;
    }
}
