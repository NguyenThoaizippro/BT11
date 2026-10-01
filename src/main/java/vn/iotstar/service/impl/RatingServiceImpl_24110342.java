package vn.iotstar.service.impl;

import vn.iotstar.dao.IRatingDao_24110342;
import vn.iotstar.dao.impl.RatingDaoImpl_24110342;
import vn.iotstar.entity.Rating_24110342;
import vn.iotstar.service.IRatingService_24110342;

import java.util.List;

public class RatingServiceImpl_24110342 implements IRatingService_24110342 {

    private final IRatingDao_24110342 ratingDao = new RatingDaoImpl_24110342();

    @Override
    public List<Rating_24110342> findByBookId(int bookId) {
        return ratingDao.findByBookId(bookId);
    }

    @Override
    public long countByBookId(int bookId) {
        return ratingDao.countByBookId(bookId);
    }

    @Override
    public void addOrUpdateReview(int userId, int bookId, int rating, String reviewText) {
        Rating_24110342 r = Rating_24110342.builder()
                .userid(userId)
                .bookid(bookId)
                .rating(rating)
                .reviewText(reviewText)
                .build();
        ratingDao.insertOrUpdate(r);
    }
}
