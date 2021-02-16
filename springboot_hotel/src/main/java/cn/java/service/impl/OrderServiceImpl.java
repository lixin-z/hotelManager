package cn.java.service.impl;

import cn.java.entity.Order;
import cn.java.mapper.OrderMapper;
import cn.java.service.OrderService;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.SimpleDateFormat;
import java.util.*;

@Service
@Transactional(readOnly = false)
public class OrderServiceImpl implements OrderService {
    @Autowired
    private OrderMapper orderMapper;

    /**
     * 获取所有已入住信息
     */
    @Override
    @Transactional(readOnly = true)
    public List<Map<String, Object>> getAllOccupyRoom() {
        return orderMapper.selectAllOccupyRoom();
    }

    /**
     * 添加订单
     *
     * @param order
     * @return
     */
    @Override
    @Transactional(readOnly = false)
    public boolean addOrder(Order order) {
        // 生成订单的编号
        String uuid = UUID.randomUUID().toString();
        order.setOrderNum(uuid);
        // 生成订单创建时间
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyy-MM-dd HH:mm:ss");
        String createDate = simpleDateFormat.format(new Date());
        order.setCreateDate(createDate);
        return orderMapper.addOrder(order) >= 1;
    }

    @Override
    public List<Map<String, Object>> getAllOrderInfo(Integer pageNum, Integer pageSize) {
        // 分页
        PageHelper.startPage(pageNum, pageSize);
        return orderMapper.selectAllOrderInfo(pageNum, pageSize);
    }

    /**
     * 条件搜索
     *
     * @param type
     * @param keyWord
     * @return
     */
    @Override
    public List<Map<String, Object>> getOrderInfoByCondition(String type, String keyWord) {
        return orderMapper.selectOrderInfoByCondition(type, keyWord);
    }

    @Override
    public boolean delOrderInfo(String orderNum) {
        return orderMapper.delOrderInfo(orderNum);
    }

    @Override
    public boolean peyOrder(String orderNum) {
        return orderMapper.peyOrder(orderNum);
    }

    /**
     * 批量删除订单
     *
     * @param numAttr
     * @return
     */
    @Override
    public boolean batdel(String numAttr) {
        // 去掉最后一个逗号
        numAttr = numAttr.substring(0, numAttr.length() - 1);
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("numAttr", numAttr);
        Integer result = orderMapper.batdel(map);
        return result >= 1;
    }
}
