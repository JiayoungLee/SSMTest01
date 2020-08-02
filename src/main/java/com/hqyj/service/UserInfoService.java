package com.hqyj.service;

import com.hqyj.pojo.UserInfo;

import java.util.HashMap;
import java.util.List;

/**
 * author  Jayoung
 * createDate  2020/7/21 0021 16:10
 * version 1.0
 */
public interface UserInfoService {
    int updateByPrimaryKey(UserInfo record);

    HashMap<String, Object> selectByPage(UserInfo userInfo);

    UserInfo selectByPrimaryKey(Integer uId);

    int deleteByPrimaryKey(Integer uId);

    int insert(UserInfo record);

    int deleteAll(List allId);

}
