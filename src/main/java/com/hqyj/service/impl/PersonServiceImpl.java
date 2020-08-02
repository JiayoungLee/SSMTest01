package com.hqyj.service.impl;

import com.hqyj.dao.PersonMapper;
import com.hqyj.pojo.Person;
import com.hqyj.service.PersonService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.servlet.SimpleCookie;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * author  Jayoung
 * createDate  2020/7/28 0028 16:47
 * version 1.0
 */
@Service
public class PersonServiceImpl implements PersonService {
    @Autowired
    private PersonMapper personMapper;

    @Override
    public Person queryCookie(HttpServletRequest request) {
        Person person = new Person();
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie c : cookies) {
                if (c.getName().equals("USERNAME")) {
                    person.setPersonName(c.getValue());
                }
                if (c.getName().equals("PASSWORD")) {
                    System.out.println(c.getValue());
                    person.setPersonPassword(c.getValue().replace(person.getPersonName(), ""));
                }
            }
            return person;
        }
        person.setPersonName("");
        return person;
    }

    @Override
    public Person selectByPersonName(String personName) {
        return personMapper.selectByPersonName(personName);
    }

    @Override
    public String checkLogin(Person person, String isMemory, HttpServletResponse response, HttpServletRequest request) {
        //1.拿到当前用户
        Subject currentSubject = SecurityUtils.getSubject();

        //2.判断当前用户是否被认证，并做相关处理
        if (!currentSubject.isAuthenticated()) {
            //UsernamePasswordToken 命令类 稍后会把保存在里面的账号和密码与shiro里面的身份和凭证 做对比认证
            UsernamePasswordToken uPToken = new UsernamePasswordToken(person.getPersonName(), person.getPersonPassword());
            uPToken.setRememberMe(true);
            try {
                //登陆成功
                //进行认证（因为我们写了自定义的realm类，所以会自动到realm类里面认证）
                currentSubject.login(uPToken);
                currentSubject.getSession().setAttribute("userName", uPToken.getUsername());
                if (isMemory.equals("YES")) {
                    System.out.println("---------YES---------");
                    SimpleCookie simpleCookie1 = new SimpleCookie();

                    simpleCookie1.setName("USERNAME");
                    simpleCookie1.setValue(person.getPersonName());

                    simpleCookie1.setName("PASSWORD");
                    simpleCookie1.setValue(person.getPersonPassword() + person.getPersonName());

                    simpleCookie1.setMaxAge(30 * 24 * 60 * 60);

                    simpleCookie1.saveTo(request, response);

//                    Cookie cookie1 = new Cookie("USERNAME", person.getPersonName());
//                    Cookie cookie2 = new Cookie("PASSWORD", person.getPersonPassword()+person.getPersonName());
//                    cookie1.setMaxAge(30 * 24 * 60 * 60);      //单位是 s
//                    cookie2.setMaxAge(30 * 24 * 60 * 60);
//                    response.addCookie(cookie1);
//                    response.addCookie(cookie2);
                } else {
                    System.out.println("---------NO---------");
//                    Cookie[] cookies = request.getCookies();
                    SimpleCookie simpleCookie = new SimpleCookie();
//                    if (cookies != null) {
//                        for (Cookie c : cookies) {
//                            if (c.getName().equals("USERNAME")) {
                    System.out.println("---------NO-USERNAME--------");
                    simpleCookie.setName("USERNAME");
                    simpleCookie.setValue("");
                    simpleCookie.setMaxAge(30);
                    simpleCookie.saveTo(request, response);
//                            }
//                             if (c.getName().equals("PASSWORD")) {
                    System.out.println("---------NO-PASSWORD--------");
                    simpleCookie.setName("PASSWORD");
                    simpleCookie.setValue("");
                    simpleCookie.setMaxAge(30);
                    simpleCookie.saveTo(request, response);
//                            }
//                        }
                }
//                }
                return "success";
            } catch (AuthenticationException e) {
                //登陆失败
                return "ERROR";
            }
        }
        return null;
    }
}
