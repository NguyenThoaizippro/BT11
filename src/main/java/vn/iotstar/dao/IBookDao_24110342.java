package vn.iotstar.dao;

import vn.iotstar.entity.Book_24110342;
import java.util.List;

public interface IBookDao_24110342 {
    List<Book_24110342> findAll();
    List<Book_24110342> findAll(int page, int size);
    long count();
    Book_24110342 findById(int id);
    void insert(Book_24110342 book);
    void update(Book_24110342 book);
    void delete(int id);
}
