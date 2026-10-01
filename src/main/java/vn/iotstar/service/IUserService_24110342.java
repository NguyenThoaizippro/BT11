package vn.iotstar.service;

import vn.iotstar.entity.User_24110342;

public interface IUserService_24110342 {
    User_24110342 login(String email, String password);
    User_24110342 getByEmail(String email);
    User_24110342 getById(int id);
    void insert(User_24110342 user);
    void update(User_24110342 user);
}
