/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

import java.sql.ResultSet;

/**
 *
 * @author Ando Holle
 */
public class Reservation extends Model<Reservation> {
    public int id;
    public String name;
    public String phone_number;
    public String check_in;
    public String check_out;
    public int room_id;

    public Reservation() {
        this.table = "reservations";
        this.primaryKey = "id";
    }

    public Reservation(int id, String name, String phone_number, String check_in, String check_out, int room_id) {
        this.table = "reservations";
        this.primaryKey = "id";
        this.id = id;
        this.name = name;
        this.phone_number = phone_number;
        this.check_in = check_in;
        this.check_out = check_out;
        this.room_id = room_id;
    }

    @Override
    Reservation toModel(ResultSet rs) {
        try {
            Reservation reservation = new Reservation();
            reservation.id = rs.getInt("id");
            reservation.name = rs.getString("name");
            reservation.phone_number = rs.getString("phone_number");
            reservation.check_in = rs.getString("check_in");
            reservation.check_out = rs.getString("check_out");
            reservation.room_id = rs.getInt("room_id");
            System.out.println("Mapped Reservation: " + reservation.name);
            return reservation;
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

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhoneNumber() {
        return phone_number;
    }

    public void setPhoneNumber(String phone_number) {
        this.phone_number = phone_number;
    }

    public String getCheckIn() {
        return check_in;
    }

    public void setCheckIn(String check_in) {
        this.check_in = check_in;
    }

    public String getCheckOut() {
        return check_out;
    }

    public void setCheckOut(String check_out) {
        this.check_out = check_out;
    }

    public int getRoomId() {
        return room_id;
    }

    public void setRoomId(int room_id) {
        this.room_id = room_id;
    }
}
