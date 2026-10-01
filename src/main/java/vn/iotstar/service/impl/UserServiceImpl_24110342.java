package vn.iotstar.service.impl;

import vn.iotstar.dao.IUserDao_24110342;
import vn.iotstar.dao.impl.UserDaoImpl_24110342;
import vn.iotstar.entity.User_24110342;
import vn.iotstar.service.IUserService_24110342;
import vn.iotstar.util.PasswordUtil_24110342;

public class UserServiceImpl_24110342 implements IUserService_24110342 {

    private final IUserDao_24110342 userDao = new UserDaoImpl_24110342();

    @Override
    public User_24110342 login(String email, String password) {
        if (email == null || password == null) return null;
        User_24110342 user = userDao.findByEmail(email.trim());
        if (user != null && PasswordUtil_24110342.checkPassword(password, user.getPasswd())) {
            return user;
        }
        return null;
    }

    @Override
    public User_24110342 getByEmail(String email) {
        if (email == null) return null;
        return userDao.findByEmail(email.trim());
    }

    @Override
    public User_24110342 getById(int id) {
        return userDao.findById(id);
    }

    @Override
    public void insert(User_24110342 user) {
        userDao.insert(user);
    }

    @Override
    public void update(User_24110342 user) {
        userDao.update(user);
    }
}
