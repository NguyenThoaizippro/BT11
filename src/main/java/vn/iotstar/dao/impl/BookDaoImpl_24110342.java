package vn.iotstar.dao.impl;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import vn.iotstar.config.JPAConfig_24110342;
import vn.iotstar.dao.IBookDao_24110342;
import vn.iotstar.entity.Book_24110342;

import java.util.Collections;
import java.util.List;

public class BookDaoImpl_24110342 implements IBookDao_24110342 {

    @Override
    public List<Book_24110342> findAll() {
        EntityManager em = JPAConfig_24110342.getEntityManager();
        try {
            TypedQuery<Book_24110342> query = em.createQuery(
                "SELECT DISTINCT b FROM Book_24110342 b LEFT JOIN FETCH b.authors ORDER BY b.bookid ASC", Book_24110342.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Book_24110342> findAll(int page, int size) {
        EntityManager em = JPAConfig_24110342.getEntityManager();
        try {
            // Step 1: Query IDs with pagination to prevent Hibernate in-memory pagination warnings
            TypedQuery<Integer> idQuery = em.createQuery(
                "SELECT b.bookid FROM Book_24110342 b ORDER BY b.bookid ASC", Integer.class);
            idQuery.setFirstResult((page - 1) * size);
            idQuery.setMaxResults(size);
            List<Integer> ids = idQuery.getResultList();

            if (ids.isEmpty()) {
                return Collections.emptyList();
            }

            // Step 2: Fetch books with authors
            TypedQuery<Book_24110342> query = em.createQuery(
                "SELECT DISTINCT b FROM Book_24110342 b LEFT JOIN FETCH b.authors WHERE b.bookid IN :ids ORDER BY b.bookid ASC",
                Book_24110342.class);
            query.setParameter("ids", ids);
            List<Book_24110342> books = query.getResultList();

            // Step 3: Fetch ratings in a second pass (Hibernate 1st level cache merges them)
            if (!books.isEmpty()) {
                TypedQuery<Book_24110342> ratingQuery = em.createQuery(
                    "SELECT DISTINCT b FROM Book_24110342 b LEFT JOIN FETCH b.ratings WHERE b IN :books",
                    Book_24110342.class);
                ratingQuery.setParameter("books", books);
                ratingQuery.getResultList();
            }
            return books;
        } finally {
            em.close();
        }
    }

    @Override
    public long count() {
        EntityManager em = JPAConfig_24110342.getEntityManager();
        try {
            TypedQuery<Long> query = em.createQuery("SELECT COUNT(b) FROM Book_24110342 b", Long.class);
            return query.getSingleResult();
        } finally {
            em.close();
        }
    }

    @Override
    public Book_24110342 findById(int id) {
        EntityManager em = JPAConfig_24110342.getEntityManager();
        try {
            TypedQuery<Book_24110342> query = em.createQuery(
                "SELECT b FROM Book_24110342 b LEFT JOIN FETCH b.authors WHERE b.bookid = :id",
                Book_24110342.class);
            query.setParameter("id", id);
            List<Book_24110342> list = query.getResultList();
            if (list.isEmpty()) return null;
            Book_24110342 book = list.get(0);

            TypedQuery<Book_24110342> ratingQuery = em.createQuery(
                "SELECT b FROM Book_24110342 b LEFT JOIN FETCH b.ratings WHERE b.bookid = :id",
                Book_24110342.class);
            ratingQuery.setParameter("id", id);
            ratingQuery.getResultList();

            return book;
        } finally {
            em.close();
        }
    }

    @Override
    public void insert(Book_24110342 book) {
        EntityManager em = JPAConfig_24110342.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.persist(book);
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public void update(Book_24110342 book) {
        EntityManager em = JPAConfig_24110342.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.merge(book);
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
            Book_24110342 book = em.find(Book_24110342.class, id);
            if (book != null) {
                em.remove(book);
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
