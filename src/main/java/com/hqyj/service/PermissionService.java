package com.hqyj.service;

import com.hqyj.pojo.Permission;

import java.util.List;

/**
 * author  Jayoung
 * createDate  2020/7/30 0030 16:01
 * version 1.0
 */
public interface PermissionService {
    List<Permission> selectPermissionByPermissionName(String permissionName);
}
