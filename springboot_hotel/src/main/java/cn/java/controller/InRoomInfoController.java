package cn.java.controller;

import cn.java.entity.InRoomInfo;
import cn.java.service.InRoomInfoService;
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
public class InRoomInfoController {

    @Autowired
    private InRoomInfoService inRoomInfoService;

    /**
     * 入住信息查询
     *
     * @param pageNum  当前页数
     * @param pageSize 每页显示多少条信息
     * @param model
     * @return
     */
    @RequestMapping("/getInRoomInfo.do")
    public String getInRoomInfo(@RequestParam(name = "pageNum", defaultValue = "1") Integer pageNum, @RequestParam(name = "pageSize", defaultValue = "4") Integer pageSize, Model model) {
        // 分页之后返回的数据
        List<Map<String, Object>> inRoomInfoList = inRoomInfoService.getAllInRoomInfo(pageNum, pageSize);
        // 将infoList封装到pageinfo工具类中
        PageInfo<Map<String, Object>> pageInfo = new PageInfo<Map<String, Object>>(inRoomInfoList);
        model.addAttribute("pageInfo", pageInfo);
        return "admin/bill/inroominfo.jsp";
    }

    /**
     * 删除入住信息
     *
     * @param id 根据入住信息的id（主键）删除
     * @return
     */
    @RequestMapping("/delInRoomInfo.do")
    public @ResponseBody
    boolean delRoomInfo(Long id) {
        boolean flag = inRoomInfoService.delInfoById(id);
        return flag;
    }

    /**
     * 按照条件查询入住信息
     *
     * @param type    按照客户名字、房间号等类型进行查找
     * @param keyWord 关键字
     * @return
     */
    @RequestMapping("/getInRoomInfoByCondition.do")
    public String getInRoomInfoByCondition(String type, String keyWord, Model model) {
        // 防止 输入空
        keyWord = keyWord.trim();
        List<Map<String, Object>> inRoomInfoList = inRoomInfoService.getInRoomInfoByCondition(type, keyWord);
        model.addAttribute("inRoomInfoList", inRoomInfoList);
        return "admin/bill/inroominfo_condition.jsp";
    }

    /**
     * 批量删除入住信息
     *
     * @param idAttr id号
     * @return 是否成功删除
     */
    @RequestMapping("/batDelInRoomInfo.do")
    public @ResponseBody
    boolean batDel(String idAttr) {
        boolean result = inRoomInfoService.batDel(idAttr);
        return result;
    }

    /**
     * 获取所有的空闲房间
     *
     * @param model
     * @return
     */
    @RequestMapping("/getAllFreeRoomInfo")
    public String getAllFreeRoomInfo(Model model) {
        List<Map<String, Object>> allFreeRoom = inRoomInfoService.getAllFreeRoom();
        model.addAttribute("allFreeRoom", allFreeRoom);
        return "admin/bill/checkin.jsp";
    }

    /**
     * 添加用户信息
     * 分成两部分进行：1 验证输入的信息是否符合格式 2 添加进入数据库
     *
     * @return
     */
    @RequestMapping("/addInRoomInfo.do")
    public String addInRoomInfo(@Valid InRoomInfo inRoomInfo, BindingResult bindingResult, HttpSession session) {
        boolean flag = bindingResult.hasErrors();
        // 有格式错误
        if (flag) {
            // 将错误信息封装
            Map<String, Object> map = new HashMap<String, Object>();
            List<FieldError> fieldErrors = bindingResult.getFieldErrors();
            for (FieldError fieldError : fieldErrors) {
                // 出现错误的属性
                String field = fieldError.getField();
                // 设定的提示信息
                String defaultMessage = fieldError.getDefaultMessage();
                map.put(field, defaultMessage);
            }
            session.setAttribute("errorMap", map);
            // 用户输入的信息
            session.setAttribute("inRoomInfo", inRoomInfo);
            return "redirect:/getAllFreeRoomInfo";
        }
        // 所有数据格式完全正确
        else {
            // 添加信息
            boolean addInRoomInfoSuccess = inRoomInfoService.addInRoomInfo(inRoomInfo);
            if (addInRoomInfoSuccess) {
                return "redirect:/getInRoomInfo.do";
            } else {
                return "redirect:/getAllFreeRoomInfo";
            }
        }
    }

