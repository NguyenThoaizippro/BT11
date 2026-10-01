package vn.iotstar.service.impl;

import vn.iotstar.dao.IAuthorDao_24110342;
import vn.iotstar.dao.impl.AuthorDaoImpl_24110342;
import vn.iotstar.entity.Author_24110342;
import vn.iotstar.service.IAuthorService_24110342;

import java.util.List;

public class AuthorServiceImpl_24110342 implements IAuthorService_24110342 {

    private final IAuthorDao_24110342 authorDao = new AuthorDaoImpl_24110342();

    @Override
    public List<Author_24110342> findAll() {
        return authorDao.findAll();
    }

    @Override
    public List<Author_24110342> findAll(int page, int size) {
        return authorDao.findAll(page, size);
    }

    @Override
    public long count() {
        return authorDao.count();
    }

    @Override
    public Author_24110342 findById(int id) {
        return authorDao.findById(id);
    }

    @Override
    public void insert(Author_24110342 author) {
        authorDao.insert(author);
    }

    @Override
    public void update(Author_24110342 author) {
        authorDao.update(author);
    }

    @Override
    public void delete(int id) {
        authorDao.delete(id);
    }
}
