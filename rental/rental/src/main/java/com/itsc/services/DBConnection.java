package com.itsc.services;


import java.io.File;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class DBConnection {
    private static Connection conn;
    

    public static Connection getConnection() throws ClassNotFoundException  {
    	
    	// MODIFY THIS: The absolute path to /rental/src/db.db on YOUR computer
    	//String dbPath = "/home/yz/manual/eclipse/space/rental/src/db.db";
    	//String dbPath = :C\\users\\l ... \\rental\\src\\db.db";
    	//String dbPath = :C\\users\\h \ ... \\rental\\src\\db.db";
    	String dbPath = "/home/yz/manual/eclipse/space/rental/src/db.db";
    	
    	
    	
        try {
            // Check if the connection is null before creating a new one
            if (conn == null || conn.isClosed()) {
            	Class.forName("org.sqlite.JDBC");
            	
            	
            	
                String url = "jdbc:sqlite:"+dbPath;

                //To make ON DELETE CASCADE work when car or user is deleted
                conn = DriverManager.getConnection(url);
                PreparedStatement ps = conn.prepareStatement("PRAGMA foreign_keys = ON;");
                ps.execute();
                
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Handle the exception appropriately in your application
        }
        return conn;
    }

    public static void closeConnection() {
        try {
            if (conn != null && !conn.isClosed()) {
                conn.close();
            }
        } catch (SQLException e) {
            e.printStackTrace(); 
        } finally {
        	// Set the variable to null regardless of whether the close operation succeeds
            conn = null; 
        }
    }
}
