package cn.java.service;

import cn.java.entity.Order;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

public interface OrderService {

    /* 获取所有已入住的房间 */
    List<Map<String, Object>> getAllOccupyRoom();


    /**
     * 添加订单
     *
     * @param order
     * @return
     */
    @Transactional(readOnly = false)
    boolean addOrder(Order order);

    @Transactional(readOnly = true)
    List<Map<String, Object>> getAllOrderInfo(Integer pageNum, Integer pageSize);

    List<Map<String, Object>> getOrderInfoByCondition(String type, String keyWord);

    boolean delOrderInfo(String orderNum);

    boolean peyOrder(String orderNum);

    boolean batdel(String numAttr);
}
