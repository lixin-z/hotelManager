package cn.java.controller;

import cn.java.entity.RoomInfo;
import cn.java.service.RoomInfoService;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.util.List;
import java.util.Map;

@Controller
public class RoomController {

    @Autowired
    RoomInfoService roomInfoService;

    /**
     * 分页查询所有的房间信息
     *
     * @param pageNum  当前的页数
     * @param pageSize 每页显示的记录数量
     * @param model
     * @return
     */
    @RequestMapping("/getAllRoomInfo.do")
    public String getHouseInfo(@RequestParam(name = "pageNum", defaultValue = "1") Integer pageNum, @RequestParam(name = "pageSize", defaultValue = "4") Integer pageSize, Model model) {
        List<Map<String, Object>> roomInfo = roomInfoService.getAllRoomNum(pageNum, pageSize);
        PageInfo<Map<String, Object>> pageInfo = new PageInfo<Map<String, Object>>(roomInfo);
        model.addAttribute("pageInfo", pageInfo);
        return "admin/room/houseInfo.jsp";
    }

    /**
     * 根据房间号删除房间
     *
     * @param roomNum 房间号
     * @return
     */
    @RequestMapping("/delRoomByRoomNum.do")
    @ResponseBody
    public boolean delRoomByRoomNum(String roomNum) {
        boolean b = roomInfoService.delRoomByRoomNum(roomNum);
        return b;
    }

    /**
     * 获取房间类型
     *
     * @return 房间类型集合
     */
    @RequestMapping("/getRoomType.do")
    @ResponseBody
    public List<Map<String, Object>> getRoomType() {
        List<Map<String, Object>> roomType = roomInfoService.getRoomType();
        return roomType;
    }

    /**
     * 跳转至添加房间页面
     *
     * @return
     */
    @RequestMapping("/readyAddRoom.do")
    public String readyAddRoom() {
        return "admin/room/addRoom.jsp";
    }

    /**
     * 添加房间动作，从客户端接收房间的具体信息
     *
     * @param roomInfo 房间类
     * @return
     */
    @RequestMapping("/addRoom.do")
    public String addRoom(@Valid RoomInfo roomInfo) {
        boolean b = roomInfoService.addRoom(roomInfo);
        if (b) {
            return "redirect:/getAllRoomInfo.do";
        } else {
            return "admin/room/addRoom.jsp";
        }
    }

    /**
     * 条件搜索房间信息
     *
     * @param type    房间类型、房间状态
     * @param keyWord 搜索的关键字
     * @param model
     * @return
     */
    @RequestMapping("/getHouseInfoByCondition.do")
    public String getHouseInfoByCondition(String type, String keyWord, Model model) {
        System.out.println(keyWord);
        List<Map<String, Object>> roomInfo = roomInfoService.getRoomInfoByCondition(type, keyWord);
        model.addAttribute("roomInfo", roomInfo);
        return "admin/room/houseInfo_condition.jsp";
    }

    /**
     * 根据得到的房间号，批量删除房间
     *
     * @param numAttr
     * @return
     */
    @RequestMapping("/batDelRoom.do")
    public
    @ResponseBody
    int batDelRoom(String numAttr) {
        // 去掉最后的逗号
        numAttr = numAttr.substring(0, numAttr.length() - 1);
        int b = roomInfoService.batDel(numAttr);
        return b;
    }

    /**
     * 准备修改房间信息，获取所有房间号之后跳转至修改房间界面
     *
     * @param session
     * @return
     */
    @RequestMapping("/readyModifyRoomInfo.do")
    public String readyModifyRoomInfo(HttpSession session) {
        List<Map<String, Object>> roomInfo = roomInfoService.getAllRoomNumInfo();
        session.setAttribute("roomInfo", roomInfo);
        return "admin/room/houseManage.jsp";
    }

    /**
     * 修改房间信息动作
     *
     * @param oldRoomNum 原先的房间号
     * @param roomInfo   新的房间信息
     * @param model
     * @return
     */
    @RequestMapping("/updateRoomInfo.do")
    public String updateRoomInfo(String oldRoomNum, @Valid RoomInfo roomInfo, Model model) {
        System.out.println(roomInfo.toString());
        int result = roomInfoService.updateRoomInfo(oldRoomNum, roomInfo);
        // 成功修改
        if (result == 1) {
            return "redirect:/getAllRoomInfo.do";
        }
        // 该房间已经有人入住
        else if (result == 2) {
            model.addAttribute("roomHasOccupy", true);
        } else {
            model.addAttribute("updateFail", true);
        }
        return "admin/room/houseManage.jsp";
    }

    /**
     * 判断前端传来的房间号是否已经存在于数据库了
     *
     * @param roomNum 房间号
     * @return
     */
    @RequestMapping("/isRoomNumExist.do")
    @ResponseBody
    public boolean isRoomNumExist(String roomNum) {
        List<Map<String, Object>> allRoomNumInfo = roomInfoService.getAllRoomNumInfo();
        for (Map<String, Object> map : allRoomNumInfo) {
            Object room_num = map.get("room_num");
            // 存在了
            if (room_num.equals(roomNum)) {
                return true;
            }
        }
        return false;
    }

}
