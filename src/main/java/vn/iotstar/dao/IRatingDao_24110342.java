package vn.iotstar.dao;

import vn.iotstar.entity.Rating_24110342;
import java.util.List;

public interface IRatingDao_24110342 {
    List<Rating_24110342> findByBookId(int bookId);
    long countByBookId(int bookId);
    void insertOrUpdate(Rating_24110342 rating);
}
