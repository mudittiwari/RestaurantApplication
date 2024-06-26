package com.mudit.restaurant.repository;

import com.mudit.restaurant.constants.Strings;
import com.mudit.restaurant.entity.Category;
import com.mudit.restaurant.entity.Item;
import com.mudit.restaurant.entity.Order;
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
        List<User> users = this.getUsers();
        try (Session session = sessionFactory.openSession()) {
            tx=session.beginTransaction();
            for (User user : users) {
                List<Order> lst;
                Item item = session.get(Item.class, id);
                String hql = "SELECT DISTINCT o FROM Order o " +
                        "JOIN FETCH o.items " +
                        "WHERE o.user.username = :username";
                Query<Order> query = session.createQuery(hql, Order.class);
                query.setParameter("username", user.getUsername());
                lst = query.list();
                for (Order order:lst){
                    order.getItems().remove(item);
                    System.out.println(order.getItems());
                    session.saveOrUpdate(order);
                }
                tx.commit();
                tx=session.beginTransaction();
                hql = "FROM User WHERE username = :username";
                Query<User> query2 = session.createQuery(hql, User.class);
                query2.setParameter("username", user.getUsername());
                User usr=query2.list().get(0);
                List<Item> usrFav=usr.getFavourites();
                usrFav.remove(item);
                usr.setFavourites(usrFav);
                session.saveOrUpdate(usr);

                    if (item != null) {
                        Category category = item.getCategory();
                        if (category != null) {
                            category.getItems().remove(item);
                            session.saveOrUpdate(category);
                        }
                        session.delete(item);
                    }

            }
            assert tx != null;
            tx.commit();
        }
        catch (Exception e) {
            System.out.println(e.getMessage());
            return false;
        }
        return true;
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

    public Boolean editOrder(int id,String status){
        Transaction tx=null;
        try(Session session=sessionFactory.openSession()){
            tx=session.beginTransaction();
            Order userOrder=session.get(Order.class,id);
            userOrder.setStatus(status);
            session.saveOrUpdate(userOrder);
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


    public List<Order> getOrders(){
        List<Order> lst=new ArrayList<>();
        try(Session session=sessionFactory.openSession()){
            String hql = "FROM Order ORDER BY createdAt DESC";
            Query<Order> query = session.createQuery(hql, Order.class);
            lst = query.list();
        }
        catch (Exception e){
            System.out.println(e.getMessage());
        }
        return lst;
    }

    public Order getOrderById(int id){
        Order order=null;
        try (Session session = sessionFactory.openSession()) {
            String hql = "FROM Order WHERE id = :id";
            Query<Order> query = session.createQuery(hql, Order.class);
            query.setParameter("id", id);
            order=query.list().get(0);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return order;
    }

    public Boolean deleteCategory(int id){
        Transaction tx = null;
        try (Session session = sessionFactory.openSession()) {
            tx = session.beginTransaction();
            Category category = session.get(Category.class, id);
            session.delete(category);
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
    public int countTotalOrders() {
        try (Session session=sessionFactory.openSession()){
            Query query = session.createQuery("select count(*) from Order");
            Long count = (Long) query.uniqueResult();
            return count.intValue();
        }
        catch (Exception e){
            e.printStackTrace();

        }
        return -1;
    }

    public int countProcessingOrders() {
        try (Session session=sessionFactory.openSession()){
            Query query = session.createQuery("select count(*) from Order o where o.status = :status");
            query.setParameter("status", Strings.processingStatus);
            Long count = (Long) query.uniqueResult();
            return count.intValue();
        }
        catch (Exception e){
            e.printStackTrace();

        }
        return -1;
    }
    public int countCancelledOrders() {
        try (Session session=sessionFactory.openSession()){
            Query query = session.createQuery("select count(*) from Order o where o.status = :status");
            query.setParameter("status", Strings.cancelledStatus);
            Long count = (Long) query.uniqueResult();
            return count.intValue();
        }
        catch (Exception e){
            e.printStackTrace();

        }
        return -1;
    }
    public int countDeliveredOrders() {
        try (Session session=sessionFactory.openSession()){
            Query query = session.createQuery("select count(*) from Order o where o.status = :status");
            query.setParameter("status", Strings.deleveredStatus);
            Long count = (Long) query.uniqueResult();
            return count.intValue();
        }
        catch (Exception e){
            e.printStackTrace();

        }
        return -1;
    }

    public List<Item> getOrderItems(int id){
        List<Item> items=new ArrayList<>();
        try (Session session = sessionFactory.openSession()) {
            Order order = session.get(Order.class, id);
            items=order.getItems();
            System.out.println(items);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return items;
    }
}
