package com.mudit.restaurant.controllers;


import com.mudit.restaurant.entity.Category;
import com.mudit.restaurant.entity.Item;
import com.mudit.restaurant.entity.User;
import com.mudit.restaurant.services.UserService;
import com.mudit.restaurant.utils.Message;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.validation.Valid;
import java.util.List;

@Controller
public class MainController {
    @Autowired
    private UserService service;
    @Autowired
    private AuthenticationManager authenticationManagerBean;
    @ModelAttribute("user")
    public User newUser() {
        return new User();
    }

    @RequestMapping("/")
    public String home(Model model){
        List<Item> discountedItems=service.getDiscountedItems();
        model.addAttribute("discountedItems",discountedItems);
        return "discount";
    }
    @RequestMapping("/signup")
    public String signup(){
        return "signup";
    }
    @RequestMapping("/dashboard")
    public String dashboard(Model model){
        List<Item> featuredItems=service.getFeaturedItems();
        System.out.println(featuredItems);
        model.addAttribute("featuredItems",featuredItems);
        return "user_dashboard";
    }
    @RequestMapping("/items/{id}")
    public String items(@PathVariable("id") int id, Model model){
        List<Item> items=service.getCategoryItems(id);
        List<Category> categories=service.getCategories();
        System.out.println(items);
        model.addAttribute("items",items);
        model.addAttribute("categories",categories);
        return "useritems";
    }
    @RequestMapping("/submitsignup")
    public String submitSignup(@Valid @ModelAttribute("user") User user, BindingResult bindingResult, RedirectAttributes attributes){
        if(bindingResult.hasErrors()){
            attributes.addFlashAttribute("org.springframework.validation.BindingResult.user", bindingResult);
            attributes.addFlashAttribute("user", user);
//            System.out.println(bindingResult.getFieldErrors());
            return "redirect:/signup";
        }
        if(service.addUser(user)) {
            Message message=new Message();
            message.setTitle("Success");
            message.setDesc("Signed up successfully, you can now login using your email and password.");
            attributes.addFlashAttribute("message",message);
            return "redirect:/login";
        }
        return "signup";
    }

    @RequestMapping(value = "/login",method = RequestMethod.GET)
    public String login(){
        return "login";
    }

//    @RequestMapping(value = "/login",method = RequestMethod.POST)
//    public String submitLogin(@RequestParam("email") String email,@RequestParam("password") String password){
//        System.out.println("hello world");
////        Authentication authentication = new UsernamePasswordAuthenticationToken(email, password);
////        authentication = authenticationManagerBean.authenticate(authentication);
////        System.out.println(authentication.isAuthenticated());
////        SecurityContextHolder.getContext().setAuthentication(authentication);
//        return "homepage";
//    }

}
