package com.my.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.my.exception.AddException;
import com.my.exception.NotFoundException;
import com.my.vo.Customer;
import com.my.vo.Post;

public class CustomerDAO {
	// public String[] selectById(String id) {}

	public Customer selectById(String id) throws NotFoundException {
		Connection conn = null;
		ResultSet rs = null;
		PreparedStatement stmt = null;

		String SQL = "select * from customer where id = ?";
		
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "ora_user", "password");

			stmt = conn.prepareStatement(SQL);
			stmt.setString(1, id);

			rs = stmt.executeQuery();			
			
			if (rs.next()) {
				Customer c = new Customer();
				c.setId(rs.getString("id"));
				c.setPwd(rs.getString("pwd"));
				c.setName(rs.getString("name"));
				c.setAddr(rs.getString("addr"));
				Post p = new Post();
				p.setBuildingno(rs.getString("buildingno"));
				c.setPost(p);
				return c;
			}
			throw new NotFoundException("아이디가 존재하지 않습니다.");
		} catch (Exception e) {
			// 사용자 정의 강제 Exception
			throw new NotFoundException(e.getMessage());
		} finally {
			try {
				conn.close();
				rs.close();
				stmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

	}

	public int insertCustomer(Customer c) throws AddException {
		Connection conn = null;
		int rs = 0;
		PreparedStatement stmt = null;
		
		String SQL = "insert into customer values(?,?,?,?,?)";
		
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "ora_user", "password");

			stmt = conn.prepareStatement(SQL);
			stmt.setString(1, c.getId());
			stmt.setString(2, c.getPwd());
			stmt.setString(3, c.getName());
			stmt.setString(4, c.getPost().getBuildingno());
			stmt.setString(5, c.getAddr());

			rs = stmt.executeUpdate();
			conn.close();
			
		} catch (ClassNotFoundException e) {
			throw new AddException(e.getMessage());
		} catch (SQLException e) {
			throw new AddException(e.getMessage());
		} finally {
			try {
				stmt.close();
				//conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return (rs); // 1이면 변경 완료

	}

}
