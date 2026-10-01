package vn.iotstar.service.impl;

import vn.iotstar.dao.IAuthorDao_24110342;
import vn.iotstar.dao.IBookDao_24110342;
import vn.iotstar.dao.impl.AuthorDaoImpl_24110342;
import vn.iotstar.dao.impl.BookDaoImpl_24110342;
import vn.iotstar.entity.Author_24110342;
import vn.iotstar.entity.Book_24110342;
import vn.iotstar.service.IBookService_24110342;

import java.util.ArrayList;
import java.util.List;

public class BookServiceImpl_24110342 implements IBookService_24110342 {

    private final IBookDao_24110342 bookDao = new BookDaoImpl_24110342();
    private final IAuthorDao_24110342 authorDao = new AuthorDaoImpl_24110342();

    @Override
    public List<Book_24110342> findAll() {
        return bookDao.findAll();
    }

    @Override
    public List<Book_24110342> findAll(int page, int size) {
        return bookDao.findAll(page, size);
    }

    @Override
    public long count() {
        return bookDao.count();
    }

    @Override
    public Book_24110342 findById(int id) {
        return bookDao.findById(id);
    }

    @Override
    public void insert(Book_24110342 book, List<Integer> authorIds) {
        if (authorIds != null && !authorIds.isEmpty()) {
            List<Author_24110342> authors = new ArrayList<>();
            for (Integer aid : authorIds) {
                Author_24110342 a = authorDao.findById(aid);
                if (a != null) {
                    authors.add(a);
                }
            }
            book.setAuthors(authors);
        }
        bookDao.insert(book);
    }

    @Override
    public void update(Book_24110342 book, List<Integer> authorIds) {
        if (authorIds != null) {
            List<Author_24110342> authors = new ArrayList<>();
            for (Integer aid : authorIds) {
                Author_24110342 a = authorDao.findById(aid);
                if (a != null) {
                    authors.add(a);
                }
            }
            book.setAuthors(authors);
        }
        bookDao.update(book);
    }

    @Override
    public void delete(int id) {
        bookDao.delete(id);
    }
}
