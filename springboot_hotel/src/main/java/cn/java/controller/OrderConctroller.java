package cn.java.controller;

import cn.java.entity.Order;
import cn.java.service.OrderService;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class OrderConctroller {
    @Autowired
    private OrderService orderService;

    /**
     * 跳转到添加订单的界面
     * 在方法内部获取所有已经入住的房间信息（房间号，房间id）
     *
     * @param session
     * @return
     */
    @RequestMapping("/readyAddOrder.do")
    public String getAllOccupyRoom(HttpSession session) {
        List<Map<String, Object>> allOccupyRoom = orderService.getAllOccupyRoom();
        session.setAttribute("allOccupyRoom", allOccupyRoom);
        session.setAttribute("errorMap", null);
        return "admin/order/addOrder.jsp";
    }

    /**
     * 添加订单动作
     *
     * @param order         订单信息
     * @param bindingResult 验证数据格式的错误集
     * @param session
     * @return
     */
    @RequestMapping("/addOrder.do")
    public String addOrder(@Valid Order order, BindingResult bindingResult, HttpSession session) {
        // 是否有数据格式错误
        boolean hasErrors = bindingResult.hasErrors();
        if (hasErrors) {
            // 构建一个Map集合，封装错误信息
            Map<String, Object> errorMap = new HashMap<String, Object>();
            // 获取所有的属性错误
            List<FieldError> fieldErrors = bindingResult.getFieldErrors();
            for (FieldError fieldError : fieldErrors) {
                // 属性名
                String fieldName = fieldError.getField();
                // 获取默认的错误信息
                String defaultMessage = fieldError.getDefaultMessage();
                errorMap.put(fieldName, defaultMessage);
            }
            session.setAttribute("errorMap", errorMap);
            session.setAttribute("order", order);
            return "redirect:/readyAddOrder.do";
        } else {
            // 调用业务层，将信息存储到数据库
            boolean result = orderService.addOrder(order);
            return result ? "redirect:/getOrderInfo.do" : "redirect:/readyAddOrder.do";
        }
    }

    /**
     * 分页查询订单信息
     *
     * @param model
     * @param pageNum  当前的页数
     * @param pageSize 每页显示的数据条数
     * @return
     */
    @RequestMapping("/getOrderInfo.do")
    public String getOrderInfo(Model model, @RequestParam(name = "pageNum", defaultValue = "1") Integer pageNum, @RequestParam(name = "pageSize", defaultValue = "4") Integer pageSize) {
        // 分页之后返回的数据
        List<Map<String, Object>> orderInfo = orderService.getAllOrderInfo(pageNum, pageSize);
        // 将infoList封装到pageinfo工具类中
        PageInfo<Map<String, Object>> pageInfo = new PageInfo<Map<String, Object>>(orderInfo);
        model.addAttribute("pageInfo", pageInfo);
        return "admin/order/orderInfo.jsp";
    }

    /**
     * 条件搜索订单信息
     *
     * @param type    按照房间号等条件类型
     * @param keyWord 搜索的关键字
     * @param model
     * @return
     */
    @RequestMapping("/getOrderInfoByCondition.do")
    public String getOrderInfoByCondition(String type, String keyWord, Model model) {
        keyWord = keyWord.trim();
        List<Map<String, Object>> orderInfoList = orderService.getOrderInfoByCondition(type, keyWord);
        model.addAttribute("orderInfoList", orderInfoList);
        return "admin/order/orderInfo_condition.jsp";
    }

    /**
     * 删除订单信息
     *
     * @param orderNum 订单编号
     * @return
     */
    @RequestMapping("/delOrderInfo.do")
    public @ResponseBody
    boolean delOrderInfo(String orderNum) {
        return orderService.delOrderInfo(orderNum);
    }

    /**
     * 结算订单
     *
     * @param orderNum 订单编号
     * @return
     */
    @RequestMapping("/peyOrder.do")
    public @ResponseBody
    boolean peyOrder(String orderNum) {
        return orderService.peyOrder(orderNum);
    }

    /**
     * 批量删除
     *
     * @param numAttr
     * @return
     */
    @RequestMapping("/batdel.do")
    public @ResponseBody
    boolean batdel(String numAttr) {
        return orderService.batdel(numAttr);
    }

}
