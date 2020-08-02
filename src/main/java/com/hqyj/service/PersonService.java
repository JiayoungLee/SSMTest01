package com.hqyj.service;

import com.hqyj.pojo.Person;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * author  Jayoung
 * createDate  2020/7/28 0028 16:47
 * version 1.0
 */

public interface PersonService {
    Person queryCookie(HttpServletRequest request) ;

    Person selectByPersonName(String personName);

    String checkLogin(Person person, String isMemory, HttpServletResponse response, HttpServletRequest request);
}
