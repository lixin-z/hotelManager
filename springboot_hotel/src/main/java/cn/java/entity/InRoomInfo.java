package cn.java.entity;

import javax.validation.constraints.DecimalMax;
import javax.validation.constraints.DecimalMin;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import java.io.Serializable;

public class InRoomInfo implements Serializable {

    private static final long serialVersionUID = -236470707063907811L;
    private String roomNum;

    @NotNull(message = "*姓名格式错误")
    @Pattern(regexp = ".{2,20}", message = "*姓名格式错误")
    private String customerName;

    /**
     * 1 男
     * 0 女
     */
    @NotNull(message = "*性别格式错误")
    @Pattern(regexp = "[01]", message = "*性别格式错误")
    private String gender;

    /**
     * 1是会员
     * 0不是会员
     */
    @NotNull(message = "*VIP格式错误")
    @Pattern(regexp = "[01]", message = "*VIP格式错误")
    private String isVip;

    /**
     * 身份证号
     */
    @NotNull(message = "*身份证格式错误")
    @Pattern(regexp = "\\d{17}[0-9X]", message = "*身份证格式错误")
    private String idcard;

    /**
     * 手机号码
     */
    @NotNull(message = "*手机号格式错误")
    @Pattern(regexp = "1[35789]\\d{9}", message = "*手机号格式错误")
    private String phone;

    /**
     * 押金
     */
    @NotNull(message = "*押金格式错误")
    @DecimalMin(value = "0")
    @DecimalMax(value = "1000000")
    private float money;

    /**
     * 入住时间
     */
    private String createDate;

    /**
     * 房间的id
     */
    private Long roomId;

    /**
     * 房间的状态
     * 0未入住
     * 1已入住
     * 2打扫
     */
    private String status;

    /* 其他消费 */
    private String otherConsume;

    public String getRoomNum() {
        return roomNum;
    }

    public void setRoomNum(String roomNum) {
        this.roomNum = roomNum;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getIsVip() {
        return isVip;
    }

    public void setIsVip(String isVip) {
        this.isVip = isVip;
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

    public float getMoney() {
        return money;
    }

    public void setMoney(float money) {
        this.money = money;
    }

    public String getCreateDate() {
        return createDate;
    }

    public void setCreateDate(String createDate) {
        this.createDate = createDate;
    }

    public Long getRoomId() {
        return roomId;
    }

    public void setRoomId(Long roomId) {
        this.roomId = roomId;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getOtherConsume() {
        return otherConsume;
    }

    public void setOtherConsume(String otherConsume) {
        this.otherConsume = otherConsume;
    }

    @Override
    public String toString() {
        return "InRoomInfo{" +
                "roomNum='" + roomNum + '\'' +
                ", customerName='" + customerName + '\'' +
                ", gender='" + gender + '\'' +
                ", isVip='" + isVip + '\'' +
                ", idcard='" + idcard + '\'' +
                ", phone='" + phone + '\'' +
                ", money=" + money +
                ", createDate='" + createDate + '\'' +
                ", roomId=" + roomId +
                ", status='" + status + '\'' +
                ", otherConsume='" + otherConsume + '\'' +
                '}';
    }
}
