package cn.java.mapper;

import cn.java.entity.VipInfo;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;
import java.util.Map;

public interface VipMapper {
    /**
     * 获取所有VIP信息
     *
     * @return
     */
    @Select("SELECT vip_num, vip_name, gender, idcard, phone, vip_rate, create_date, content FROM vip WHERE not_del = '1'")
    List<Map<String, Object>> selectVipInfo(Integer pageNum, Integer pageSize);

    /**
     * 删除VIP信息
     *
     * @param vipNum
     * @return
     */
    @Update("UPDATE vip SET not_del = '0' WHERE vip_num = #{arg0}")
    boolean delVip(String vipNum);

    /**
     * 批量删除VIP信息
     *
     * @param numsAttr
     * @return
     */
    Integer batDelVipInfo(@Param("numsAttr") String numsAttr);

    List<Map<String, Object>> selectVipInfoByCondition(String type, String keyWord);

    /**
     * 添加VIP信息
     *
     * @param vipInfo
     * @return
     */
    @Insert("INSERT INTO vip VALUES(NULL, #{vipNum}, #{vipName}, #{vipRate}, #{idcard}, #{phone}, #{createDate}, #{gender}, '1', #{content})")
    boolean addVipInfo(VipInfo vipInfo);

    @Select("SELECT vip_name FROM vip WHERE not_del = '1'")
    List<Map<String, Object>> selectAllVipNames();

    @Select("SELECT * FROM vip WHERE vip_name = #{arg0} AND not_del = '1' LIMIT 1")
    Map<String, Object> selectVipInfoByName(String vipName);

    @Select("SELECT rate FROM vip_rates")
    List<Map<String, Object>> selectAllRate();

    @Update("UPDATE vip SET vip_name = #{vipName}, vip_rate = #{vipRate}, idcard = #{idcard}, phone = #{phone}, gender = #{gender}, content = #{content} WHERE vip_num = #{vipNum}")
    boolean uodateVipInfo(VipInfo vipInfo);

    @Select("SELECT * FROM vip WHERE vip_num = #{arg0}")
    Map<String, Object> selectVipInfoByNum(String vipNum);
}
