package com.hqyj.pojo;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class Employer extends MyPage{
    private Integer id;

    private String empName;

    private String sex;

    private String job;

    private Date updateTime;

    private Integer dId;

    private Deparment dept;

    public Deparment getDept() {
        return dept;
    }

    public void setDept(Deparment dept) {
        this.dept = dept;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getEmpName() {
        return empName;
    }

    public void setEmpName(String empName) {
        this.empName = empName;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getJob() {
        return job;
    }

    public void setJob(String job) {
        this.job = job;
    }

    public String getUpdateTime() {
        if (this.updateTime!=null){
            SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
           return simpleDateFormat.format(this.updateTime);
        }
        return "";
    }

    public void setUpdateTime(String updateTime) throws ParseException {
        if (updateTime!=null){
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date parseTime = simpleDateFormat.parse(updateTime);
        this.updateTime = parseTime;
        }else {
            this.updateTime = new Date();
        }
    }

    public Integer getdId() {
        return dId;
    }

    public void setdId(Integer dId) {
        this.dId = dId;
    }

    @Override
    public String toString() {
        return "Employer{" +
                "id=" + id +
                ", empName='" + empName + '\'' +
                ", sex='" + sex + '\'' +
                ", job='" + job + '\'' +
                ", updateTime=" + updateTime +
                ", dId=" + dId +
                ", dept=" + dept +
                '}'+"\n";
    }
}