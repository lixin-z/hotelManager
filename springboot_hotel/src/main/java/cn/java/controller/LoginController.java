package cn.java.controller;

import cn.java.entity.OneMenu;
import cn.java.service.LoginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class LoginController {

    @Autowired
    private LoginService loginService;

    /**
     * @param username 从jsp接收
     * @param pwd      从jsp接收
     * @return 相应页面
     */
    @RequestMapping("/login.do")
    public String login(String username, String pwd, HttpSession session) throws Exception {

        // 调用业务方法
        Long id = loginService.isLoginSuccess(username, pwd);
        // 根据业务方法返回的结果，跳转相应的页面
        if (id != null) {
            // 成功登录
            session.setAttribute("username", username);
            // 获取菜单
            List<OneMenu> menus = loginService.getMenus(id);
            session.setAttribute("menus", menus);
            return "redirect:/pages/admin/index.jsp";
        } else {
            // 登录失败
            return "admin/login.jsp";
        }
    }

    /**
     * 注销
     *
     * @param session
     * @return
     */
    @RequestMapping("/logout.do")
    public String logout(HttpSession session) {
        session.setAttribute("username", null);
        return "admin/login.jsp";
    }

}
