package vn.iotstar.dao.impl;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import vn.iotstar.config.JPAConfig_24110342;
import vn.iotstar.dao.IAuthorDao_24110342;
import vn.iotstar.entity.Author_24110342;

import java.util.List;

public class AuthorDaoImpl_24110342 implements IAuthorDao_24110342 {

    @Override
    public List<Author_24110342> findAll() {
        EntityManager em = JPAConfig_24110342.getEntityManager();
        try {
            TypedQuery<Author_24110342> query = em.createQuery("SELECT DISTINCT a FROM Author_24110342 a LEFT JOIN FETCH a.books ORDER BY a.authorId ASC", Author_24110342.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Author_24110342> findAll(int page, int size) {
        EntityManager em = JPAConfig_24110342.getEntityManager();
        try {
            TypedQuery<Integer> idQuery = em.createQuery("SELECT a.authorId FROM Author_24110342 a ORDER BY a.authorId ASC", Integer.class);
            idQuery.setFirstResult((page - 1) * size);
            idQuery.setMaxResults(size);
            List<Integer> ids = idQuery.getResultList();

            if (ids.isEmpty()) return java.util.Collections.emptyList();

            TypedQuery<Author_24110342> query = em.createQuery(
                "SELECT DISTINCT a FROM Author_24110342 a LEFT JOIN FETCH a.books WHERE a.authorId IN :ids ORDER BY a.authorId ASC", Author_24110342.class);
            query.setParameter("ids", ids);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public long count() {
        EntityManager em = JPAConfig_24110342.getEntityManager();
        try {
            TypedQuery<Long> query = em.createQuery("SELECT COUNT(a) FROM Author_24110342 a", Long.class);
            return query.getSingleResult();
        } finally {
            em.close();
        }
    }

    @Override
    public Author_24110342 findById(int id) {
        EntityManager em = JPAConfig_24110342.getEntityManager();
        try {
            return em.find(Author_24110342.class, id);
        } finally {
            em.close();
        }
    }

    @Override
    public void insert(Author_24110342 author) {
        EntityManager em = JPAConfig_24110342.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.persist(author);
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public void update(Author_24110342 author) {
        EntityManager em = JPAConfig_24110342.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.merge(author);
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public void delete(int id) {
        EntityManager em = JPAConfig_24110342.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            Author_24110342 author = em.find(Author_24110342.class, id);
            if (author != null) {
                em.remove(author);
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
