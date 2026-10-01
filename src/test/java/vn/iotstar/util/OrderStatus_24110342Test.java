package vn.iotstar.util;

import org.junit.jupiter.api.Test;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

class OrderStatus_24110342Test {

    @Test
    void hasExactlyEightStatusesInSpecOrder() {
        assertEquals(8, OrderStatus_24110342.LABELS.size());
        assertIterableEquals(
                List.of("NEW", "CONFIRMED", "PREPARING", "SHIPPING",
                        "DELIVERING", "DELIVERED", "CANCELLED", "RETURNED"),
                List.copyOf(OrderStatus_24110342.LABELS.keySet()));
    }

    @Test
    void labelsAreVietnameseForAllStatuses() {
        assertEquals("Đơn hàng mới", OrderStatus_24110342.label("NEW"));
        assertEquals("Đã xác nhận", OrderStatus_24110342.label("CONFIRMED"));
        assertEquals("Chuẩn bị hàng", OrderStatus_24110342.label("PREPARING"));
        assertEquals("Đang vận chuyển", OrderStatus_24110342.label("SHIPPING"));
        assertEquals("Đang giao hàng", OrderStatus_24110342.label("DELIVERING"));
        assertEquals("Đã giao", OrderStatus_24110342.label("DELIVERED"));
        assertEquals("Đơn hàng hủy", OrderStatus_24110342.label("CANCELLED"));
        assertEquals("Đơn hàng hoàn", OrderStatus_24110342.label("RETURNED"));
        assertEquals("UNKNOWN", OrderStatus_24110342.label("UNKNOWN"));
    }

    @Test
    void colorsAreNonBlankBootstrapClassesForAllStatuses() {
        for (String key : OrderStatus_24110342.LABELS.keySet()) {
            String color = OrderStatus_24110342.color(key);
            assertFalse(color == null || color.isBlank(), "color trống cho " + key);
        }
        assertEquals("bg-secondary", OrderStatus_24110342.color("NOT_EXISTS"));
    }

    @Test
    void isValidAcceptsOnlyTheEightStatuses() {
        for (String key : OrderStatus_24110342.LABELS.keySet()) {
            assertTrue(OrderStatus_24110342.isValid(key));
        }
        assertFalse(OrderStatus_24110342.isValid(""));
        assertFalse(OrderStatus_24110342.isValid("PAID"));
        assertFalse(OrderStatus_24110342.isValid(null));
    }
}
