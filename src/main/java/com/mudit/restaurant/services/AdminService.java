package com.mudit.restaurant.services;

import com.mudit.restaurant.entity.Category;
import com.mudit.restaurant.entity.Item;
import com.mudit.restaurant.entity.Order;
import com.mudit.restaurant.entity.User;
import com.mudit.restaurant.repository.AdminRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AdminService {
    @Autowired
    private AdminRepo adminRepo;
    public List<Category> getCategories(){
        return adminRepo.getCategories();
    }
    public boolean addCategory(Category category){
        return adminRepo.addCategory(category);
    }
    public Category getCategory(int id){
        return adminRepo.getCategory(id);
    }
    public boolean addItem(Item item){
        return adminRepo.addItem(item);
    }
    public List<Item> getItems(){
        return adminRepo.getItems();
    }
    public boolean editItem(Item updatedItem){
        return adminRepo.editItem(updatedItem);
    }
    public Item getItem(int id){
        return adminRepo.getItem(id);
    }
    public boolean deleteItem(int id){
        return adminRepo.deleteItem(id);
    }
    public List<User> getUsers(){
        return adminRepo.getUsers();
    }
    public boolean deleteUser(String username){
        return adminRepo.deleteUser(username);
    }
    public boolean addFeatured(int id){
        return adminRepo.addFeatured(id);
    }
    public boolean removeFeatured(int id){
        return adminRepo.removeFeatured(id);
    }
    public boolean addInStock(int id){
        return adminRepo.addInStock(id);
    }
    public boolean removeInStock(int id){
        return adminRepo.removeInStock(id);
    }
    public long getItemCount(){
        return adminRepo.getItemCount();
    }
    public long getCategoryCount(){
        return adminRepo.getCategoryCount();
    }
    public long getUserCount(){
        return adminRepo.getUserCount();
    }
    public Boolean editOrder(int id,String status){
        return adminRepo.editOrder(id,status);
    }
    public Order getOrderById(int id){
        return adminRepo.getOrderById(id);
    }
    public List<Order> getOrders(){
        return adminRepo.getOrders();
    }
}
