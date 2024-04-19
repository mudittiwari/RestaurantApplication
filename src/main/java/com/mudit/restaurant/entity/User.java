package com.mudit.restaurant.entity;

import org.hibernate.validator.constraints.Length;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Entity
@Table(name = "users")
public class User {
    @Id
    private String username;

    @Length(min = 5,max = 40,message = "name validation failed")
    private String name;



    @Length(min = 8,message = "password validation failed")
    private String password;

    private boolean enabled;

    @Length(min = 10,max = 10,message = "Phone Number validation failed")
    private String mobileNumber;

    @OneToOne(cascade = CascadeType.ALL)
    private Authority authority;

    @ManyToMany(fetch = FetchType.EAGER)
    private List<Item> favourites=new ArrayList<>();

    public List<Item> getFavourites() {
        return favourites;
    }

    public void setFavourites(List<Item> favourites) {
        this.favourites = favourites;
    }

    public boolean isEnabled() {
        return enabled;
    }

    public void setEnabled(boolean enabled) {
        this.enabled = enabled;
    }

    public String getName() {
        return name;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getMobileNumber() {
        return mobileNumber;
    }

    public void setMobileNumber(String mobileNumber) {
        this.mobileNumber = mobileNumber;
    }

    public Authority getAuthority() {
        return authority;
    }

    public void setAuthority(Authority authority) {
        this.authority = authority;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @Override
    public String toString() {
        return "User{" +
                "username='" + username + '\'' +
                ", name='" + name + '\'' +
                ", password='" + password + '\'' +
                ", enabled=" + enabled +
                ", mobileNumber='" + mobileNumber + '\'' +
                ", authority=" + authority +
                '}';
    }

}
