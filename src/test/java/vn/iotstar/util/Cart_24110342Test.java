package vn.iotstar.util;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import vn.iotstar.entity.Book_24110342;

import java.math.BigDecimal;

import static org.junit.jupiter.api.Assertions.*;

class Cart_24110342Test {

    private Cart_24110342 cart;
    private Book_24110342 book;

    @BeforeEach
    void setUp() {
        cart = new Cart_24110342();
        book = Book_24110342.builder()
                .bookid(1)
                .title("Clean Code")
                .price(new BigDecimal("42.50"))
                .quantity(25)
                .build();
    }

    @Test
    void addNewBookIncreasesItemCountAndQuantity() {
        assertTrue(cart.add(book, 2));
        assertEquals(1, cart.getItems().size());
        assertEquals(2, cart.get(1).getQuantity());
        assertEquals(2, cart.totalQuantity());
    }

    @Test
    void addSameBookTwiceMergesQuantity() {
        cart.add(book, 2);
        assertTrue(cart.add(book, 3));
        assertEquals(1, cart.getItems().size());
        assertEquals(5, cart.get(1).getQuantity());
    }

    @Test
    void addExceedingStockIsRejected() {
        assertFalse(cart.add(book, 26));
        assertTrue(cart.isEmpty());
    }

    @Test
    void addMergedExceedingStockIsRejected() {
        cart.add(book, 20);
        assertFalse(cart.add(book, 10));
        assertEquals(20, cart.get(1).getQuantity());
    }

    @Test
    void addZeroOrNegativeQuantityIsRejected() {
        assertFalse(cart.add(book, 0));
        assertFalse(cart.add(book, -3));
        assertTrue(cart.isEmpty());
    }

    @Test
    void updateQuantityWithinLimitSucceeds() {
        cart.add(book, 2);
        assertTrue(cart.updateQuantity(1, 10, 25));
        assertEquals(10, cart.get(1).getQuantity());
    }

    @Test
    void updateQuantityOutsideLimitFailsAndKeepsOldValue() {
        cart.add(book, 2);
        assertFalse(cart.updateQuantity(1, 0, 25));
        assertFalse(cart.updateQuantity(1, 26, 25));
        assertEquals(2, cart.get(1).getQuantity());
    }

    @Test
    void removeDeletesItem() {
        cart.add(book, 1);
        cart.remove(1);
        assertTrue(cart.isEmpty());
        assertNull(cart.get(1));
    }

    @Test
    void totalsAreSummedCorrectly() {
        cart.add(book, 3);
        assertEquals(3, cart.totalQuantity());
        assertEquals(new BigDecimal("127.50"), cart.totalPrice());
        cart.clear();
        assertTrue(cart.isEmpty());
        assertEquals(0, cart.totalQuantity());
        assertEquals(BigDecimal.ZERO, cart.totalPrice());
    }
}
