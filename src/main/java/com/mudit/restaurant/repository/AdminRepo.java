package com.mudit.restaurant.repository;

import com.mudit.restaurant.entity.Category;
import com.mudit.restaurant.entity.Item;
import com.mudit.restaurant.entity.User;
import org.aspectj.weaver.ast.Literal;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;

@Repository
public class AdminRepo {
    @Autowired
    private SessionFactory sessionFactory;
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
    public Category getCategory(int id){
        try(Session session=sessionFactory.openSession()){
           Category category=session.get(Category.class,id);
           return category;
        }
        catch (Exception e){
            System.out.println(e.getMessage());
        }
        return null;
    }

    public boolean addCategory(Category category){
        Transaction tx=null;
        try(Session session=sessionFactory.openSession()){
            tx=session.beginTransaction();
            session.save(category);
            tx.commit();
        }
        catch (Exception e){
            System.out.println(e.getMessage());
            assert tx != null;
            tx.rollback();
            return false;
        }
        return true;
    }

    public boolean addItem(Item item){
        Transaction tx=null;
        try(Session session=sessionFactory.openSession()){
            tx=session.beginTransaction();
            session.save(item);
            tx.commit();
        }
        catch (Exception e){
            e.printStackTrace();
            assert tx != null;
            tx.rollback();
            return false;
        }
        return true;
    }

    public List<Item> getItems(){
        List<Item> lst=new ArrayList<>();
        try(Session session=sessionFactory.openSession()){
            String hql = "From Item";
            Query<Item> query = session.createQuery(hql, Item.class);
            lst = query.list();
        }
        catch (Exception e){
            e.printStackTrace();
        }
        return lst;
    }

    public boolean editItem(Item updatedItem){
        Transaction tx=null;
        try(Session session=sessionFactory.openSession()){
            Item item=session.get(Item.class,updatedItem.getId());
            item.setName(updatedItem.getName());
            item.setDescription(updatedItem.getDescription());
            item.setPrice(updatedItem.getPrice());
            item.setDiscountedPrice(updatedItem.getDiscountedPrice());
            item.setImage(updatedItem.getImage());
            item.setCategory(updatedItem.getCategory());
            item.setInStock(updatedItem.getInStock());
            tx=session.beginTransaction();
            session.update(item);
            tx.commit();
        }
        catch (Exception e){
            e.printStackTrace();
            assert tx != null;
            tx.rollback();
            return false;
        }
        return true;
    }

    public Item getItem(int id){
        Item item=null;
        try(Session session=sessionFactory.openSession()){
            item=session.get(Item.class,id);
        }catch (Exception e){
            e.printStackTrace();
        }
        return item;
    }
    public boolean deleteItem(int id) {
        Transaction tx = null;
        try (Session session = sessionFactory.openSession()) {
            tx = session.beginTransaction();
            Item item = session.get(Item.class, id);
            if (item != null) {
                Category category = item.getCategory();
                if (category != null) {
                    category.getItems().remove(item);
                    session.saveOrUpdate(category);
                }
                List<User> users=getUsers();
                for(int i=0;i<users.size();i++){
                    users.get(i).getFavourites().remove(item);
                    session.saveOrUpdate(users.get(i));
                }
                session.delete(item);
                tx.commit();
                return true;
            }
            return false; // Item not found
        } catch (Exception e) {
            if (tx != null) {
                tx.rollback();
            }
            e.printStackTrace();
            return false;
        }
    }
    public boolean addFeatured(int id) {
        Transaction tx = null;
        try (Session session = sessionFactory.openSession()) {
            tx = session.beginTransaction();
            Item item = session.get(Item.class, id);
            if (item != null) {
                item.setFeatured(true);
                session.update(item);
                tx.commit();
                return true;
            }
            return false; // Item not found
        } catch (Exception e) {
            if (tx != null) {
                tx.rollback();
            }
            e.printStackTrace();
            return false;
        }
    }
    public boolean removeFeatured(int id) {
        Transaction tx = null;
        try (Session session = sessionFactory.openSession()) {
            tx = session.beginTransaction();
            Item item = session.get(Item.class, id);
            if (item != null) {
                item.setFeatured(false);
                session.update(item);
                tx.commit();
                return true;
            }
            return false; // Item not found
        } catch (Exception e) {
            if (tx != null) {
                tx.rollback();
            }
            e.printStackTrace();
            return false;
        }
    }
    public boolean addInStock(int id) {
        Transaction tx = null;
        try (Session session = sessionFactory.openSession()) {
            tx = session.beginTransaction();
            Item item = session.get(Item.class, id);
            if (item != null) {
                item.setInStock(true);
                session.update(item);
                tx.commit();
                return true;
            }
            return false; // Item not found
        } catch (Exception e) {
            if (tx != null) {
                tx.rollback();
            }
            e.printStackTrace();
            return false;
        }
    }
    public boolean removeInStock(int id) {
        Transaction tx = null;
        try (Session session = sessionFactory.openSession()) {
            tx = session.beginTransaction();
            Item item = session.get(Item.class, id);
            if (item != null) {
                item.setInStock(false);
                session.update(item);
                tx.commit();
                return true;
            }
            return false; // Item not found
        } catch (Exception e) {
            if (tx != null) {
                tx.rollback();
            }
            e.printStackTrace();
            return false;
        }
    }


    public List<User> getUsers(){
        List<User> lst=new ArrayList<>();
        try(Session session=sessionFactory.openSession()){
            String hql = "From User";
            Query<User> query = session.createQuery(hql, User.class);
            lst = query.list();
        }
        catch (Exception e){
            e.printStackTrace();
        }
        return lst;
    }

    public boolean deleteUser(String username) {
        Transaction tx = null;
        try (Session session = sessionFactory.openSession()) {
            tx = session.beginTransaction();
            User user = session.get(User.class, username);
            session.delete(user);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                tx.rollback();
            }
            e.printStackTrace();
            return false;
        }
        return true;
    }
    public long getItemCount() {
        try (Session session = sessionFactory.openSession()) {
            return (Long) session.createQuery("select count(*) from Item").uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }
    public long getCategoryCount() {
        try (Session session = sessionFactory.openSession()) {
            return (Long) session.createQuery("select count(*) from Category").uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }
    public long getUserCount() {
        try (Session session = sessionFactory.openSession()) {
            return (Long) session.createQuery("select count(*) from User").uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }
}
