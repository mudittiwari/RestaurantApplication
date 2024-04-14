package com.mudit.restaurant.repository;


import com.mudit.restaurant.entity.Category;
import com.mudit.restaurant.entity.Item;
import com.mudit.restaurant.entity.User;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;

@Repository
public class UserRepo {

    @Autowired
    private SessionFactory sessionFactory;
    public boolean addUser(User user){
        Transaction tx=null;
        try(Session session=sessionFactory.openSession()){
            tx=session.beginTransaction();
            session.save(user);
            tx.commit();
        }
        catch (Exception e){
            e.getMessage();
            assert tx != null;
            tx.rollback();
        }
        return true;
    }
    public List<Item> getDiscountedItems(){
        List<Item> lst = new ArrayList<>();
        try (Session session = sessionFactory.openSession()) {
            String hql = "FROM Item WHERE discountedPrice < price";
            Query<Item> query = session.createQuery(hql, Item.class);
            lst = query.list();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lst;
    }
    public List<Item> getFeaturedItems(){
        List<Item> lst = new ArrayList<>();
        try (Session session = sessionFactory.openSession()) {
            String hql = "FROM Item WHERE isFeatured = true";
            Query<Item> query = session.createQuery(hql, Item.class);
            lst = query.list();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lst;
    }
    public List<Item> getCategoryItems(int categoryId) {
        List<Item> lst = new ArrayList<>();
        try (Session session = sessionFactory.openSession()) {
            String hql = "FROM Item WHERE category.id = :categoryId";
            Query<Item> query = session.createQuery(hql, Item.class);
            query.setParameter("categoryId", categoryId);
            lst = query.list();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lst;
    }
    public List<Category> getCategories(){
        List<Category> lst=new ArrayList<>();
        try(Session session=sessionFactory.openSession()){
            String hql = "FROM Category";
            Query<Category> query = session.createQuery(hql, Category.class);
            lst = query.list();
        }
        catch (Exception e){
            System.out.println(e.getMessage());
        }
        return lst;
    }

}