    /**
     * 退房操作
     */
    @RequestMapping("/out.do")
    public String out(Long roomId) {
//         删除入住信息
        inRoomInfoService.delInfoByRoomId(roomId);
        return "redirect:/getInRoomInfo.do";
    }

    /**
     * 获取所有已经入住的房间信息（房间号，id）
     *
     * @param model
     * @param session
     * @return
     */
    @RequestMapping("/getAllOccupyRoom.do")
    public String getAllOccupyRoom(Model model, HttpSession session) {
        session.setAttribute("isSingleInRoomInfo", false);
        // 获取所有已住房间
        List<Map<String, Object>> roomList = inRoomInfoService.getOccupyRooms();
        model.addAttribute("roomList", roomList);
        return "admin/bill/out.jsp";
    }

    /**
     * 根据房间id查询入住信息
     */
    @RequestMapping("/getInRoomInfoByRoomId.do")
    public @ResponseBody
    Map<String, Object> getInRoomInfoByRoomId(Long roomId) {
        // 获取入住信息
        Map<String, Object> inRoomInfo = inRoomInfoService.getInRoomInfoByRoomId(roomId);
        // 获取房间单价
        float price = inRoomInfoService.getPriceByRoomId(roomId);
        inRoomInfo.put("price", price);
        // 获取未结账的消费金额
        String otherConsume = inRoomInfoService.getOtherConsume(roomId);
        inRoomInfo.put("otherConsume", otherConsume);
        return inRoomInfo;
    }

    /**
     * 在查询界面点击的修改，对单条记录进行修改
     *
     * @param roomId  房间id
     * @param roomNum 房间号
     * @param session
     * @return
     */
    @RequestMapping("/singleOut.do")
    public @ResponseBody
    boolean singleOut(Long roomId, String roomNum, HttpSession session) {
        session.setAttribute("isSingleInRoomInfo", true);
        Map<String, Object> singleInRoomInfo = inRoomInfoService.getInRoomInfoByRoomId(roomId);
        if(singleInRoomInfo.get("create_date")!=null){
            // 转换时间
            singleInRoomInfo.put("create_date", singleInRoomInfo.get("create_date").toString());
        }
        // 获取房间单价
        float price = inRoomInfoService.getPriceByRoomId(roomId);
        singleInRoomInfo.put("singlePrice", price);
        String otherConsume = inRoomInfoService.getOtherConsume(roomId);
        singleInRoomInfo.put("otherConsume", otherConsume);
        session.setAttribute("singleInRoomInfo", singleInRoomInfo);
        session.setAttribute("singleRoomNum", roomNum);
        session.setAttribute("singleRoomId", roomId);
        return true;
    }

    /**
     * 获取消费记录
     *
     * @param model
     * @param session
     * @return
     */
    @RequestMapping("/getConsumeInfo.do")
    public String getConsumeInfo(Model model, HttpSession session) {
        List<Map<String, Object>> occupyRooms = inRoomInfoService.getOccupyRooms();
        model.addAttribute("occupyRooms", occupyRooms);
        List<Map<String, Object>> consumeInfo = inRoomInfoService.getAllConsumeInfo();
        session.setAttribute("consumeInfo", consumeInfo);
        return "admin/bill/consume.jsp";
    }

    /**
     * 根据房间id获取消费记录
     *
     * @param session
     * @param roomId  房间id
     * @param model
     * @return
     */
    @RequestMapping("/getConsumeInfoByRoomId.do")
    public String getConsumeInfoByRoomId(HttpSession session, Long roomId, Model model) {
        List<Map<String, Object>> occupyRooms = inRoomInfoService.getOccupyRooms();
        model.addAttribute("occupyRooms", occupyRooms);
        List<Map<String, Object>> consumeInfo = inRoomInfoService.getConsumeInfo(roomId);
        session.setAttribute("consumeInfo", consumeInfo);
        return "admin/bill/consume.jsp";
    }

}