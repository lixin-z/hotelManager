package cn.java.service;

import cn.java.entity.OneMenu;

import java.util.List;

public interface LoginService {

    Long isLoginSuccess(String username, String pwd) throws Exception;

    List<OneMenu> getMenus(Long id);
}
