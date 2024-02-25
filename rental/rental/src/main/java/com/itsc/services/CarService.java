package com.itsc.services;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.time.format.DateTimeFormatter;

import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory;

import com.itsc.model.*;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.Part;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;




public class CarService {
	// MODIFY THIS: The absolute path to /rental/src/main/webapp/photos on YOUR computer
	//public static String photoFolderPath = ":C \\ users\h ... \\rental\\src\\main\\webapp\\photos";
	//public static String photoFolderPath = ":C \\ users\\l ... \\rental\\src\\main\\webapp\\photos";
	public static String photoFolderPath = "/home/yz/manual/eclipse/space/rental/src/main/webapp/photos";
	
	
	public static String jspPhotoFolderPath = "/rental/photos";
	
	public static String getPhotoPath(CarModel car) {
		return jspPhotoFolderPath + File.separator + car.photo;
	}
	
    public static String[] todayAndNextMonth() {
        LocalDate today = LocalDate.now();
        LocalDate nextMonth = today.plusMonths(1);
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        String[] dates = {today.format(formatter), nextMonth.format(formatter)};
        return dates;
    }
	
	
	public static long totalFee(CarModel car) {
        LocalDate date1 = LocalDate.parse(car.startDate);
        LocalDate date2 = LocalDate.parse(car.endDate);
        long daysBetween = ChronoUnit.DAYS.between(date1, date2);
        return daysBetween*car.rentalFee;
	}
	
	public static String savePhotoAndGetName(HttpServletRequest request) throws IOException, ServletException {
    	String randomName = Integer.toString((int)(Math.random()*10000));
    	String fileName = "--";
    	for (Part part : request.getParts()) {
    	    fileName = part.getSubmittedFileName();
    	    fileName = randomName + "." + fileName;
    	    String uploadPath = CarService.photoFolderPath 
        			+ File.separator 
        			+ fileName;
    	    
    	    part.write(uploadPath);
    	    break;
    	}
    	
    	return fileName;
	}
	
	public static  int own(RequestModel r) throws SQLException, ClassNotFoundException {
		
		Connection con = DBConnection.getConnection();
		PreparedStatement ps = con.prepareStatement(
			"UPDATE car "
			+ "SET owner_id=?, start_date=?, end_date=? " 
			+ " WHERE id = ?");
		
		ps.setInt(1, r.userId);
		ps.setString(2, r.startDate);
		ps.setString(3, r.endDate);
		ps.setInt(4,  r.carId);
		
		return ps.executeUpdate();
	}
	
	public static int disOwn(int id) throws SQLException, ClassNotFoundException {
		
		Connection con = DBConnection.getConnection();
		PreparedStatement ps = con.prepareStatement(
			"UPDATE car "
			+ "SET owner_id=?, start_date=?, end_date=? " 
			+ "WHERE id = ?");
		
		ps.setNull(1, Types.INTEGER);
		ps.setNull(2, Types.VARCHAR);
		ps.setNull(3, Types.VARCHAR);
		ps.setInt(4, id);
		
		
		return ps.executeUpdate();
	}
	
	public static int updateRentalFee(int id, int fee) throws SQLException, ClassNotFoundException {
		Connection con = DBConnection.getConnection();
		PreparedStatement ps = con.prepareStatement(
			"UPDATE car SET rental_fee = ?  WHERE id = ?");
		
		ps.setInt(1, fee);
		ps.setInt(2, id);
		
		return ps.executeUpdate();
	}
	
	public static int updateEndDate(int id, String endDate) throws SQLException, ClassNotFoundException {
		Connection con = DBConnection.getConnection();
		PreparedStatement ps = con.prepareStatement(
			"UPDATE car SET end_date = ?  WHERE id = ?");
		
		ps.setString(1, endDate);
		ps.setInt(2, id);
		
		return ps.executeUpdate();
	}
	
