package com.mudit.restaurant.controllers;


import com.mudit.restaurant.entity.User;
import com.mudit.restaurant.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.validation.Valid;

@Controller
public class MainController {
    @Autowired
    private UserService service;

    @RequestMapping("/")
    public String home(){
        return "homepage";
    }
    @RequestMapping("/signup")
    public String signup(Model model){
        User user=new User();
        model.addAttribute(user);
        return "signup";
    }

    @RequestMapping("/submitsignup")
    public String submitSignup(@Valid @ModelAttribute User user, BindingResult bindingResult){
        if(bindingResult.hasErrors()){
            System.out.println(bindingResult.getFieldErrors().get(0).getDefaultMessage());
        }
        System.out.println(user.getName());
        System.out.println(service.addUser(user));
        return "signup";
    }



}
