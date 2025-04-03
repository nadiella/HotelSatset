/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

import java.sql.*;
import java.util.ArrayList;


/**
 *
 * @author Ando Holle
 */
public class Room extends Model<Room>{
    private int id;
    private String tipe_kamar;
    private String harga;
    
    public Room() {
        this.table = "room";
        this.primaryKey = "id";
    }

    public Room(int id, String tipe_kamar, String harga) {
        this.table = "room";
        this.primaryKey = "id";
        this.id = id;
        this.tipe_kamar = tipe_kamar;
        this.harga = harga;
    }
    
    @Override
    Room toModel(ResultSet rs){
        try {
            try {
            Room room = new Room();
            room.id = rs.getInt("id");
            room.tipe_kamar = rs.getString("tipe_kamar");
            room.harga = rs.getString("harga");
            
            System.out.println("Mapped Room: " + room.tipe_kamar);
            return room;
        } catch (Exception e) {
            System.err.println("Error mapping ResultSet to Model: " + e.getMessage());
            return null;
        }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTipekamar() {
        return tipe_kamar;
    }

    public void setTipekamar(String tipe_kamar) {
        this.tipe_kamar = tipe_kamar;
    }

    public String getHarga() {
        return harga;
    }

    public void setPrice(String harga) {
        this.harga = harga;
    }
    
    
}
