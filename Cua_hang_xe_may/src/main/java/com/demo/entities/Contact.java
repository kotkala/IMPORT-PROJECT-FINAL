package com.demo.entities;

public class Contact {
	private int id;
	private String name;
	private String email;
	private String phone;
	private String content;
	public Contact(int id, String name, String email, String phone, String content) {
		super();
		this.id = id;
		this.name = name;
		this.email = email;
		this.phone = phone;
		this.content = content;
	}
	public Contact() {
		
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	@Override
	public String toString() {
		return "Contact [id=" + id + ", name=" + name + ", email=" + email + ", phone=" + phone + ", content=" + content
				+ "]";
	}
	
}
