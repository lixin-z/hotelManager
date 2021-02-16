package cn.java.mapper;

import cn.java.entity.OneMenu;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface LoginMapper {

    @Select("SELECT id FROM system_user WHERE username=#{arg0} AND pwd=#{arg1}")
    Long login(String username, String pwd);

    /* 获取所有菜单 */
    List<OneMenu> selectMenusByUserId(Long id);

}
