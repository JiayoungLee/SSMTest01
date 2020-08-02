package com.hqyj.controller;

import com.hqyj.pojo.Person;
import com.hqyj.service.PersonService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.filter.mgt.DefaultFilter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Date;


/**
 * author  Jayoung
 * createDate  2020/7/28 0028 16:50
 * version 1.0
 */
@Controller
@RequestMapping("pc")
public class PersonController {

    @Autowired
    private PersonService personService;

    //认证登录
    @RequestMapping(value = "checkLogin.do")
    @ResponseBody
    public String checkLogin(Person person , String isMemory, HttpServletResponse response ,HttpServletRequest request){
        String info = personService.checkLogin(person,isMemory,response,request);
        System.out.println("---------info-----------"+isMemory);
        return info;
    }

    //登录成功后跳转成功界面
    @RequestMapping(value = "success.do")
    public String success(HttpSession session){
        session.setAttribute("LOGINTIME",new Date());
        return "person/index";
    }


    //响应首页的右侧欢迎界面
    @RequestMapping(value = "showWelcome.do")
    public String showWelcome(){

        return "person/welcome";
    }

    //退出登录
    @RequestMapping(value = "logout.do",produces = "application/json;charset=utf-8")
    @ResponseBody
    public Person logout(HttpServletRequest request){
        Subject subject = SecurityUtils.getSubject();
        subject.logout();
        Person person = personService.queryCookie(request);
        return person;
    }

    //跳到用户界面
    @RequestMapping(value = "user.do")
    public String user(){
        return "person/user";
    }

    //跳到用户界面
    @RequestMapping(value = "admin.do")
    public String admin(){
        return "person/admin";
    }


    //跳到用户界面
    @RequestMapping(value = "error.do")
    public String error(){
        return "person/error";
    }

}
