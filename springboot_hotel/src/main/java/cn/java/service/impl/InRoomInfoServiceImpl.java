package cn.java.service.impl;

import cn.java.entity.InRoomInfo;
import cn.java.mapper.InRoomInfoMapper;
import cn.java.service.InRoomInfoService;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Transactional(readOnly = false)
public class InRoomInfoServiceImpl implements InRoomInfoService {

    @Autowired
    private InRoomInfoMapper inRoomInfoMapper;

    @Override
    public List<Map<String, Object>> getAllInRoomInfo(Integer pageNum, Integer pageSize) {
        // 分页
        PageHelper.startPage(pageNum, pageSize);
        return inRoomInfoMapper.selectAllInRoomInfo(pageNum, pageSize);
    }

    /**
     * 根据条件查询入住信息
     *
     * @return
     */
    @Override
    public List<Map<String, Object>> getInRoomInfoByCondition(String type, String keyWord) {
        return inRoomInfoMapper.selectInRoomInfoByCondition(type, keyWord);
    }

    /**
     * 删除入住信息
     *
     * @param id
     * @return
     */
    @Override
    public boolean delInfoById(Long id) {
        int flag = inRoomInfoMapper.delInfoById(id);
        if (flag >= 1) {
            // 获取房间号
            long roomId = inRoomInfoMapper.getRoomIdFromInfoId(id);
            // 释放房间
            return inRoomInfoMapper.setRoomStatusToNotOccupyById(roomId);
        }
        return false;
    }

    /* 批量删除 */
    @Override
    public boolean batDel(String idAttr) {
        // 去掉最后的逗号
        idAttr = idAttr.substring(0, idAttr.length() - 1);
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("idAttr", idAttr);
        // 根据入住信息id找到房间id
        List<Long> roomIds = inRoomInfoMapper.getRoomIdsByRoomInfoIds(map);
        // 设置入住信息状态为0 == 删除入住信息
        int batDelRoomInfo = inRoomInfoMapper.batDel(map);
        String roomIdString = roomIds.toString();
        // 去除list.toString的前后中括号，放进map
        map.put("roomIds", roomIdString.substring(1, roomIdString.length() - 1));
        // 设置房间状态为可入住（0）
        int setRoomStatus = inRoomInfoMapper.batSetRoomStatus(map);
        return batDelRoomInfo >= 1 && setRoomStatus >= 1;
    }

    /**
     * 获取所有空闲房间
     *
     * @return
     */
    @Override
    public List<Map<String, Object>> getAllFreeRoom() {
        return inRoomInfoMapper.selectAllFreeRoom();
    }

    /**
     * 添加入住记录
     *
     * @param inRoomInfo
     * @return
     */
    @Override
    public boolean addInRoomInfo(InRoomInfo inRoomInfo) {
        // 根据房间编号获取id
        Long roomId = inRoomInfoMapper.selectRoomIdByNum(inRoomInfo.getRoomNum());
        inRoomInfo.setRoomId(roomId);
        inRoomInfo.setStatus("1");
        boolean addInRoomInfoSuccess = inRoomInfoMapper.addInRoomInfo(inRoomInfo);
        if (addInRoomInfoSuccess) {
            // 设置房间已被住
            inRoomInfoMapper.setRoomStatusToOccupyById(roomId);
        }
        return addInRoomInfoSuccess;
    }

    @Transactional(readOnly = true)
    /* 获取所有已住房间 */
    @Override
    public List<Map<String, Object>> getOccupyRooms() {
        return inRoomInfoMapper.selectOccupyRoom();
    }

    @Transactional(readOnly = true)
    @Override
    /* 根据房间id查询入住信息 */
    public Map<String, Object> getInRoomInfoByRoomId(long roomId) {
        return inRoomInfoMapper.selectInRoomInfoByRoomId(roomId);
    }

    @Transactional(readOnly = true)
    @Override
    public Float getPriceByRoomId(Long roomId) {
        return inRoomInfoMapper.selectPriceByRoomId(roomId);
    }

    @Transactional(readOnly = false)
    @Override
    public boolean delInfoByRoomId(Long roomId) {
        // 删除入住信息并且设置房间为空
        return inRoomInfoMapper.delInfoByRoomId(roomId) && inRoomInfoMapper.setRoomStatusToNotOccupyById(roomId);
    }

    @Override
    public String getOtherConsume(Long roomId) {
        return inRoomInfoMapper.getOtherConsume(roomId);
    }

    @Override
    public List<Map<String, Object>> getConsumeInfo(Long roomId) {
        return inRoomInfoMapper.selectConsumeInfo(roomId);
    }

    @Override
    public List<Map<String, Object>> getAllConsumeInfo() {
        return inRoomInfoMapper.selectAllConsumeInfo();
    }
}
