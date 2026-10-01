package vn.iotstar.dao.impl;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import vn.iotstar.config.JPAConfig_24110342;
import vn.iotstar.dao.IUserDao_24110342;
import vn.iotstar.entity.User_24110342;

import java.util.List;

public class UserDaoImpl_24110342 implements IUserDao_24110342 {

    @Override
    public User_24110342 findById(int id) {
        EntityManager em = JPAConfig_24110342.getEntityManager();
        try {
            return em.find(User_24110342.class, id);
        } finally {
            em.close();
        }
    }

    @Override
    public User_24110342 findByEmail(String email) {
        EntityManager em = JPAConfig_24110342.getEntityManager();
        try {
            TypedQuery<User_24110342> query = em.createQuery("SELECT u FROM User_24110342 u WHERE u.email = :email", User_24110342.class);
            query.setParameter("email", email);
            List<User_24110342> list = query.getResultList();
            return list.isEmpty() ? null : list.get(0);
        } finally {
            em.close();
        }
    }

    @Override
    public void insert(User_24110342 user) {
        EntityManager em = JPAConfig_24110342.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.persist(user);
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public void update(User_24110342 user) {
        EntityManager em = JPAConfig_24110342.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.merge(user);
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public List<User_24110342> findAll() {
        EntityManager em = JPAConfig_24110342.getEntityManager();
        try {
            TypedQuery<User_24110342> query = em.createQuery("SELECT u FROM User_24110342 u ORDER BY u.id ASC", User_24110342.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
}
