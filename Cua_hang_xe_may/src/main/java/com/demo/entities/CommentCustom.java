package com.demo.entities;

public class CommentCustom {
	private int id;
	private String accountId;
	private int productId;
	private String content;
	private String created;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getAccountId() {
		return accountId;
	}
	public void setAccountId(String accountId) {
		this.accountId = accountId;
	}
	public int getProductId() {
		return productId;
	}
	public void setProductId(int productId) {
		this.productId = productId;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getCreated() {
		return created;
	}
	public void setCreated(String created) {
		this.created = created;
	}
	public CommentCustom(int id, String accountId, int productId, String content, String created) {
		super();
		this.id = id;
		this.accountId = accountId;
		this.productId = productId;
		this.content = content;
		this.created = created;
	}
	public CommentCustom() {
		super();
	}
	@Override
	public String toString() {
		return "Comment [id=" + id + ", accountId=" + accountId + ", productId=" + productId + ", content=" + content
				+ ", created=" + created + "]";
	}
	
	
}
