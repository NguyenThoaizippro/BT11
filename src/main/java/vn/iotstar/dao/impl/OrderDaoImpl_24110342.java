package vn.iotstar.dao.impl;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import vn.iotstar.config.JPAConfig_24110342;
import vn.iotstar.dao.IOrderDao_24110342;
import vn.iotstar.entity.Book_24110342;
import vn.iotstar.entity.Order_24110342;
import vn.iotstar.entity.OrderDetail_24110342;
import vn.iotstar.entity.User_24110342;

import java.util.List;

public class OrderDaoImpl_24110342 implements IOrderDao_24110342 {

    @Override
    public Order_24110342 insert(Order_24110342 order) {
        EntityManager em = JPAConfig_24110342.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();

            User_24110342 user = em.find(User_24110342.class, order.getUser().getId());
            order.setUser(user);
            em.persist(order);

            for (OrderDetail_24110342 detail : order.getDetails()) {
                Book_24110342 book = em.find(Book_24110342.class, detail.getBookId());
                if (book == null || book.getQuantity() == null || book.getQuantity() < detail.getQuantity()) {
                    throw new IllegalStateException(
                            "Sản phẩm \"" + detail.getBookTitle() + "\" không còn đủ hàng trong kho.");
                }
                book.setQuantity(book.getQuantity() - detail.getQuantity());
                em.merge(book);
                detail.setOrder(order);
            }

            trans.commit();
            return order;
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public Order_24110342 findById(int orderId) {
        EntityManager em = JPAConfig_24110342.getEntityManager();
        try {
            TypedQuery<Order_24110342> query = em.createQuery(
                    "SELECT DISTINCT o FROM Order_24110342 o LEFT JOIN FETCH o.details "
                            + "WHERE o.orderId = :id", Order_24110342.class);
            query.setParameter("id", orderId);
            List<Order_24110342> list = query.getResultList();
            return list.isEmpty() ? null : list.get(0);
        } finally {
            em.close();
        }
    }

    @Override
    public List<Order_24110342> findByUserId(int userId) {
        EntityManager em = JPAConfig_24110342.getEntityManager();
        try {
            TypedQuery<Order_24110342> query = em.createQuery(
                    "SELECT DISTINCT o FROM Order_24110342 o LEFT JOIN FETCH o.details "
                            + "WHERE o.user.id = :uid ORDER BY o.createdAt DESC, o.orderId DESC",
                    Order_24110342.class);
            query.setParameter("uid", userId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Order_24110342> findByUserIdAndStatus(int userId, String status) {
        EntityManager em = JPAConfig_24110342.getEntityManager();
        try {
            TypedQuery<Order_24110342> query = em.createQuery(
                    "SELECT DISTINCT o FROM Order_24110342 o LEFT JOIN FETCH o.details "
                            + "WHERE o.user.id = :uid AND o.status = :status "
                            + "ORDER BY o.createdAt DESC, o.orderId DESC",
                    Order_24110342.class);
            query.setParameter("uid", userId);
            query.setParameter("status", status);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
}
