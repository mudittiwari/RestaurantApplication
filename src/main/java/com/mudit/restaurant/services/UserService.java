package com.mudit.restaurant.services;


import com.mudit.restaurant.entity.*;
import com.mudit.restaurant.repository.UserRepo;
import org.apache.logging.log4j.core.util.JsonUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
    public List<Item> getAllItems(){
        return repo.getAllItems();
    }
    public Item getItemById(int id){
        return repo.getItemById(id);
    }
    public boolean addCartItem(Item item, HttpSession session) {
        Map<Item,Integer> cart = (Map<Item,Integer>) session.getAttribute("cart");
        if (cart == null) {
            cart = new HashMap<>();
        }
        if (cart.containsKey(item)) {
            cart.put(item, cart.get(item) + 1);
        } else {
            cart.put(item, 1);
        }
        session.setAttribute("cart", cart);
        System.out.println(session.getAttribute("cart"));
        return true;
    }
    public Map<Item,Integer> getCart(HttpSession session) {
        Map<Item,Integer> cart = (Map<Item,Integer>) session.getAttribute("cart");
        if (cart == null) {
            cart = new HashMap<>();
        }
        return cart;
    }
    public boolean removeCartItem(Item item, HttpSession session) {
        Map<Item,Integer> cart = (Map<Item,Integer>) session.getAttribute("cart");
        if (cart == null) {
            return false; // Cart is empty, nothing to remove
        }

        if (cart.containsKey(item)) {
            int quantity = cart.get(item);
            if (quantity == 1) {
                cart.remove(item);
            } else {
                cart.put(item, quantity - 1);
            }
            session.setAttribute("cart", cart);
            return true;
        } else {
            return false;
        }
    }
    public Boolean addOrder(Order order){
        return repo.addOrder(order);
    }
    public Boolean editOrder(int id,String status){
        return repo.editOrder(id,status);
    }
    public Item getOrderById(int id){
        return repo.getOrderById(id);
    }
    public List<Order> getOrders(){
        return repo.getOrders();
    }
}
