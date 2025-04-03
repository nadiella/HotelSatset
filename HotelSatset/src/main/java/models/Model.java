/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

import java.lang.reflect.Field;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

public abstract class Model<E> {

    private Connection con; 
    private Statement stmt; 
    private boolean isConnected; 
    private String message;
    protected String table; 
    protected String primaryKey; 
    protected String select = "*"; 
    private String where = ""; 
    private String join = ""; 
    private String otherQuery = ""; 

    void connect() {
        String db_name = "hotel_satset"; 
        String username = "root"; 
        String password = ""; 
        String url = "jdbc:mysql://localhost:3307/" + db_name; 

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(url, username, password); 
            stmt = con.createStatement(); 
            isConnected = true; 
            message = "Database Terkoneksi"; 
        } catch (Exception e) {
            isConnected = false; 
            message = e.getMessage(); 
        }
        System.out.println("Koneksi Status: " + isConnected + " - Pesan: " + message);
    }

    private void disconnect() {
        try {
            stmt.close(); 
            con.close(); 
        } catch (Exception e) {
            message = e.getMessage();
        }
    }

    public void insert() {
        try {
            connect(); 
            String cols = "", values = ""; 
            for (Field field : this.getClass().getDeclaredFields()) { 
                field.setAccessible(true); 
                Object value = field.get(this); 
                if (value != null) {
                    cols += field.getName() + ", "; 
                    values += value + "', '"; 
                }
            }
            int result = stmt.executeUpdate("INSERT INTO " + table + "(" + cols.substring(0, cols.length() - 2) + ")"
                                            + " VALUES ('" + values.substring(0, values.length() - 4) + "')");
            message = "info insert: " + result + " rows affected"; 
        } catch (Exception e) {
            message = e.getMessage(); 
        } finally {
            disconnect();
        }
    }

    public void update() {
        try {
            connect();
            String values = ""; 
            Object pkValue = 0; 
            for (Field field : this.getClass().getDeclaredFields()) { 
                field.setAccessible(true); 
                Object value = field.get(this); 
                if (field.getName().equals(primaryKey)) pkValue = value; 
                else if (value != null) {
                    values += field.getName() + " = '" + value + "', "; 
                }
            }

            int result = stmt.executeUpdate("UPDATE " + table + " SET " + values.substring(0, values.length() - 2)
                                            + " WHERE " + primaryKey + " = '" + pkValue +"'");
            message = "info update: " + result + " rows affected"; 
        } catch (Exception e) {
            message = e.getMessage(); 
        } finally {
            disconnect(); 
        }
    }

    public void delete() {
        try {
            connect(); 
            Object pkValue = 0; 
            for (Field field : this.getClass().getDeclaredFields()) { 
                field.setAccessible(true); 
                if (field.getName().equals(primaryKey)) {
                    pkValue = field.get(this); 
                    break;
                }
            }

            int result = stmt.executeUpdate("DELETE FROM " + table + " WHERE " + primaryKey + " = '" + pkValue +"'");
            message = "info delete: " + result + " rows affected"; 
        } catch (Exception e) {
            message = e.getMessage(); 
        } finally {
            disconnect(); 
        }
    }

    ArrayList<Object> toRow(ResultSet rs) {
        ArrayList<Object> res = new ArrayList<>();
        int i = 1; 
        try {
            while (true) {
                res.add(rs.getObject(i)); 
                i++;
            }
        } catch(Exception e) {
            
        }
        return res;
    }

    public ArrayList<ArrayList<Object>> query(String query) {
        ArrayList<ArrayList<Object>> res = new ArrayList<>();
        try {
            connect(); 
            ResultSet rs = stmt.executeQuery(query); 
            while (rs.next()) {
                res.add(toRow(rs)); 
            }
        } catch (Exception e) {
            message = e.getMessage(); 
        } finally {
            disconnect();
        }
        return res; 
    }

    abstract E toModel(ResultSet rs);

    public ArrayList<E> get() {
        ArrayList<E> res = new ArrayList<>();
        String query = "SELECT " + select + " FROM " + table; 
        if (!join.isEmpty()) query += " " + join; 
        if (!where.isEmpty()) query += " WHERE " + where; 
        if (!otherQuery.isEmpty()) query += " " + otherQuery; 

        System.out.println("Executing Query: " + query); 

        try {
            connect(); 
            if (!isConnected) {
                System.err.println("Database connection failed."); 
                return res;
            }

            ResultSet rs = stmt.executeQuery(query);
            while (rs.next()) {
                E model = toModel(rs); 
                if (model != null) {
                    res.add(model); 
                } else {
                    System.err.println("Warning: Model is null for current row."); 
                }
            }
        } catch (Exception e) {
            message = e.getMessage();
            System.err.println("Error in get(): " + e.getMessage()); 
        } finally {
            disconnect(); 
            select = "*";
            where = "";
            join = "";
            otherQuery = "";
        }

        System.out.println("Total Records Fetched: " + res.size()); 
        return res; 
    }

    public ArrayList<E> getAvailableRooms(String checkIn, String checkOut) {
        ArrayList<E> res = new ArrayList<>();
        String query = "SELECT " + select + " FROM " + table + " r " +
                       "LEFT JOIN reservations res ON r.id = res.room_id " +
                       "AND (res.check_in < '" + checkOut + "' AND res.check_out > '" + checkIn + "') " +
                       "WHERE res.room_id IS NULL"; 

        System.out.println("Executing Query: " + query); 

        try {
            connect();
            if (!isConnected) {
                System.err.println("Database connection failed."); 
                return res;
            }

            ResultSet rs = stmt.executeQuery(query); 
            while (rs.next()) {
                E model = toModel(rs); 
                if (model != null) {
                    res.add(model); 
                } else {
                    System.err.println("Warning: Model is null for current row."); 
                }
            }
        } catch (Exception e) {
            message = e.getMessage(); 
            System.err.println("Error in getAvailableRooms(): " + e.getMessage()); 
        } finally {
            disconnect(); 
            select = "*";
            where = "";
            join = "";
            otherQuery = "";
        }

        System.out.println("Total Records Fetched: " + res.size());
        return res; 
    }

    public E find(String pkValue) {
        try {
            connect(); 
            String query = "SELECT " + select + " FROM " + table + " WHERE " + primaryKey + " = '" + pkValue + "'";
            ResultSet rs = stmt.executeQuery(query); 
            if (rs.next()) {
                return toModel(rs); 
            }
        } catch (Exception e) {
            message = e.getMessage(); 
        } finally {
            disconnect();
            select = "*"; 
        }
        return null; 
    }

    public void select(String cols) {
        select = cols;
    }

    public void join(String table, String on) {
        join += " JOIN " + table + " ON " + on; 
    }
    public void where(String cond) {
        where = cond; 
    }

    public void addQuery(String query) {
        otherQuery = query; 
    }

    public boolean isConnected() {
        return this.isConnected; 
    }

    public String getMessage() {
        return message; 
    }

    public void setMessage(String message) {
        this.message = message;
    }
}
