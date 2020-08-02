package com.hqyj.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.hqyj.dao.UserInfoMapper;
import com.hqyj.pojo.UserInfo;
import com.hqyj.service.UserInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;

/**
 * author  Jayoung
 * createDate  2020/7/21 0021 16:10
 * version 1.0
 */
@Service
public class UserInfoServiceImpl implements UserInfoService {
    @Autowired
    private UserInfoMapper userInfoDao;

    @Override
    public int updateByPrimaryKey(UserInfo record) {
        return userInfoDao.updateByPrimaryKey(record);
    }

    @Override
    public HashMap<String, Object> selectByPage(UserInfo userInfo) {

        PageHelper.startPage(userInfo.getPage(),userInfo.getRow());

        List<UserInfo> userInfos = userInfoDao.selectByPage(userInfo);

        PageInfo<UserInfo> pageInfo = new PageInfo<UserInfo>(userInfos);

        HashMap<String,Object> map = new HashMap<>();

        map.put("list",pageInfo.getList());

        map.put("count",pageInfo.getTotal());
        map.put("prePage",pageInfo.getPrePage());
        map.put("nextPage",pageInfo.getNextPage());
        map.put("firstPage",pageInfo.getFirstPage());
        //每页的数量
        map.put("numPerPage",pageInfo.getPageSize());
        //当前页码
        map.put("currentPage",pageInfo.getPageNum());
        //总页码
        map.put("totalPageNum",pageInfo.getPages());
        map.put("navigatepageNums",pageInfo.getNavigatepageNums());
        return map;
    }

    @Override
    public UserInfo selectByPrimaryKey(Integer uId) {
        return userInfoDao.selectByPrimaryKey(uId);
    }

    @Override
    public int deleteByPrimaryKey(Integer uId) {
        return userInfoDao.deleteByPrimaryKey(uId);
    }

    @Override
    public int insert(UserInfo record) {
        return userInfoDao.insert(record);
    }

    @Override
    public int deleteAll(List allId) {
        return userInfoDao.deleteAll(allId);
    }


}