	public static int delete(int id) throws SQLException, ClassNotFoundException {
		Connection con = DBConnection.getConnection();
		PreparedStatement ps = con.prepareStatement(
			"DELETE FROM car WHERE id = ?");
		
		ps.setInt(1, id);		
		return ps.executeUpdate();
	}
	

	public static int save(CarModel car) throws SQLException, ClassNotFoundException {
		
		Connection con = DBConnection.getConnection();
		PreparedStatement ps = con.prepareStatement(
			"INSERT INTO car (model, rental_fee, photo) " +
			"VALUES (?, ?, ?);");
		
		ps.setString(1, car.model);
		ps.setInt(2, car.rentalFee);
		ps.setString(3, car.photo);
		
		return ps.executeUpdate();
	}
	
	public static ArrayList<CarModel> getUnOwnedByModel(String searchString, int userId) throws SQLException, ClassNotFoundException {
		System.out.println("here1");
		ArrayList<CarModel> list = new ArrayList<CarModel>();
		System.out.println("here2");
		
		Connection con = DBConnection.getConnection();
		PreparedStatement ps = con.prepareStatement(
				"SELECT DISTINCT c.* FROM car c "
				+ "LEFT JOIN request r ON c.id = r.car_id "
				+ "WHERE "
				//not owned AND (no pending request before me )
				+ "(c.owner_id IS NULL) AND "
				+ "(NOT (r.type IS 'new' AND r.status IS 'pending')) "
				+ "AND (c.model LIKE ?)");
		
		ps.setString(1,"%"+searchString+"%");
		
		ResultSet rs = ps.executeQuery();
		
		while (rs.next()) {
			list.add(CarModel.fromResultSet(rs));
		}
		return list;
	}
	
	
	public static CarModel get(int id) throws SQLException, ClassNotFoundException {
		Connection con = DBConnection.getConnection();
		PreparedStatement ps = con.prepareStatement(
		"SELECT * FROM car WHERE id = ?;");
		
		ps.setInt(1, id);
		ResultSet rs = ps.executeQuery();
		
		
		if (!rs.next()) return null;
		
		return CarModel.fromResultSet(rs);
		
	}
	
	public static ArrayList<CarModel> getCars() throws ClassNotFoundException, SQLException{
		ArrayList<CarModel> list = new ArrayList<CarModel>();
		
		Connection con = DBConnection.getConnection();
		PreparedStatement ps = con.prepareStatement("SELECT * FROM car ORDER BY id DESC;");
		ResultSet rs = ps.executeQuery();
		
		
		while (rs.next()) {
			list.add(CarModel.fromResultSet(rs));
		}
		
		return list;
	}
	
	
	public static ArrayList<CarModel> getUserCars(int owner_id) throws ClassNotFoundException, SQLException{
		ArrayList<CarModel> list = new ArrayList<CarModel>();
		
		Connection con = DBConnection.getConnection();
		PreparedStatement ps = con.prepareStatement(
		"SELECT * FROM car WHERE owner_id = ?;");
		
		ps.setInt(1, owner_id);
		ResultSet rs = ps.executeQuery();
		
		
		while (rs.next()) {
			list.add(CarModel.fromResultSet(rs));
		}
		System.out.println("#user cars" + list.size());
		return list;
	}
	
	
//	public static int saveEdit(CarModel user) throws ClassNotFoundException, SQLException {
//		Connection con = DBConnection.getConnection();
//		PreparedStatement ps = con.prepareStatement(
//		"UPDATE car "
//		+ "SET firstName=?, lastName=?, email=?, password=?, sex=? "
//		+ "WHERE id = ?;"
//		);
//		
//		ps.setString(1, user.firstName);
//		ps.setString(2, user.lastName);
//		ps.setString(3, user.email);
//		ps.setString(4, user.password);
//		ps.setString(5, user.sex);
//		ps.setInt(6, user.id);
//		
//		return ps.executeUpdate();
//		
//	}
}
