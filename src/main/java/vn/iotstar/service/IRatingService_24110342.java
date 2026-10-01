package vn.iotstar.service;

import vn.iotstar.entity.Rating_24110342;
import java.util.List;

public interface IRatingService_24110342 {
    List<Rating_24110342> findByBookId(int bookId);
    long countByBookId(int bookId);
    void addOrUpdateReview(int userId, int bookId, int rating, String reviewText);
}
