package vn.iotstar.util;

import vn.iotstar.entity.Book_24110342;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class Cart_24110342 {

    private final Map<Integer, CartItem_24110342> items = new LinkedHashMap<>();

    public boolean add(Book_24110342 book, int qty) {
        if (book == null || book.getBookid() == null || book.getPrice() == null) {
            return false;
        }
        int stock = (book.getQuantity() != null) ? book.getQuantity() : 0;
        if (qty < 1 || qty > stock) {
            return false;
        }
        CartItem_24110342 item = items.get(book.getBookid());
        if (item == null) {
            items.put(book.getBookid(), new CartItem_24110342(
                    book.getBookid(), book.getTitle(), book.getPrice(), qty, stock));
            return true;
        }
        if (item.getQuantity() + qty > stock) {
            return false;
        }
        item.setQuantity(item.getQuantity() + qty);
        item.setStockQty(stock);
        return true;
    }

    public boolean updateQuantity(int bookId, int qty, int stock) {
        CartItem_24110342 item = items.get(bookId);
        if (item == null) {
            return false;
        }
        if (qty < 1 || qty > stock) {
            return false;
        }
        item.setQuantity(qty);
        item.setStockQty(stock);
        return true;
    }

    public void remove(int bookId) {
        items.remove(bookId);
    }

    public void clear() {
        items.clear();
    }

    public CartItem_24110342 get(int bookId) {
        return items.get(bookId);
    }

    public List<CartItem_24110342> getItems() {
        return new ArrayList<>(items.values());
    }

    public boolean isEmpty() {
        return items.isEmpty();
    }

    public int totalQuantity() {
        return items.values().stream().mapToInt(CartItem_24110342::getQuantity).sum();
    }

    public BigDecimal totalPrice() {
        return items.values().stream()
                .map(CartItem_24110342::getLineTotal)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
    }
}
