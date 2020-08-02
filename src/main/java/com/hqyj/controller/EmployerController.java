package com.hqyj.controller;

import com.hqyj.pojo.Deparment;
import com.hqyj.pojo.Employer;
import com.hqyj.service.DepartmentService;
import com.hqyj.service.EmployerService;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

/**
 * author  Jayoung
 * createDate  2020/7/20 0020 14:40
 * version 1.0
 */
@Controller
@RequestMapping("emp")
public class EmployerController {
    @Autowired
    private EmployerService service;
    @Autowired
    private DepartmentService departmentService;

    @RequestMapping("list.do")
    public String list(ModelMap map, Employer emp) {
        HashMap<String, Object> listMap = service.selectByPage(emp);
        map.addAttribute("data", listMap);
        map.addAttribute("empName", emp.getEmpName());
        map.addAttribute("sex", emp.getSex());

        return "emp/empList";
    }

    @RequestMapping(value = "update.do", method = RequestMethod.GET)
    public String updatePage(@RequestParam int id, Model model) {
        Employer employer = service.selectByPrimaryKey(id);
        List<Deparment> deparments = departmentService.selectAllDept();
        //System.out.println("-----------empName----------"+employer.getEmpName());
        model.addAttribute("employer", employer);
        model.addAttribute("deparments", deparments);
        return "emp/empUpdate";
    }

    @RequestMapping(value = "update.do", method = RequestMethod.POST)
    public String update(Model model, Employer employer) {
        System.out.println("---------修改拿到的dId----------" + employer.getdId());
        service.updateByEmployer(employer);
        return "redirect:list.do";
    }

    @RequestMapping(value = "delete.do", method = RequestMethod.GET)
    public String delete(@RequestParam int id) {
        System.out.println("-----id------" + id);
        service.deleteByPrimaryKey(id);
        return "redirect:list.do";
    }

    @RequestMapping(value = "add.do", method = RequestMethod.GET)
    public String addPage(Model model) {
        List<Deparment> deparments = departmentService.selectAllDept();
        model.addAttribute("deparments", deparments);
        model.addAttribute(new Employer());
        return "emp/empAdd";
    }

    @RequestMapping(value = "add.do", method = RequestMethod.POST)
    public String add(Employer employer, Model model) {
        int i = service.insert(employer);
        return "redirect:list.do";
    }

    //ajax列表
    @RequestMapping("listAjaxPage.do")
    public String listAjax() {
        return "emp/empAjax";
    }

    //ajax请求
    @RequestMapping("listAjax.do ")
    @ResponseBody
    public HashMap<String, Object> ajax(Employer employer) {
        List<Deparment> deparments = departmentService.selectAllDept();
        HashMap<String, Object> map = service.selectByPage(employer);
        map.put("dept", deparments);
        return map;
    }

    @RequestMapping("updateAjax.do")
    @ResponseBody
    public HashMap update(Employer employer) {
        System.out.println("-----------employer----------" + employer.toString());
        HashMap map = new HashMap();
        if (service.updateByEmployer(employer) > 0) {
            map.put("info", "修改成功");
        } else {
            map.put("info", "修改失败");
        }
        return map;
    }

    @RequestMapping("addAjax.do")
    @ResponseBody
    public HashMap add(Employer employer) {
        HashMap map = new HashMap();
        if (service.insert(employer) > 0) {
            map.put("info", "添加成功");
        } else {
            map.put("info", "添加失败");
        }
        return map;
    }

    @RequestMapping("deleteAjax.do")
    @ResponseBody
    public HashMap delete1(@RequestParam int id) {
        HashMap map = new HashMap();
        if (service.deleteByPrimaryKey(id) > 0) {
            map.put("info", "删除成功");
        } else {
            map.put("info", "删除失败");
        }
        return map;
    }

    @RequestMapping("delAllAjaxPage.do")
    @ResponseBody
    public HashMap delAll(@RequestParam("ids") String ids) {
        String[] splitId = ids.split(",");
        System.out.println("-------------" + splitId[1] + "----------------");
        List<String> list = Arrays.asList(splitId);

        HashMap map = new HashMap();
        if (service.deleteAll(list) > 0) {
            map.put("info", "批量删除成功");
        } else {
            map.put("info", "批量删除失败");
        }
        return map;
    }

    //ajax列表
    @RequestMapping("fileUploadPage.do")
    public String fileUploadPage() {
        return "emp/fileupload";
    }

    @RequestMapping(value = "fileUpload.do", method = RequestMethod.POST)
    public String upload(@RequestParam("file") MultipartFile[] file, HttpServletRequest request) {
        //拿到文件上传目录
        String filePath = request.getSession().getServletContext().getRealPath("upload");
        System.err.println("-----------filePath---------" + filePath);
        //遍历文件对象数组，取出文件的全名
        if (null != file && file.length > 0) {
            try {
                for (int i = 0; i < file.length; i++) {
                    //取出每一个文件对象
                    MultipartFile f = file[i];
                    System.err.println("-----文件名-------" + f.getOriginalFilename());

                    //创建文件对象
                    File ff = new File("" + filePath + "/" + f.getOriginalFilename());
                    //判断目标目录是否存在
                    if(!ff.isDirectory()){
                        //创建目录
                        ff.mkdirs();
                    }
                    //创建文件
                    f.transferTo(ff);
                }
                request.setAttribute("info", "文件上传成功");
            } catch (IOException e) {
                e.printStackTrace();
                request.setAttribute("info", "文件上传失败");
            }
        }
        return "emp/fileupload";
    }


    @RequestMapping(value = "fileUploadAjax.do",method = RequestMethod.POST)
    @ResponseBody
    public boolean uploadAjax(@RequestParam("file") MultipartFile[] file, HttpServletRequest request) {
        //拿到文件上传目录
        String filePath = request.getSession().getServletContext().getRealPath("upload");
        System.err.println("-----------filePath---------" + filePath);
        //遍历文件对象数组，取出文件的全名
        if (null != file && file.length > 0) {
            try {
                for (int i = 0; i < file.length; i++) {
                    //取出每一个文件对象
                    MultipartFile f = file[i];
                    System.err.println("-------文件名-------" + f.getOriginalFilename());

                    //创建文件对象
                    File ff = new File("" + filePath + "/" + f.getOriginalFilename()+"");
                    //判断目标目录是否存在
                    if(!ff.isDirectory()){
                        //创建目录
                        ff.mkdirs();
                    }
                    //创建文件
                    f.transferTo(ff);
                }
               return true;
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return false;
    }

    //文件下载
    @RequestMapping("downLoad.do")
    public ResponseEntity<byte[]> download(@RequestParam("fileName") String fileName,HttpServletRequest request) throws IOException {
        //找到文件下载目录
        String filePath = request.getSession().getServletContext().getRealPath("upload");
        //创建文件对象
        File f = new File(""+filePath+"/"+fileName+"");
        //创建http头部对象
        HttpHeaders http = new HttpHeaders();
        //设置下载响应头部
        http.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        //解决下载文件名是 乱码 问题
        String downName = new String(fileName.getBytes("utf-8"),"ISO8859-1");
        //下载文件
        http.set("Content-Disposition","attachment;filename="+downName+"");

        return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(f),http, HttpStatus.CREATED);
    }
    @RequestMapping("downLoadPage.do")
    public String downloadPage(){
        return "emp/downLoad";
    }
}
