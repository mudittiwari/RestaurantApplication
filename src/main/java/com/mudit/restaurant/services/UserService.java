package com.mudit.restaurant.services;


import com.mudit.restaurant.entity.User;
import com.mudit.restaurant.repository.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class UserService {

    @Autowired
    private UserRepo repo;

    public boolean addUser(User user){
        return repo.addUser(user);
    }
}
