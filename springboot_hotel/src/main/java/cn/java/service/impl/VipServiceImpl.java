package cn.java.service.impl;

import cn.java.entity.VipInfo;
import cn.java.mapper.VipMapper;
import cn.java.service.VipService;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Service
public class VipServiceImpl implements VipService {

    @Autowired
    private VipMapper vipMapper;

    /**
     * 获取所有VIP信息
     *
     * @return
     */
    @Override
    public List<Map<String, Object>> getVipInfo(Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        return vipMapper.selectVipInfo(pageNum, pageSize);
    }

    @Override
    public boolean delVip(String vipNum) {
        return vipMapper.delVip(vipNum);
    }

    @Override
    public boolean batDelVipInfo(String numsAttr) {
        numsAttr = numsAttr.substring(0, numsAttr.length() - 1);
        return vipMapper.batDelVipInfo(numsAttr) >= 1;
    }

    @Override
    public List<Map<String, Object>> getVipInfoByCondition(String type, String keyWord) {
        return vipMapper.selectVipInfoByCondition(type, keyWord);
    }

    /**
     * 添加会员信息
     *
     * @param vipInfo
     * @return
     */
    @Override
    public boolean addVipInfo(VipInfo vipInfo) {
        // 会员编号
        String vipNum = UUID.randomUUID().toString();
        vipInfo.setVipNum(vipNum);
        // 创建时间
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String createDate = simpleDateFormat.format(new Date());
        vipInfo.setCreateDate(createDate);
        return vipMapper.addVipInfo(vipInfo);
    }

    @Override
    public List<Map<String, Object>> getAllVipNames() {
        return vipMapper.selectAllVipNames();
    }

    @Override
    public Map<String, Object> getVipInfoByName(String vipName) {
        return vipMapper.selectVipInfoByName(vipName);
    }

    @Override
    public List<Map<String, Object>> getAllRate() {
        return vipMapper.selectAllRate();
    }

    /**
     * 更新vip信息
     *
     * @param vipInfo
     * @return
     */
    @Override
    public boolean updateVipInfo(VipInfo vipInfo) {
        return vipMapper.uodateVipInfo(vipInfo);
    }

    @Override
    public Map<String, Object> getVipInfoByNum(String vipNum) {
        return vipMapper.selectVipInfoByNum(vipNum);
    }
}