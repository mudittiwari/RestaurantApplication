package com.mudit.restaurant.repository;


import com.mudit.restaurant.entity.User;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

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
}
