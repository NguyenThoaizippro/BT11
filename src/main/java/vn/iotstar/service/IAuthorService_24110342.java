package vn.iotstar.service;

import vn.iotstar.entity.Author_24110342;
import java.util.List;

public interface IAuthorService_24110342 {
    List<Author_24110342> findAll();
    List<Author_24110342> findAll(int page, int size);
    long count();
    Author_24110342 findById(int id);
    void insert(Author_24110342 author);
    void update(Author_24110342 author);
    void delete(int id);
}
