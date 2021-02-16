package cn.java.entity;

import javax.validation.constraints.DecimalMax;
import javax.validation.constraints.DecimalMin;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;

public class RoomInfo {

    @NotNull(message = "*房间号格式错误")
    @Pattern(regexp = "\\d{4}", message = "*房间号格式错误")
    private String roomNum;

    @NotNull(message = "*房间状态格式错误")
    @Pattern(regexp = "[210]", message = "*房间状态格式错误")
    private String roomStatus;

    @NotNull(message = "*房间类型格式错误")
    @DecimalMin(value = "0", message = "*房间类型格式错误")
    @DecimalMax(value = "1000000", message = "*房间类型格式错误")
    private Long roomTypeId;

    public String getRoomNum() {
        return roomNum;
    }

    public void setRoomNum(String roomNum) {
        this.roomNum = roomNum;
    }

    public String getRoomStatus() {
        return roomStatus;
    }

    public void setRoomStatus(String roomStatus) {
        this.roomStatus = roomStatus;
    }

    public Long getRoomTypeId() {
        return roomTypeId;
    }

    public void setRoomTypeId(Long roomTypeId) {
        this.roomTypeId = roomTypeId;
    }

    @Override
    public String toString() {
        return "RoomInfo{" +
                "roomNum='" + roomNum + '\'' +
                ", roomStatus='" + roomStatus + '\'' +
                ", roomTypeId=" + roomTypeId +
                '}';
    }
}
