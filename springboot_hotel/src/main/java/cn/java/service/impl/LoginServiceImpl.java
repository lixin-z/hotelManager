package cn.java.service.impl;

import cn.java.entity.OneMenu;
import cn.java.mapper.LoginMapper;
import cn.java.service.LoginService;
import cn.java.utils.MD5;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional(readOnly = false)
public class LoginServiceImpl implements LoginService {

    @Autowired
    private LoginMapper loginMapper;

    /**
     * 在service层进行字符串校验
     *
     * @param username 用户名
     * @param pwd      密码
     * @return 用户ID，没有该用户则返回null
     */
    @Transactional(readOnly = true)
    @Override
    public Long isLoginSuccess(String username, String pwd) throws Exception {
        // 防止用户是黑客
        if (username == null || pwd == null) return null;
        // 首先校验用户名与密码是否满足格式要求
        String regex1 = "\\w{3,12}";
        String regex2 = "\\w{6,12}";
        boolean flag1 = username.matches(regex1);
        boolean flag2 = pwd.matches(regex2);
        if (flag1 && flag2) {
            // 然后将密码进行加密，加密后传递给Mapper
            String miWenPwd = MD5.finalMD5(pwd);
            return loginMapper.login(username, miWenPwd);
        }
        return null;
    }

    /**
     * 获取所有菜单
     *
     * @return
     */
    @Override
    public List<OneMenu> getMenus(Long id) {
        return loginMapper.selectMenusByUserId(id);
    }


}
