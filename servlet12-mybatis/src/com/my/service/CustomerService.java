package com.my.service;

import org.json.simple.JSONObject;

import com.my.dao.CustomerDAO;
import com.my.exception.AddException;
import com.my.exception.NotFoundException;
import com.my.vo.Customer;

public class CustomerService {
	private CustomerDAO dao;

	public CustomerService() {
		dao = new CustomerDAO();
	}

	public String login(String id, String pwd) {
		int status = -1; // 로그인 실패

		try {
			Customer c = dao.selectById(id);
			if (c.getPwd().equals(pwd)) // 비밀번호 일치확인
				status = 1;// 로그인 성공
		} catch (NotFoundException e) {
			e.printStackTrace();
		}
		//String str = "{\"status\":" + status + ",\"id\":\"" + id + "\"}";
		JSONObject json = new JSONObject();
		json.put("status",status);
		json.put("id",id);
		String str = json.toString();
		return str;
	}

	public String dupchk(String id) {
		int status = -1; // 중복:1, 중복안됨:-1
		try {
			dao.selectById(id);
			status = 1; // id가 이미 존재함.
		} catch (NotFoundException e) {
			e.printStackTrace();
		}
		//String str = "{\"status\":" + status + "}";
		JSONObject json = new JSONObject();
		json.put("status",status);
		String str = json.toString();
		return str;
	}

	public String join(Customer c) {
		int status = 0; 
		try {
		status = dao.insertCustomer(c);
		
		//String str = "{\"status\":" + status + "}";
		JSONObject json = new JSONObject();
		json.put("status",status);
		
		String str = json.toString();
		return str;
		
		}catch(AddException e) {
			return("{\"status\":-1}");
			}

	}
}
