package com.hqyj.pojo;

public class Deparment {
    private Integer id;

    private String dName;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getdName() {
        return dName;
    }

    public void setdName(String dName) {
        this.dName = dName;
    }

    @Override
    public String toString() {
        return "Deparment{" +
                "id=" + id +
                ", dName='" + dName + '\'' +
                '}'+"\n";
    }
}