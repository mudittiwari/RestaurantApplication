package com.mudit.restaurant.controllers;


import com.mudit.restaurant.constants.Strings;
import com.mudit.restaurant.entity.Category;
import com.mudit.restaurant.entity.Item;
import com.mudit.restaurant.entity.Order;
import com.mudit.restaurant.entity.User;
import com.mudit.restaurant.services.AdminService;
import com.mudit.restaurant.utils.Message;
import org.hibernate.validator.constraints.Length;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.validation.ConstraintViolation;
import javax.validation.Valid;
import javax.validation.Validator;
import javax.validation.constraints.Min;
import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.Set;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private AdminService adminService;
    @Autowired
    private HttpServletRequest request;

    @ModelAttribute("category")
    public Category newCategory() {
        return new Category();
    }
    @ModelAttribute("item")
    public Item newItem() {
        return new Item();
    }

    @RequestMapping("/")
    public String home(Model model){
        long itemCount= adminService.getItemCount();
        long categoryCount= adminService.getCategoryCount();
        long userCount= adminService.getUserCount();
        model.addAttribute("itemCount",itemCount);
        model.addAttribute("categoryCount",categoryCount);
        model.addAttribute("userCount",userCount);
        return "dashboard";
    }

    @RequestMapping("/category")
    public String category(Model model){
        List<Category> categories = adminService.getCategories();
        model.addAttribute("categories", categories);
        return "category";
    }

    @RequestMapping("/addcategory")
    public String addCategory(@Valid @ModelAttribute("category") Category category, BindingResult bindingResult, RedirectAttributes attributes, Model model){
        if(bindingResult.hasErrors()){
            attributes.addFlashAttribute("org.springframework.validation.BindingResult.category", bindingResult);
            attributes.addFlashAttribute("category", category);
            return "redirect:/admin/category";
        } else {
            if (adminService.addCategory(category)) {
                Message message = new Message();
                message.setTitle("Success");
                message.setDesc("Category added successfully.");
                attributes.addFlashAttribute("message", message);
            }
            else{
                Message message = new Message();
                message.setTitle("Error");
                message.setDesc("Error occoured while saving the item");
                attributes.addFlashAttribute("message", message);
        }
        }
        return "redirect:/admin/category";
    }



    @RequestMapping("/orders")
    public String orders(Model model){
        List<Order> orders=adminService.getOrders();
        model.addAttribute("orders",orders);
        return "orders";
    }

    @RequestMapping("/items")
    public String items(Model model){

        List<Item> items=adminService.getItems();
        model.addAttribute("items",items);
        return "items";
    }

    @RequestMapping(value = "/additem",method = RequestMethod.GET)
    public String addItem(Model model){
        List<Category> categories=adminService.getCategories();
        model.addAttribute("categories", categories);
        return "additem";
    }

    @RequestMapping(value = "/additem",method = RequestMethod.POST)
    public String addItem(@RequestParam("image") MultipartFile image,
                              @RequestParam("name") String name,
                              @RequestParam("desc")  String desc,
                              @RequestParam("price")  double price,
                              @RequestParam("discountedprice") double discountedPrice,
                              @RequestParam("category") String categoryId,
                              RedirectAttributes attributes){
        System.out.println(image);
        if(name.length()<5){
            attributes.addFlashAttribute("nameerror","Name length too short");
        }
        if(desc.length()<5){
            attributes.addFlashAttribute("descerror","Description length too short");
        }
        if(price<0){
            attributes.addFlashAttribute("priceerror","price can't be less than zero");
        }
        if(discountedPrice<0){
            attributes.addFlashAttribute("discountedpriceerror","discounted price can't be less than zero");
        }
        if(discountedPrice>price){
            attributes.addFlashAttribute("discountedpriceerror","discounted price can't be greater than actual price");
        }

        if(categoryId.isEmpty() || Integer.parseInt(categoryId)==-1){
            attributes.addFlashAttribute("categoryerror","category can't be empty");
        }
        if(attributes.getFlashAttributes().isEmpty()){
            if (!image.isEmpty()) {
                try {
                    String uploadsDir = "/uploads/";
                    String realPathtoUploads = request.getServletContext().getRealPath(uploadsDir);
                    if (!new File(realPathtoUploads).exists()) {
                        new File(realPathtoUploads).mkdir();
                    }
                    String orgName = image.getOriginalFilename();
                    String filePath = realPathtoUploads + orgName;
                    File dest = new File(filePath);
                    image.transferTo(dest);
                    System.out.println(orgName);
                    Item item=new Item();
                    Category category=adminService.getCategory(Integer.parseInt(categoryId));
                    System.out.println(category.getName());
                    item.setName(name);
                    item.setDescription(desc);
                    item.setCategory(category);
                    item.setPrice(price);
                    item.setDiscountedPrice(discountedPrice);
                    item.setImage("/uploads/".concat(orgName));
                    System.out.println(item);
                    if(adminService.addItem(item)) {
                        Message message=new Message();
                        message.setTitle("Success");
                        message.setDesc("Item added successfully");
                        attributes.addFlashAttribute("message", message);
                    }
                    else {
                        Message message = new Message();
                        message.setTitle("Error");
                        message.setDesc("Error occoured while saving the item");
                        attributes.addFlashAttribute("message", message);
                    }
                } catch (Exception e) {
                    Message message = new Message();
                    message.setTitle("Error");
                    message.setDesc("Error occoured while saving the item");
                    attributes.addFlashAttribute("message", message);
                    e.printStackTrace();
                }
            }
        }
        return "redirect:/admin/additem";
    }




    @RequestMapping(value = "/edititem/{id}",method = RequestMethod.GET)
    public String editItem(@PathVariable("id") int id, Model model){
        Item item=adminService.getItem(id);
        List<Category> categories=adminService.getCategories();
        model.addAttribute("categories", categories);
        model.addAttribute("item",item);
        return "edititem";
    }

    @RequestMapping(value = "/edititem",method = RequestMethod.POST)
    public String editItemPost(@RequestParam("id") int id,
                           @RequestParam("image") MultipartFile image,
                              @RequestParam("name") String name,
                              @RequestParam("desc")  String desc,
                              @RequestParam("price")  double price,
                               @RequestParam("discountedprice") double discountedPrice,
                              @RequestParam("category") String categoryId,
                              RedirectAttributes attributes){
        System.out.println(discountedPrice);
        if(name.length()<5){
            attributes.addFlashAttribute("nameerror","Name length too short");
        }
        if(desc.length()<5){
            attributes.addFlashAttribute("descerror","Description length too short");
        }
        if(price<0){
            attributes.addFlashAttribute("priceerror","price can't be less than zero");
        }
        if(discountedPrice<0){
            attributes.addFlashAttribute("discountedpriceerror","discounted price can't be less than zero");
        }
        if(discountedPrice>price){
            attributes.addFlashAttribute("discountedpriceerror","discounted price can't be greater than actual price");
        }
        if(categoryId.isEmpty() || Integer.parseInt(categoryId)==-1){
            attributes.addFlashAttribute("categoryerror","category can't be empty");
        }
        if(attributes.getFlashAttributes().isEmpty()){
            if (!image.isEmpty()) {
                try {
                    String uploadsDir = "/uploads/";
                    String realPathtoUploads = request.getServletContext().getRealPath(uploadsDir);
                    if (!new File(realPathtoUploads).exists()) {
                        new File(realPathtoUploads).mkdir();
                    }
                    String orgName = image.getOriginalFilename();
                    String filePath = realPathtoUploads + orgName;
                    File dest = new File(filePath);
                    image.transferTo(dest);
                    System.out.println(orgName);
                    Item item=new Item();
                    Category category=adminService.getCategory(Integer.parseInt(categoryId));
                    item.setId(id);
                    item.setName(name);
                    item.setDescription(desc);
                    item.setCategory(category);
                    item.setPrice(price);
                    item.setDiscountedPrice(discountedPrice);
                    item.setImage("/uploads/".concat(orgName));
                    System.out.println(item);
                    if(adminService.editItem(item)) {
                        Message message=new Message();
                        message.setTitle("Success");
                        message.setDesc("Item updated successfully");
                        attributes.addFlashAttribute("message", message);
                    }
                    else {
                        Message message = new Message();
                        message.setTitle("Error");
                        message.setDesc("Error occoured while updating the item");
                        attributes.addFlashAttribute("message", message);
                    }
                } catch (Exception e) {
                    Message message = new Message();
                    message.setTitle("Error");
                    message.setDesc("Error occoured while updating the item");
                    attributes.addFlashAttribute("message", message);
                    e.printStackTrace();
                }
            }
        }
        return "redirect:/admin/edititem/" + id;
    }

    @RequestMapping("/deleteitem/{id}")
    public String deleteItem(@PathVariable("id") int id,RedirectAttributes attributes){
        if(adminService.deleteItem(id)){
            Message message = new Message();
            message.setTitle("Success");
            message.setDesc("Item deleted successfully");
            attributes.addFlashAttribute("message", message);
        }
        else{
            Message message = new Message();
            message.setTitle("Error");
            message.setDesc("Error occoured while deleting the item");
            attributes.addFlashAttribute("message", message);
        }
        return "redirect:/admin/items/";
    }

    @RequestMapping("/addfeatured/{id}")
    public String addFeatured(@PathVariable("id") int id,RedirectAttributes attributes){
        if(adminService.addFeatured(id)){
            Message message = new Message();
            message.setTitle("Success");
            message.setDesc("Item added as featured successfully");
            attributes.addFlashAttribute("message", message);
        }
        else{
            Message message = new Message();
            message.setTitle("Error");
            message.setDesc("Error occoured while adding the item as featured");
            attributes.addFlashAttribute("message", message);
        }
        return "redirect:/admin/items/";
    }
    @RequestMapping("/removefeatured/{id}")
    public String removeFeatured(@PathVariable("id") int id,RedirectAttributes attributes){
        if(adminService.removeFeatured(id)){
            Message message = new Message();
            message.setTitle("Success");
            message.setDesc("Item removed as featured successfully");
            attributes.addFlashAttribute("message", message);
        }
        else{
            Message message = new Message();
            message.setTitle("Error");
            message.setDesc("Error occoured while adding the item as removedm");
            attributes.addFlashAttribute("message", message);
        }
        return "redirect:/admin/items/";
    }
    @RequestMapping("/addinstock/{id}")
    public String addInStock(@PathVariable("id") int id,RedirectAttributes attributes){
        if(adminService.addInStock(id)){
            Message message = new Message();
            message.setTitle("Success");
            message.setDesc("Item added in stock successfully");
            attributes.addFlashAttribute("message", message);
        }
        else{
            Message message = new Message();
            message.setTitle("Error");
            message.setDesc("Error occoured while adding the item in stock");
            attributes.addFlashAttribute("message", message);
        }
        return "redirect:/admin/items/";
    }
    @RequestMapping("/removeinstock/{id}")
    public String removeInStock(@PathVariable("id") int id,RedirectAttributes attributes){
        if(adminService.removeInStock(id)){
            Message message = new Message();
            message.setTitle("Success");
            message.setDesc("Item removed from stock successfully");
            attributes.addFlashAttribute("message", message);
        }
        else{
            Message message = new Message();
            message.setTitle("Error");
            message.setDesc("Error occoured while removing the item from stock");
            attributes.addFlashAttribute("message", message);
        }
        return "redirect:/admin/items/";
    }

    @RequestMapping("/users")
    public String users(Model model){
        List<User> users=adminService.getUsers();
        model.addAttribute("users", users);
        return "users";
    }

    @RequestMapping("/deleteuser/{username}")
    public String deleteUser(@PathVariable("username") String username,RedirectAttributes attributes){
        if(adminService.deleteUser(username)){
            Message message = new Message();
            message.setTitle("Success");
            message.setDesc("User deleted successfully");
            attributes.addFlashAttribute("message", message);
        }
        else{
            Message message = new Message();
            message.setTitle("Error");
            message.setDesc("Error occoured while deleting the User");
            attributes.addFlashAttribute("message", message);
        }
        System.out.println(attributes.getFlashAttributes());
        return "redirect:/admin/users/";
    }

    @RequestMapping("/order/changestatus/{id}/{status}")
    public String editOrder(@PathVariable("id") int id,@PathVariable("status") String status,HttpServletRequest request,RedirectAttributes attributes){
        String referer = request.getHeader("referer");
        boolean flag=false;
        if(status.equals(Strings.preparingStatus)){
            flag= adminService.editOrder(id,Strings.preparingStatus);
        }
        else if(status.equals(Strings.cancelledStatus)){
            flag= adminService.editOrder(id,Strings.cancelledStatus);
        }
        else if(status.equals(Strings.deleveredStatus)){
            flag= adminService.editOrder(id,Strings.deleveredStatus);
        }
        if(flag){
            Message message = new Message();
            message.setTitle("Success");
            message.setDesc("Order status changed to "+status+" successfully");
            attributes.addFlashAttribute("message", message);
        }

        return "redirect:" + referer;
    }
}

