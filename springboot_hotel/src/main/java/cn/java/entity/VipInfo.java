package cn.java.entity;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;

public class VipInfo {

    @NotNull(message = "*会员姓名格式错误")
    @Pattern(regexp = ".{2,20}", message = "*会员姓名格式错误")
    private String vipName;

    @NotNull(message = "*性别格式错误")
    @Pattern(regexp = "[01]", message = "*性别格式错误")
    private String gender;

    @NotNull(message = "*身份证号格式错误")
    @Pattern(regexp = "\\d{17}[0-9X]", message = "*身份证号格式错误")
    private String idcard;

    @NotNull(message = "*手机号格式错误")
    @Pattern(regexp = "1[25789]\\d{9}", message = "*手机号格式错误")
    private String phone;

    private String content;

    private String createDate;

    private String vipNum;

    private float vipRate = 9.5F;

    public String getVipName() {
        return vipName;
    }

    public void setVipName(String vipName) {
        this.vipName = vipName;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getIdcard() {
        return idcard;
    }

    public void setIdcard(String idcard) {
        this.idcard = idcard;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getCreateDate() {
        return createDate;
    }

    public void setCreateDate(String createDate) {
        this.createDate = createDate;
    }

    public String getVipNum() {
        return vipNum;
    }

    public void setVipNum(String vipNum) {
        this.vipNum = vipNum;
    }

    public float getVipRate() {
        return vipRate;
    }

    public void setVipRate(float vipRate) {
        this.vipRate = vipRate;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    @Override
    public String toString() {
        return "VipInfo{" +
                "vipName='" + vipName + '\'' +
                ", gender='" + gender + '\'' +
                ", idcard='" + idcard + '\'' +
                ", phone='" + phone + '\'' +
                ", content='" + content + '\'' +
                ", createDate='" + createDate + '\'' +
                ", vipNum='" + vipNum + '\'' +
                ", vipRate=" + vipRate +
                '}';
    }
}