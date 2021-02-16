package cn.java.mapper;

import cn.java.entity.InRoomInfo;
import org.apache.ibatis.annotations.*;

import java.util.List;
import java.util.Map;

@Mapper
public interface InRoomInfoMapper {

    /* 分页查询入住信息 */
    List<Map<String, Object>> selectAllInRoomInfo(Integer pageNum, Integer pageSize);

    /* 按照条件查询入住信息 */
    List<Map<String, Object>> selectInRoomInfoByCondition(String type, String keyWord);

    /* 删除入住信息 */
    @Delete("UPDATE in_room_info SET status = '0' WHERE id = #{arg0}")
    int delInfoById(Long id);

    /* 批量删除 */
    @Update("UPDATE in_room_info SET status = '0' WHERE id IN(${idAttr})")
    int batDel(Map<String, Object> map);

    /* 查询所有的空闲房间 */
    @Select("SELECT * FROM rooms WHERE room_status = '0'")
    List<Map<String, Object>> selectAllFreeRoom();

    /* 添加入住信息 */
    @Insert("INSERT INTO in_room_info VALUES(NULL, #{customerName}, #{gender}, #{isVip}, #{idcard}, #{phone}, #{money}, #{createDate}, #{roomId}, #{status})")
    boolean addInRoomInfo(InRoomInfo inRoomInfo);

    /* 根据房间编号查询ID */
    @Select("SELECT id FROM rooms WHERE room_num = #{arg0}")
    Long selectRoomIdByNum(String roomNum);

    /* 根据房间ID设置已入住 */
    @Update("UPDATE rooms SET room_status = '1' WHERE id = #{arg0}")
    boolean setRoomStatusToOccupyById(Long roomId);

    @Select("SELECT room_id FROM in_room_info WHERE id = #{id}")
    long getRoomIdFromInfoId(Long id);

    @Update("UPDATE rooms SET room_status = '0' WHERE id = #{arg0}")
    boolean setRoomStatusToNotOccupyById(long roomId);

    @Select("SELECT room_num, id FROM rooms WHERE room_status = '1'")
    List<Map<String, Object>> selectOccupyRoom();

    @Select("SELECT * FROM in_room_info WHERE room_id = #{arg0} AND status='1' LIMIT 1")
    Map<String, Object> selectInRoomInfoByRoomId(long roomId);

    float selectPriceByRoomId(Long roomId);

    @Delete("UPDATE in_room_info SET status = '0' WHERE room_id = #{arg0}")
    boolean delInfoByRoomId(Long roomId);

    @Select("SELECT room_id FROM in_room_info WHERE id IN (${idAttr}) AND status = '1'")
    List<Long> getRoomIdsByRoomInfoIds(Map<String, Object> map);

    @Update("UPDATE rooms SET room_status = '0' WHERE id IN (${roomIds})")
    int batSetRoomStatus(Map<String, Object> map);

    @Select("SELECT SUM(order_money) FROM orders WHERE room_id = #{arg0} AND order_status = '0' AND not_del = '1'")
    String getOtherConsume(Long roomId);

    @Select("SELECT o.order_num, rm.room_num, iri.customer_name, iri.phone, o.consume_name, o.consume_count, o.order_money, o.order_status FROM orders o INNER JOIN rooms rm ON o.room_id = rm.id AND o.not_del = '1' INNER JOIN in_room_info iri ON o.room_id = iri.room_id AND iri.`status` = '1' WHERE o.room_id = #{arg0}")
    List<Map<String, Object>> selectConsumeInfo(Long roomId);

    @Select("SELECT o.order_num, rm.room_num, iri.customer_name, iri.phone, o.consume_name, o.consume_count, o.order_money, o.order_status FROM orders o INNER JOIN rooms rm ON o.room_id = rm.id AND o.not_del = '1' INNER JOIN in_room_info iri ON o.room_id = iri.room_id AND iri.`status` = '1'")
    List<Map<String, Object>> selectAllConsumeInfo();
}