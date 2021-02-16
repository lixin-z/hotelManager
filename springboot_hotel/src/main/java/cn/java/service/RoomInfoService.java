package cn.java.service;

import cn.java.entity.RoomInfo;

import java.util.List;
import java.util.Map;

public interface RoomInfoService {

    List<Map<String, Object>> getAllRoomNum(Integer pageNum, Integer pageSize);

    boolean delRoomByRoomNum(String roomNum);

    List<Map<String, Object>> getRoomType();

    boolean addRoom(RoomInfo roomInfo);

    List<Map<String, Object>> getRoomInfoByCondition(String type, String keyWord);

    int batDel(String idAttr);

    List<Map<String, Object>> getAllRoomNumInfo();

    int updateRoomInfo(String oldRoomNum, RoomInfo roomInfo);
}
