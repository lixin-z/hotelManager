package cn.java.entity;

import java.io.Serializable;

public class TwoMenu implements Serializable {
    private static final long serialVersionUID = -8878918871004682441L;
    private String twoName;

    private String twoUrl;

    private Long parent;

    public String getTwoName() {
        return twoName;
    }

    @Override
    public String toString() {
        return "TwoMenu{" +
                "twoName='" + twoName + '\'' +
                ", twoUrl='" + twoUrl + '\'' +
                ", parent=" + parent +
                '}';
    }

    public void setTwoName(String twoName) {
        this.twoName = twoName;
    }

    public String getTwoUrl() {
        return twoUrl;
    }

    public void setTwoUrl(String twoUrl) {
        this.twoUrl = twoUrl;
    }

    public Long getParent() {
        return parent;
    }

    public void setParent(Long parent) {
        this.parent = parent;
    }
}