package cn.java.mapper;

import cn.java.entity.Order;
import org.apache.ibatis.annotations.*;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Mapper
public interface OrderMapper {

    @Transactional(readOnly = true)
    @Select("SELECT room_num, id FROM rooms WHERE room_status = '1'")
    List<Map<String, Object>> selectAllOccupyRoom();

    /**
     * 添加订单
     *
     * @param order
     * @return
     */
    @Insert("INSERT INTO orders VALUES(NULL, #{orderNum}, #{money}, #{orderStatus}, #{roomId}, #{createDate}, '1', #{consumeName}, #{consumeCount})")
    int addOrder(Order order);

    @Select("SELECT o.order_num, rm.room_num, iri.customer_name, o.consume_name, o.consume_count, o.order_money, o.order_status, o.create_date FROM orders o INNER JOIN in_room_info iri ON o.room_id = iri.room_id INNER JOIN rooms rm ON rm.id = o.room_id WHERE o.not_del = '1'")
    List<Map<String, Object>> selectAllOrderInfo(Integer pageNum, Integer pageSize);

    /**
     * 根据条件查询订单
     *
     * @param type    条件类型，订单编号、客人姓名、房间号
     * @param keyWord 关键字
     * @return
     */
    List<Map<String, Object>> selectOrderInfoByCondition(String type, String keyWord);

    /**
     * 删除订单
     *
     * @param orderNum
     * @return
     */
    @Delete("UPDATE orders SET not_del = '0' WHERE order_num = #{arg0}")
    boolean delOrderInfo(String orderNum);

    /**
     * 结算订单
     *
     * @param orderNum
     * @return
     */
    @Update("UPDATE orders SET order_status = '1' WHERE order_num = #{arg0}")
    boolean peyOrder(String orderNum);

    /**
     * 批量删除
     */
    Integer batdel(Map<String, Object> map);
}
