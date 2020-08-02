package com.hqyj.controller;

import com.hqyj.pojo.Employer;
import com.hqyj.pojo.Role;
import com.hqyj.pojo.UserInfo;
import com.hqyj.service.RoleService;
import com.hqyj.service.UserInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

/**
 * author  Jayoung
 * createDate  2020/7/21 0021 16:38
 * version 1.0
 */
@Controller
@RequestMapping("user")
public class UserInfoController {
    @Autowired
    private UserInfoService userInfoService;
    @Autowired
    private RoleService roleService;

    @RequestMapping("list.do")
    public String list(UserInfo userInfo, Model model){
        HashMap<String, Object> map = userInfoService.selectByPage(userInfo);
        model.addAttribute("data",map);
        model.addAttribute(userInfo);
        return "user/userList";
    }

    @RequestMapping("update.do")
    public String updatePage(@RequestParam int id,Model model){
        UserInfo userInfo = userInfoService.selectByPrimaryKey(id);
        List<Role> roles = roleService.selectAllRole();
        model.addAttribute("userInfo",userInfo);
        model.addAttribute("roles",roles);
        return "user/userUpdate";
    }

    @RequestMapping(value = "update.do",method = RequestMethod.POST)
    public String update(UserInfo userInfo,Model model){
        int i = userInfoService.updateByPrimaryKey(userInfo);
        return "redirect:list.do";
    }

    @RequestMapping("delete.do")
    public String delete(@RequestParam int id){
        int i = userInfoService.deleteByPrimaryKey(id);
        return "redirect:list.do";
    }

    @RequestMapping("add.do")
    public String addPage(Model model){
        List<Role> roles = roleService.selectAllRole();
        model.addAttribute("roles",roles);
        return "user/userAdd";
    }

    @RequestMapping(value = "add.do",method = RequestMethod.POST)
    public String add(UserInfo userInfo){
        System.out.println("-------userName----------"+userInfo.getUserName());
        int i = userInfoService.insert(userInfo);
        return "redirect:list.do";
    }

    @RequestMapping("listAjaxPage.do")
    public String userListAjaxReq(){
        return "user/userAjax";
    }

    @RequestMapping("listAjax.do")
    @ResponseBody
    public HashMap<String,Object> listAjax(UserInfo userInfo){
        List<Role> rolesList = roleService.selectAllRole();
        HashMap<String, Object> map = userInfoService.selectByPage(userInfo);
        map.put("rolesList",rolesList);
        return map;
    }

    @RequestMapping("updateAjax.do")
    @ResponseBody
    public HashMap updateAjax(UserInfo userInfo){
        HashMap map = new HashMap();
        int i = userInfoService.updateByPrimaryKey(userInfo);
        if(i>0){
            map.put("info","修改成功");
        }else {
            map.put("info","修改失败");
        }
        return map;
    }

    @RequestMapping("addAjax.do")
    @ResponseBody
    public HashMap addAjax(UserInfo userInfo){
        HashMap map = new HashMap();
        if (userInfoService.insert(userInfo)>0){
            map.put("info","添加成功");
        }else {
            map.put("info","添加失败");
        }
        return map;
    }

    @RequestMapping("deleteAjax.do")
    @ResponseBody
    public HashMap deleteAjax(@RequestParam int id){
        HashMap map = new HashMap();
        if (userInfoService.deleteByPrimaryKey(id)>0){
            map.put("info","删除成功");
        }else {
            map.put("info","删除失败");
        }
        return map;
    }

    @RequestMapping("delAllAjaxPage.do")
    @ResponseBody
    public HashMap delAll(@RequestParam("allId") String allId){
        String[] splitId = allId.split(",");
        System.out.println("-------------"+splitId[1]+"----------------");
        List<String> list = Arrays.asList(splitId);

        HashMap map = new HashMap();
        if (userInfoService.deleteAll(list)>0){
            map.put("info","批量删除成功");
        }else {
            map.put("info","批量删除失败");
        }
        return map;
    }
}
