package com.mudit.restaurant.controllers;


import com.mudit.restaurant.constants.Strings;
import com.mudit.restaurant.entity.Category;
import com.mudit.restaurant.entity.Item;
import com.mudit.restaurant.entity.Order;
import com.mudit.restaurant.entity.User;
import com.mudit.restaurant.services.UserService;
import com.mudit.restaurant.utils.Message;
import org.aspectj.weaver.ast.Or;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.util.*;

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
        System.out.println(discountedItems);
        model.addAttribute("discountedItems",discountedItems);
        return "discount";
    }
    @RequestMapping("/discount")
    public String discount(Model model){
        List<Item> discountedItems=service.getDiscountedItems();
        System.out.println(discountedItems);
        model.addAttribute("discountedItems",discountedItems);
        return "discount";
    }
    @RequestMapping("/signup")
    public String signup(){
        return "signup";
    }
    @RequestMapping("/dashboard")
    public String dashboard(Model model){
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.isAuthenticated() && authentication.getPrincipal() instanceof UserDetails) {
            UserDetails userDetails = (UserDetails) authentication.getPrincipal();
            String username = userDetails.getUsername();
            List<Item> favItems=service.getFavouriteItems(username);
            model.addAttribute("favourites",favItems);
            List<Item> featuredItems=service.getFeaturedItems();
            model.addAttribute("featuredItems",featuredItems);
        }
        return "user_dashboard";
    }
    @RequestMapping("/items")
    public String allItems(Model model){
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.isAuthenticated() && authentication.getPrincipal() instanceof UserDetails) {
            UserDetails userDetails = (UserDetails) authentication.getPrincipal();
            String username = userDetails.getUsername();
            Map<String, List<Item>> items = new HashMap<>();
            List<Category> categories = service.getCategories();
            for (int i = 0; i < categories.size(); i++) {
                String category = categories.get(i).getName();
                int categoryId = categories.get(i).getId();
                List<Item> categoryItems = service.getCategoryItems(categoryId);
                items.put(category, categoryItems);
            }
            List<Item> favItems = service.getFavouriteItems(username);
            model.addAttribute("favourites", favItems);
            model.addAttribute("items", items);
        }
        return "allitems";
    }
    @RequestMapping("/items/{id}")
    public String items(@PathVariable("id") int id, Model model){
        List<Item> items=service.getCategoryItems(id);
        List<Category> categories=service.getCategories();
        System.out.println(items);
        model.addAttribute("items",items);
        model.addAttribute("categories",categories);
        return "categoryitems";
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

    @RequestMapping("/favourite")
    public String favourites(Model model){
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.isAuthenticated() && authentication.getPrincipal() instanceof UserDetails) {
            UserDetails userDetails = (UserDetails) authentication.getPrincipal();
            String username = userDetails.getUsername();
            List<Item> favItems=service.getFavouriteItems(username);
            model.addAttribute("favourites",favItems);
        }
        return "favourite";
    }
    @RequestMapping("/addfavourite/{id}")
    public String addFavourites(@PathVariable("id") int id,RedirectAttributes attributes){
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.isAuthenticated() && authentication.getPrincipal() instanceof UserDetails) {
            UserDetails userDetails = (UserDetails) authentication.getPrincipal();
            String username = userDetails.getUsername();
            if(service.addFavItem(id,username)){
                Message message = new Message();
                message.setTitle("Success");
                message.setDesc("Item added to favourites successfully");
                attributes.addFlashAttribute("message", message);
            }
            else{
                Message message = new Message();
                message.setTitle("Error");
                message.setDesc("Error occoured while adding the item to favourites");
                attributes.addFlashAttribute("message", message);
            }

        }
        else {
            Message message = new Message();
            message.setTitle("Error");
            message.setDesc("Error occoured while adding the item to favourites");
            attributes.addFlashAttribute("message", message);
        }
        return "redirect:/dashboard";
    }
    @RequestMapping("/removefavourite/{id}")
    public String removeFavourites(@PathVariable("id") int id,RedirectAttributes attributes){
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.isAuthenticated() && authentication.getPrincipal() instanceof UserDetails) {
            UserDetails userDetails = (UserDetails) authentication.getPrincipal();
            String username = userDetails.getUsername();
            if(service.removeFavItem(id,username)){
                Message message = new Message();
                message.setTitle("Success");
                message.setDesc("Item removed from favourites successfully");
                attributes.addFlashAttribute("message", message);
            }
            else{
                Message message = new Message();
                message.setTitle("Error");
                message.setDesc("Error occurred while removing the item from favourites");
                attributes.addFlashAttribute("message", message);
            }

        }
        else {
            Message message = new Message();
            message.setTitle("Error");
            message.setDesc("Error occurred while removing the item from favourites");
            attributes.addFlashAttribute("message", message);
        }
        return "redirect:/dashboard";
    }


    @RequestMapping("/addtocart/{id}")
    public String addToCart(@PathVariable("id") int id, RedirectAttributes attributes, HttpServletRequest request){
        String referer = request.getHeader("referer");
        System.out.println(referer);
        Item item=service.getItemById(id);
        if(service.addCartItem(item,request.getSession())){
            Message message = new Message();
            message.setTitle("Success");
            message.setDesc("Item added to cart successfully");
            attributes.addFlashAttribute("message", message);
        }
        else{
            Message message = new Message();
            message.setTitle("Error");
            message.setDesc("Error occoured while adding the item to cart");
            attributes.addFlashAttribute("message", message);
        }
        return "redirect:" + referer;
    }



    @RequestMapping("/removefromcart/{id}")
    public String removeFromCart(@PathVariable("id") int id, RedirectAttributes attributes, HttpServletRequest request){
        String referer = request.getHeader("referer");
        System.out.println(referer);
        Item item=service.getItemById(id);
        if(service.removeCartItem(item,request.getSession())){
            Message message = new Message();
            message.setTitle("Success");
            message.setDesc("Item removed from cart successfully");
            attributes.addFlashAttribute("message", message);
        }
        else{
            Message message = new Message();
            message.setTitle("Error");
            message.setDesc("Error occoured while removing the item from cart");
            attributes.addFlashAttribute("message", message);
        }
        return "redirect:" + referer;
    }

    @RequestMapping("/addorder")
    public String addOrder(@RequestParam("tableNumber") int tableNumber, HttpServletRequest request,RedirectAttributes attributes){
        String referer = request.getHeader("referer");
        System.out.println(tableNumber);
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.isAuthenticated() && authentication.getPrincipal() instanceof UserDetails) {
            UserDetails userDetails = (UserDetails) authentication.getPrincipal();
            String username = userDetails.getUsername();
            HttpSession session = request.getSession();
            Map<Item, Integer> cart = (Map<Item, Integer>) session.getAttribute("cart");
            List<Item> itemsList=new ArrayList<>();
            double totalPrice=0;
            if (cart != null) {

                for (Map.Entry<Item, Integer> entry : cart.entrySet()) {
                    Item item = entry.getKey();
                    Integer quantity = entry.getValue();
                    totalPrice+=item.getDiscountedPrice()*quantity;
                    for (int i = 0; i < quantity; i++) {
                        itemsList.add(item);
                    }
                }
                User user=service.getUserByUsername(username);
                Order order=new Order();
                order.setItems(itemsList);
                order.setStatus(Strings.processingStatus);
                order.setUser(user);
                order.setCreatedAt(new Date());
                order.setTableNumber(tableNumber);
                order.setTotalPrice(totalPrice);
                if(service.addOrder(order)){
                    Message message = new Message();
                    message.setTitle("Success");
                    message.setDesc("Order has been placed successfully");
                    attributes.addFlashAttribute("message", message);
                }
                else{
                    Message message = new Message();
                    message.setTitle("Error");
                    message.setDesc("Error occoured while placing the order");
                    attributes.addFlashAttribute("message", message);
                }
            }
        }
        return "redirect:" + referer;
    }

    @RequestMapping("/orders")
    public String getOrders(Model model,RedirectAttributes attributes){
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.isAuthenticated() && authentication.getPrincipal() instanceof UserDetails) {
            UserDetails userDetails = (UserDetails) authentication.getPrincipal();
            String username = userDetails.getUsername();
            List<Order> orders=service.getUserOrders(username);
            for (int i=0;i<orders.size();i++){
                if(orders.get(i).getItems().size()>1)
                    System.out.println(orders.get(i).getItems());
            }
            model.addAttribute("orders",orders);
            System.out.println(orders);
        }

        else {
            Message message = new Message();
            message.setTitle("Error");
            message.setDesc("Error occoured while getting the orders");
            attributes.addFlashAttribute("message", message);
        }
        return "orderhistory";
    }
}
