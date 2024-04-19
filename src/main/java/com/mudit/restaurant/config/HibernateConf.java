package com.mudit.restaurant.config;


import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.orm.hibernate5.HibernateTransactionManager;
import org.springframework.orm.hibernate5.LocalSessionFactoryBean;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import javax.sql.DataSource;
import java.util.Properties;

@Configuration
@ComponentScan("com.mudit.restaurant")
public class HibernateConf {

    @Bean
    public LocalSessionFactoryBean sessionFactory() {
        LocalSessionFactoryBean sessionFactory = new LocalSessionFactoryBean();
        sessionFactory.setDataSource(getDataSource());
        sessionFactory.setPackagesToScan("com.mudit.restaurant");
        sessionFactory.setHibernateProperties(hibernateProperties());
        return sessionFactory;
    }

    @Bean
    public DataSource getDataSource(){
        DriverManagerDataSource driverManagerDataSource = new DriverManagerDataSource();
        driverManagerDataSource.setUrl("jdbc:mysql://srv1231.hstgr.io:3306/u756147391_restaurantdb");
        driverManagerDataSource.setUsername("u756147391_mudit");
        driverManagerDataSource.setPassword("Itsmebro@6");

//        driverManagerDataSource.setUrl("jdbc:mysql://localhost:3306/restaurantdb");
//        driverManagerDataSource.setUsername("mudit");
//        driverManagerDataSource.setPassword("itsmebro");
        driverManagerDataSource.setDriverClassName("com.mysql.cj.jdbc.Driver");
        return driverManagerDataSource;
    }

//    @Bean
//    public TransactionManager hibernateTransactionManager() {
//        HibernateTransactionManager transactionManager=new HibernateTransactionManager();
//        transactionManager.setSessionFactory(sessionFactory().getObject());
//        return transactionManager;
//    }

    private final Properties hibernateProperties() {
        Properties hibernateProperties = new Properties();
        hibernateProperties.setProperty(
                "hibernate.hbm2ddl.auto", "update");
        hibernateProperties.setProperty(
                "hibernate.dialect", "org.hibernate.dialect.MySQL8Dialect");
        hibernateProperties.setProperty(
                "hibernate.show_sql", "false");

        return hibernateProperties;
    }
}