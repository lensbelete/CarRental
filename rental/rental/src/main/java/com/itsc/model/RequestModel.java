package com.itsc.model;

import java.sql.ResultSet;
import java.sql.SQLException;

import jakarta.servlet.http.HttpServletRequest;


public class RequestModel {
	public int id = 0;
	public int userId = 0;
	public int carId = 0;
	
	public String type =""; //new or month or remove
	
	public String startDate = "";
	public String endDate = "";
	
	public String status = ""; // pending or accepted or rejected
	public String timeStamp = "";
	
	public RequestModel(
			int id, int userId, int carId, String type, String startDate,
			String endDate, String status, String timeStamp
		){
		this.id = id;
		this.userId = userId;
		this.carId = carId;
		
		this.type = type;
		
		this.startDate = startDate;
		this.endDate = endDate;
		
		this.status = status;
		this.timeStamp = timeStamp;
	}
	
	public static RequestModel fromResultSet(ResultSet rs) throws SQLException {
		
		return new RequestModel(				
				rs.getInt(1),
				rs.getInt(2),
				rs.getInt(3),
				
				rs.getString(4),
				
				rs.getString(5),
				rs.getString(6),
				
				rs.getString(7),
				rs.getString(8)
				);
	}
	
	public static RequestModel fromRequest(HttpServletRequest req) {
		int id = 0;
		String maybeId = req.getParameter("id");
		if(maybeId != null) id = Integer.parseInt(maybeId);
		
		
		return new RequestModel(
				id,
				Integer.parseInt(req.getParameter("userId")),
				Integer.parseInt(req.getParameter("carId")),
				
				req.getParameter("type"),
				
				req.getParameter("startDate"),
				req.getParameter("endDate"),
				
				req.getParameter("status"),
				null
		);
	}
	
	public String toString() {
		return "id: " + id + " " +
				"userId: " + userId + " " +
				"carId: " + carId + " " +
				"type: " + type + " " +
				"startDate: " + startDate + " " +
				"endDate: " + endDate + " " +
				"status: " + status + " " +
				"timeStamp: "+timeStamp;
	}
	
}
