package cn.java.entity;

import javax.validation.constraints.DecimalMax;
import javax.validation.constraints.DecimalMin;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import java.io.Serializable;

/**
 * 订单
 */
public class Order implements Serializable {

    private static final long serialVersionUID = -5150196383093915276L;
    /**
     * 订单编号
     */
    private String orderNum;

    /**
     * 客人姓名
     */
    @NotNull(message = "*姓名格式错误")
    @Pattern(regexp = ".{2,20}", message = "*姓名格式错误")
    private String customerName;

    @NotNull(message = "*身份证格式错误")
    @Pattern(regexp = "\\d{17}[0-9X]", message = "*身份证格式错误")
    private String idcard;

    @NotNull(message = "*手机号格式错误")
    @Pattern(regexp = "^1[135789]\\d{9}", message = "*手机号格式错误")
    private String phone;

    @NotNull(message = "*物品名称格式错误")
    @Pattern(regexp = ".{2,40}", message = "*物品名称格式错误")
    private String consumeName;

    @NotNull(message = "*物品数量格式错误")
    @DecimalMin(value = "1", message = "*物品数量格式错误")
    @DecimalMax(value = "500000", message = "*物品数量格式错误")
    private Long consumeCount;
    /**
     * 消费金额
     */
    @NotNull(message = "*金额格式错误")
    @DecimalMin(value = "0", message = "*金额格式错误")
    @DecimalMax(value = "1000000", message = "*金额格式错误")
    private Float money;

    /**
     * 订单状态
     * 1已结算
     * 0未结算
     */
    @NotNull(message = "*订单状态格式错误")
    @Pattern(regexp = "[01]", message = "*订单状态格式错误")
    private String orderStatus;

    /**
     * 房间编号
     */
    private String roomId;

    /**
     * 创建日期
     */
    private String createDate;

    public String getOrderNum() {
        return orderNum;
    }

    public void setOrderNum(String orderNum) {
        this.orderNum = orderNum;
    }

    public Float getMoney() {
        return money;
    }

    public void setMoney(Float money) {
        this.money = money;
    }

    public String getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }

    public String getRoomId() {
        return roomId;
    }

    public void setRoomId(String roomId) {
        this.roomId = roomId;
    }

    public String getCreateDate() {
        return createDate;
    }

    public void setCreateDate(String createDate) {
        this.createDate = createDate;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
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

    public String getConsumeName() {
        return consumeName;
    }

    public void setConsumeName(String consumeName) {
        this.consumeName = consumeName;
    }

    public Long getConsumeCount() {
        return consumeCount;
    }

    public void setConsumeCount(Long consumeCount) {
        this.consumeCount = consumeCount;
    }

    @Override
    public String toString() {
        return "Order{" +
                "orderNum='" + orderNum + '\'' +
                ", customerName='" + customerName + '\'' +
                ", idcard='" + idcard + '\'' +
                ", phone='" + phone + '\'' +
                ", consumeName='" + consumeName + '\'' +
                ", consumeCount=" + consumeCount +
                ", money=" + money +
                ", orderStatus='" + orderStatus + '\'' +
                ", roomId='" + roomId + '\'' +
                ", createDate='" + createDate + '\'' +
                '}';
    }
}
