package vn.iotstar.dao.impl;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import vn.iotstar.config.JPAConfig_24110342;
import vn.iotstar.dao.IRatingDao_24110342;
import vn.iotstar.entity.Rating_24110342;
import vn.iotstar.entity.RatingId_24110342;

import java.util.List;

public class RatingDaoImpl_24110342 implements IRatingDao_24110342 {

    @Override
    public List<Rating_24110342> findByBookId(int bookId) {
        EntityManager em = JPAConfig_24110342.getEntityManager();
        try {
            TypedQuery<Rating_24110342> query = em.createQuery(
                "SELECT r FROM Rating_24110342 r LEFT JOIN FETCH r.user WHERE r.bookid = :bookId", Rating_24110342.class);
            query.setParameter("bookId", bookId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public long countByBookId(int bookId) {
        EntityManager em = JPAConfig_24110342.getEntityManager();
        try {
            TypedQuery<Long> query = em.createQuery(
                "SELECT COUNT(r) FROM Rating_24110342 r WHERE r.bookid = :bookId", Long.class);
            query.setParameter("bookId", bookId);
            return query.getSingleResult();
        } finally {
            em.close();
        }
    }

    @Override
    public void insertOrUpdate(Rating_24110342 rating) {
        EntityManager em = JPAConfig_24110342.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            RatingId_24110342 id = new RatingId_24110342(rating.getUserid(), rating.getBookid());
            Rating_24110342 existing = em.find(Rating_24110342.class, id);
            if (existing != null) {
                existing.setRating(rating.getRating());
                existing.setReviewText(rating.getReviewText());
                em.merge(existing);
            } else {
                em.persist(rating);
            }
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            throw e;
        } finally {
            em.close();
        }
    }
}
