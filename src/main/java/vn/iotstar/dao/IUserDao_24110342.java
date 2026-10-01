package vn.iotstar.dao;

import vn.iotstar.entity.User_24110342;
import java.util.List;

public interface IUserDao_24110342 {
    User_24110342 findById(int id);
    User_24110342 findByEmail(String email);
    void insert(User_24110342 user);
    void update(User_24110342 user);
    List<User_24110342> findAll();
}
