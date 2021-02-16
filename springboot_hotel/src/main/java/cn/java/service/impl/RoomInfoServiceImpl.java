package cn.java.service.impl;

import cn.java.entity.RoomInfo;
import cn.java.mapper.InRoomInfoMapper;
import cn.java.mapper.RoomInfoMapper;
import cn.java.service.RoomInfoService;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class RoomInfoServiceImpl implements RoomInfoService {

    @Autowired
    private RoomInfoMapper roomInfoMapper;
    @Autowired
    private InRoomInfoMapper inRoomInfoMapper;

    @Override
    public List<Map<String, Object>> getAllRoomNum(Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        return roomInfoMapper.selectAllRoomNum(pageNum, pageSize);
    }

    @Override
    public boolean delRoomByRoomNum(String roomNum) {
        return roomInfoMapper.delRoomByRoomNum(roomNum);
    }

    @Override
    public List<Map<String, Object>> getRoomType() {
        return roomInfoMapper.selectRoomType();
    }

    @Override
    public boolean addRoom(RoomInfo roomInfo) {
        return roomInfoMapper.addRoom(roomInfo);
    }

    @Override
    public List<Map<String, Object>> getRoomInfoByCondition(String type, String keyWord) {
        return roomInfoMapper.selectRoomInfoByCondition(type, keyWord);
    }

    @Override
    public int batDel(String idAttr) {
        // 判断是否有客人入住
        boolean flag = false;
        List<Map<String, Object>> list = inRoomInfoMapper.selectOccupyRoom();
        for (int i = 0; i < list.size(); i++) {
            Map<String, Object> map = list.get(i);
            String num = (String) map.get("room_num");
            if (idAttr.contains(num)) {
                // 已经有人住了
                flag = true;
                break;
            }
        }
        if (flag) {
            return 2;
        } else {
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("idAttr", idAttr);
            roomInfoMapper.batDel(map);
            return 1;
        }
    }

    @Override
    public List<Map<String, Object>> getAllRoomNumInfo() {
        return roomInfoMapper.selectAllRoomNumInfo();
    }

    @Override
    public int updateRoomInfo(String oldRoomNum, RoomInfo roomInfo) {
        // 获取所有已经入住的房间
        List<Map<String, Object>> list = inRoomInfoMapper.selectOccupyRoom();
        for (int i = 0; i < list.size(); i++) {
            Map<String, Object> map = list.get(i);
            String num = (String) map.get("room_num");
            // 要修改的房间是已经有人入住的
            if (num.equals(oldRoomNum)) {
                return 2;
            }
        }
        int afeect = roomInfoMapper.updateRoomInfo(oldRoomNum, roomInfo);
        return afeect == 1 ? 1 : 0;
    }
}
