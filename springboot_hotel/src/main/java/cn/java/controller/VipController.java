package cn.java.controller;

import cn.java.entity.VipInfo;
import cn.java.service.VipService;
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
public class VipController {

    @Autowired
    private VipService vipService;

    @RequestMapping("/getVipInfo.do")
    public String getVipInfo(HttpSession session, @RequestParam(name = "pageNum", defaultValue = "1") Integer pageNum, @RequestParam(name = "pageSize", defaultValue = "4") Integer pageSize) {
        List<Map<String, Object>> vipInfo = vipService.getVipInfo(pageNum, pageSize);
        PageInfo<Map<String, Object>> pageInfo = new PageInfo<Map<String, Object>>(vipInfo);
        session.setAttribute("pageInfo", pageInfo);
        return "admin/vip/vip.jsp";
    }

    @RequestMapping("/delVip.do")
    public @ResponseBody
    boolean delVip(String vipNum) {
        return vipService.delVip(vipNum);
    }

    @RequestMapping("/batDelVipInfo.do")
    public @ResponseBody
    boolean batDelVipInfo(String numsAttr) {
        return vipService.batDelVipInfo(numsAttr);
    }

    @RequestMapping("/getVipInfoByCondition.do")
    public String getVipInfoByCondition(String type, String keyWord, Model model) {
        keyWord = keyWord.trim();
        List<Map<String, Object>> vipInfoList = vipService.getVipInfoByCondition(type, keyWord);
        model.addAttribute("vipInfoList", vipInfoList);
        return "admin/vip/vip_condition.jsp";
    }

    @RequestMapping("/readyAddVipInfo.do")
    public String readyAddVipInfo() {
        return "admin/vip/addvip.jsp";
    }

    @RequestMapping("/addVipInfo.do")
    public String addVipInfo(@Valid VipInfo vipInfo, BindingResult bindingResult, HttpSession session) {
        boolean hasErrors = bindingResult.hasErrors();
        // 有错误信息
        if (hasErrors) {
            // 封装错误信息
            Map<String, Object> map = new HashMap<String, Object>();
            List<FieldError> fieldErrors = bindingResult.getFieldErrors();
            for (FieldError fieldError :
                    fieldErrors) {
                String field = fieldError.getField();
                String defaultMessage = fieldError.getDefaultMessage();
                map.put(field, defaultMessage);
            }
            // 发送到前端
            session.setAttribute("errorMap", map);
            session.setAttribute("vipInfo", vipInfo);
            return "admin/vip/addvip.jsp";
        } else {
            // 数据格式没有错误，将数据存储到数据库
            boolean flag = vipService.addVipInfo(vipInfo);
            return flag ? "redirect:/getVipInfo.do" : "admin/vip/addvip.jsp";
        }
    }

    @RequestMapping("/readyModifyVipInfo.do")
    public String vipMana(Model model, HttpSession session) {
        session.setAttribute("isSingleVipInfo", false);
        List<Map<String, Object>> vipNames = vipService.getAllVipNames();
        model.addAttribute("vipNames", vipNames);
        // 获取可享受的折扣
        List<Map<String, Object>> rateList = vipService.getAllRate();
        model.addAttribute("rateList", rateList);
        return "admin/vip/updateVipInfo.jsp";
    }

    @RequestMapping("/getVipInfoByName.do")
    public @ResponseBody
    Map<String, Object> getVipInfoByName(String vipName, HttpSession session) {
        Map<String, Object> vipInfo = vipService.getVipInfoByName(vipName);
        return vipInfo;
    }

    @RequestMapping("/updateVipInfo.do")
    public String updateVipInfo(String oldVipName, @Valid VipInfo vipInfo, BindingResult bindingResult, HttpSession session, Model model) {
        boolean hasErrors = bindingResult.hasErrors();
        if (hasErrors) {
            Map<String, Object> map = new HashMap<String, Object>();
            // 获取错误信息
            List<FieldError> fieldErrors = bindingResult.getFieldErrors();
            for (FieldError fieldError : fieldErrors) {
                String field = fieldError.getField();
                String defaultMessage = fieldError.getDefaultMessage();
                map.put(field, defaultMessage);
            }
            // 错误信息发送到前端
            session.setAttribute("errorMap", map);
            session.setAttribute("vipInfo", vipInfo);
            // 获取折扣
            List<Map<String, Object>> rateList = vipService.getAllRate();
            // 获取姓名
            List<Map<String, Object>> vipNames = vipService.getAllVipNames();
            model.addAttribute("vipNames", vipNames);
            // 原会员名
            model.addAttribute("oldVipName", oldVipName);
            session.setAttribute("rateList", rateList);
            return "admin/vip/updateVipInfo.jsp";
        } else {
            boolean flag = vipService.updateVipInfo(vipInfo);
            if (flag) {
                return "redirect:/getVipInfo.do";
            } else {
                return "admin/vip/updateVipInfo.jsp";
            }
        }
    }

    /**
     * 修改单个VIP信息（在查询页面点击修改按钮）
     */
    @RequestMapping("/changeSingleVipInfo.do")
    public
    @ResponseBody
    boolean changeSingleVipInfo(String vipNum, String vipName, HttpSession session) {
        // 是单个进行修改
        session.setAttribute("isSingleVipInfo", true);
        session.setAttribute("singleVipNum", vipNum);
        session.setAttribute("singleVipName", vipName);
        Map<String, Object> singleVipInfo = vipService.getVipInfoByNum(vipNum);
        session.setAttribute("singleVipInfo", singleVipInfo);
        // 获取打折信息
        // 获取折扣
        List<Map<String, Object>> rateList = vipService.getAllRate();
        session.setAttribute("rateList", rateList);
        return true;
    }

}