package com.itsc.model;

import java.sql.*;

import jakarta.servlet.http.HttpServletRequest;

public class CarModel {
	
	public int id = 0;
	public String model = "";
	public int rentalFee = 0;
	public String photo = "";
	public String addDate = "";
	
	public int ownerId = 0;
	public String startDate = "";
	public String endDate = "";
	
	public CarModel(
			int id, String model, int rentalFee, String photo, String addDate,
			int ownerId, String startDate, String endDate
		){
		this.id = id;
		this.model = model;
		this.rentalFee = rentalFee;
		this.photo = photo;
		this.addDate = addDate;
		
		this.ownerId = ownerId;
		this.startDate = startDate;
		this.endDate = endDate;
	}
	
	public static CarModel fromResultSet(ResultSet rs) throws SQLException {
		
		return new CarModel(
				rs.getInt(1),
				rs.getString(2),
				rs.getInt(3),
				rs.getString(4),
				rs.getString(5),
				
				rs.getInt(6),
				rs.getString(7),
				rs.getString(8)
		);
		
	}
	
	public static CarModel fromRequest(HttpServletRequest req) {
		int id = 0;
		Object maybeId = req.getParameter("id");
		if(maybeId != null) id = (int) maybeId;
		
		int ownerId = 0;
		Object maybeOwnerId = req.getParameter("ownerId");
		if(maybeOwnerId != null) ownerId = (int) maybeOwnerId;
		
		
		return new CarModel(
		id,
		req.getParameter("model"),
		Integer.parseInt(req.getParameter("rentalFee")),
		req.getParameter("photo"),
		req.getParameter("addDate"),
		
		
		 ownerId,
		 req.getParameter("startDate"),
		 req.getParameter("endDate")
		);
	}
	
	public String toString() {
		return "id: " + id + " " +
				"model: " + model + " " +
				"rentalFee: " + rentalFee + " " +
				"photo: " + photo + " " +
				"addDate: " + addDate + " " +
				"ownerId: " + ownerId + " " +
				"startDate: " + startDate + " " +
				"endDate: " + endDate + " " ;
	}

}
