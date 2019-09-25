package com.my.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.my.exception.NotFoundException;

public class ZipDAO {
	
	public List<Map<String, String>> selectByDoro(String doro) throws NotFoundException{
			Connection conn = null;
			ResultSet rs = null;
			PreparedStatement stmt = null;
			String SQL = "SELECT buildingno, zipcode,  sido||' '|| sigungu ||NVL2(sigungu,' ', '')|| eupmyun ||NVL2(eupmyun,' ', '')|| doro ||' '|| building1|| DECODE(building2,'0', '', '-'||building2) ||' ' || '('|| dong || ri || DECODE(building, '', '', ',' ||building) ||')' as 도로명주소, sido ||' '|| sigungu ||NVL2(sigungu,' ', '')|| eupmyun ||NVL2(eupmyun,' ', '')|| dong || ri ||' ' ||  zibun1 || DECODE(zibun2, '0', '',  '-'|| zibun2)    || DECODE(building, '', '', ' (' ||building ||')') as 지번주소 FROM post WHERE (doro || ' ' || building1 || DECODE(building2,'0', '', '-'||building2)) like ?";
			List<Map<String,String>> list = new ArrayList<Map<String,String>>();
			

			try {
				Class.forName("oracle.jdbc.driver.OracleDriver");
				conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "ora_user", "password");

				stmt = conn.prepareStatement(SQL);
				stmt.setString(1, "%"+doro+"%");
				rs = stmt.executeQuery();
				
				while (rs.next()) {//id 중복
					Map<String, String> map  = new HashMap<String, String>();
					map.put("zipcode",rs.getString("zipcode"));
					map.put("doromyoung",rs.getString("도로명주소"));
					map.put("zibun", rs.getString("지번주소"));
					map.put("buildingno", rs.getString("buildingno"));
					
					list.add(map);
				}
				if(list.size()==0) {
					throw new NotFoundException("데이터가 없습니다.");					
				}
				return list;
				
			} catch (ClassNotFoundException|SQLException e) {
				throw new NotFoundException(e.getMessage());
			} finally {
				try {
					if (stmt != null && !stmt.isClosed())
						stmt.close();
					if (rs != null && !rs.isClosed())
						stmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
	}
}
