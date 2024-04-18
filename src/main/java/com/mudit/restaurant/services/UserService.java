package com.mudit.restaurant.services;


import com.mudit.restaurant.entity.Authority;
import com.mudit.restaurant.entity.Category;
import com.mudit.restaurant.entity.Item;
import com.mudit.restaurant.entity.User;
import com.mudit.restaurant.repository.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserService {

    @Autowired
    private UserRepo repo;

    public boolean addUser(User user){
        Authority authority=new Authority();
        authority.setUsername(user.getUsername());
        authority.setAuthority("USER");
        user.setEnabled(true);
        user.setAuthority(authority);
        return repo.addUser(user);
    }
    public List<Item> getDiscountedItems(){
        return repo.getDiscountedItems();
    }
    public List<Item> getFeaturedItems(){
        return repo.getFeaturedItems();
    }
    public List<Item> getCategoryItems(int categoryId){
        return repo.getCategoryItems(categoryId);
    }
    public List<Category> getCategories(){
        return repo.getCategories();
    }
    public User getUserByUsername(String username){
        return repo.getUserByUsername(username);
    }
    public boolean addFavItem(int itemId,String username){
        return repo.addFavItem(itemId,username);
    }
    public List<Item> getFavouriteItems(String username){
        return repo.getFavouriteItems(username);
    }
    public boolean removeFavItem(int itemId,String username){
        return repo.removeFavItem(itemId,username);
    }
}
