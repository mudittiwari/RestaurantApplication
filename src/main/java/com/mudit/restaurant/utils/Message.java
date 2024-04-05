package com.mudit.restaurant.utils;

public class Message {
    private String title;
    private String desc;

    public Message(String title, String desc) {
        this.title = title;
        this.desc = desc;
    }
    public Message(){

    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }
}
