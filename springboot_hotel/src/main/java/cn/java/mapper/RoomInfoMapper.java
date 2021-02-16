package cn.java.mapper;

import cn.java.entity.RoomInfo;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;
import java.util.Map;

@Mapper
public interface RoomInfoMapper {

    @Select("SELECT rm.room_num, rt.room_type_name, rt.room_price, rm.room_status FROM rooms rm INNER JOIN room_type rt ON rm.room_type_id = rt.id WHERE not_del = '1'")
    List<Map<String, Object>> selectAllRoomNum(Integer pageNum, Integer pageSize);

    @Update("UPDATE rooms SET not_del = '0' WHERE room_num = #{arg0}")
    boolean delRoomByRoomNum(String roomNum);

    @Select("SELECT * FROM room_type")
    List<Map<String, Object>> selectRoomType();

    @Insert("INSERT INTO rooms VALUE(NULL, #{roomNum}, #{roomStatus}, #{roomTypeId}, '1')")
    boolean addRoom(RoomInfo roomInfo);

    List<Map<String, Object>> selectRoomInfoByCondition(String type, String keyWord);

    @Update("UPDATE rooms SET not_del = '0' WHERE room_num IN (${idAttr})")
    boolean batDel(Map<String, Object> map);

    @Select("SELECT room_num FROM rooms WHERE not_del = '1'")
    List<Map<String, Object>> selectAllRoomNumInfo();

    @Update("UPDATE rooms SET room_num = #{arg1.roomNum}, room_status = #{arg1.roomStatus}, room_type_id = #{arg1.roomTypeId} WHERE room_num = #{arg0}")
    int updateRoomInfo(String oldRoomNum, RoomInfo roomInfo);
}
