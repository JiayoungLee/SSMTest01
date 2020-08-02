package com.hqyj.controller;

import com.hqyj.pojo.Deparment;
import com.hqyj.pojo.Employer;
import com.hqyj.pojo.Person;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * author  Jayoung
 * createDate  2020/7/27 0027 11:27
 * version 1.0
 */
@Controller
@RequestMapping("tc")
public class TestController {

    //测试页面传数组到控制层
    @RequestMapping("arrayPage.do")
    public String demo1() {
        return "arrayPage";
    }

    //注解RequestMapping中produces属性可以设置返回数据的类型以及编码
    @RequestMapping(value = "arrayTest.do", produces = "application/text;charset=utf-8")
    @ResponseBody
    public String arrayTest(String[] stu) {
        for (String s:stu){
            System.out.println(s);
        }
        return "success!";
    }

//    多个或单个对象传到控制层，以json格式
    @RequestMapping("duoGeDuiXiangPage.do")
    public String demo2() {
        return "duoGeDuiXiang";
    }

    //注解RequestMapping中produces属性可以设置返回数据的类型以及编码
    @RequestMapping(value = "duoGeDuiXiang.do", produces = "application/json;charset=utf-8")
    @ResponseBody
    public String duoGeDuiXiang(@RequestBody List<Deparment> depts) {       //@RequestBody只能拿请求体里面的值，所以前台需要用post请求
        System.out.println(depts);
        return "success!";
    }

    //序列化页面
    @RequestMapping("serializePage.do")
    public String serializePage() {
        return "testSerialize";
    }
    //序列化操作     注解RequestMapping中produces属性可以设置返回数据的类型以及编码
    @RequestMapping(value = "serialize.do",produces = "application/text;charset=utf-8")
    @ResponseBody
    public String serialize(Person person) {
        System.out.println(person);
        return "success!";
    }

    //ajax跨域访问
    @RequestMapping(value = "crossDomain.do", produces = "application/text;charset=utf-8")
    @ResponseBody
    public String crossDomain(HttpServletResponse resp,String [] stu){
        //允许所有域名访问该资源
        resp.setHeader("Access-Control-Allow-Origin","*");
        /*resp.setHeader("Access-Control-Allow-Methods", "POST, GET, OPTIONS, DELETE");
        resp.setHeader("Access-Control-Max-Age", "3600");*/
        resp.setHeader("Access-Control-Allow-Headers", "x-requested-with,Authorization");
        /*  resp.setHeader("Access-Control-Allow-Credentials","true");*/

        for (String s:stu){
            System.out.println(s);
        }

        return "success";
    }

    //测试shiro
    @RequestMapping("firstShiro.do")
    public String firsShiro(){
        return "person/login";
    }
}
