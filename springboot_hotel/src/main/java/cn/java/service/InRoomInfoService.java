package cn.java.service;

import cn.java.entity.InRoomInfo;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

public interface InRoomInfoService {
    /* 分页查询入住信息 */
    List<Map<String, Object>> getAllInRoomInfo(Integer pageNum, Integer pageSize);

    /* 按照条件查询入住信息 */
    List<Map<String, Object>> getInRoomInfoByCondition(String type, String keyWord);

    /* 删除入住信息 */
    boolean delInfoById(Long id);

    /* 批量删除 */
    boolean batDel(String idAttr);

    /* 获取所有空闲房间 */
    List<Map<String, Object>> getAllFreeRoom();

    /* 添加入住信息 */
    boolean addInRoomInfo(InRoomInfo inRoomInfo);

    /* 获取所有已住房间 */
    List<Map<String, Object>> getOccupyRooms();

    /* 根据房间id查询入住信息 */
    Map<String, Object> getInRoomInfoByRoomId(long roomId);

    /* 根据房间id查询单价 */
    @Transactional(readOnly = true)
    Float getPriceByRoomId(Long roomId);

    /* 根据房间id删除入住信息 */
    boolean delInfoByRoomId(Long roomId);

    /* 获取其他未结账的消费 */
    String getOtherConsume(Long roomId);

    /* 根据房间id获取消费记录 */
    List<Map<String, Object>> getConsumeInfo(Long roomId);

    /* 获取所有消费记录 */
    List<Map<String, Object>> getAllConsumeInfo();
}
