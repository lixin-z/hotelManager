package cn.java.entity;

import java.io.Serializable;
import java.util.List;

public class OneMenu implements Serializable {

    private static final long serialVersionUID = -4406462964161226997L;
    // 一级菜单的主键
    private Long id;

    // 一级菜单的名称
    private String oneName;

    private List<TwoMenu> twoMenuList;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getOneName() {
        return oneName;
    }

    public void setOneName(String oneName) {
        this.oneName = oneName;
    }

    public List<TwoMenu> getTwoMenuList() {
        return twoMenuList;
    }

    @Override
    public String toString() {
        return "OneMenu{" +
                "id=" + id +
                ", oneName='" + oneName + '\'' +
                ", twoMenuList=" + twoMenuList.toString() +
                '}';
    }

    public void setTwoMenuList(List<TwoMenu> twoMenuList) {
        this.twoMenuList = twoMenuList;
    }
}
