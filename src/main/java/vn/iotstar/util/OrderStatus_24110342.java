package vn.iotstar.util;

import java.util.LinkedHashMap;
import java.util.Map;

public final class OrderStatus_24110342 {

    public static final String NEW = "NEW";
    public static final String CONFIRMED = "CONFIRMED";
    public static final String PREPARING = "PREPARING";
    public static final String SHIPPING = "SHIPPING";
    public static final String DELIVERING = "DELIVERING";
    public static final String DELIVERED = "DELIVERED";
    public static final String CANCELLED = "CANCELLED";
    public static final String RETURNED = "RETURNED";

    public static final Map<String, String> LABELS = new LinkedHashMap<>();
    public static final Map<String, String> COLORS = new LinkedHashMap<>();

    static {
        LABELS.put(NEW, "Đơn hàng mới");
        LABELS.put(CONFIRMED, "Đã xác nhận");
        LABELS.put(PREPARING, "Chuẩn bị hàng");
        LABELS.put(SHIPPING, "Đang vận chuyển");
        LABELS.put(DELIVERING, "Đang giao hàng");
        LABELS.put(DELIVERED, "Đã giao");
        LABELS.put(CANCELLED, "Đơn hàng hủy");
        LABELS.put(RETURNED, "Đơn hàng hoàn");

        COLORS.put(NEW, "bg-primary");
        COLORS.put(CONFIRMED, "bg-info");
        COLORS.put(PREPARING, "bg-warning text-dark");
        COLORS.put(SHIPPING, "bg-secondary");
        COLORS.put(DELIVERING, "bg-dark");
        COLORS.put(DELIVERED, "bg-success");
        COLORS.put(CANCELLED, "bg-danger");
        COLORS.put(RETURNED, "bg-light text-dark border");
    }

    private OrderStatus_24110342() {
    }

    public static String label(String status) {
        return LABELS.getOrDefault(status, status);
    }

    public static String color(String status) {
        return COLORS.getOrDefault(status, "bg-secondary");
    }

    public static boolean isValid(String status) {
        return status != null && LABELS.containsKey(status);
    }
}
