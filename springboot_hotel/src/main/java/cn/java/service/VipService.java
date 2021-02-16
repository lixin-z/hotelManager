package cn.java.service;

import cn.java.entity.VipInfo;

import java.util.List;
import java.util.Map;

public interface VipService {
    /* 获取所有VIP信息 */
    List<Map<String, Object>> getVipInfo(Integer pageNum, Integer pageSize);

    /**
     * 根据会员编号删除会员
     *
     * @param vipNum
     * @return
     */
    boolean delVip(String vipNum);

    /**
     * 根据会员编号批量删除会员
     *
     * @param numsAttr
     * @return
     */
    boolean batDelVipInfo(String numsAttr);

    /**
     * 条件查询VIP信息
     *
     * @param type
     * @param keyWord
     * @return
     */
    List<Map<String, Object>> getVipInfoByCondition(String type, String keyWord);

    boolean addVipInfo(VipInfo vipInfo);

    List<Map<String, Object>> getAllVipNames();

    Map<String, Object> getVipInfoByName(String vipName);

    List<Map<String, Object>> getAllRate();

    boolean updateVipInfo(VipInfo vipInfo);

    Map<String, Object> getVipInfoByNum(String vipNum);
}
