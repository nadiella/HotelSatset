/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author nadie
 */

package models;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class akun extends Model<akun> {

    private static List<akun> akunList = new ArrayList<>();
    private int id;
    private String username;
    private String password;
    public akun() {
        this.table = "akun";
        this.primaryKey = "id";
    }

    public akun(int id, String username, String password) {
        this.table = "akun";
        this.primaryKey = "id";
        this.id = id;
        this.username = username;
        this.password = password;
    }
    @Override
    akun toModel(ResultSet rs) {
        try {
            akun akun = new akun();
            akun.id = rs.getInt("id");
            akun.username = rs.getString("username");
            akun.password = rs.getString("password");
            return akun;
        } catch (Exception e) {
            System.err.println("Error mapping ResultSet to akun model: " + e.getMessage());
            return null;
        }
    }

    private static void addToStaticCollection(akun newAkun) {
        akunList.add(newAkun);
    }

    public static boolean register(String username, String password) {
        try {
            akun newAkun = new akun();
            newAkun.username = username;
            newAkun.password = password;

            newAkun.insert();

            addToStaticCollection(newAkun);
            System.out.println("Pengguna berhasil mendaftar!");
            return true;
        } catch (Exception e) {

            System.err.println("Error during registration: " + e.getMessage());
            return false;
        }
    }

    public static boolean login(String username, String password) {
        try {
            for (akun user : akunList) {
                if (user.getUsername().equals(username) && user.getPassword().equals(password)) {
                    System.out.println("Login sukses untuk user: " + username);
                    return true;
                }
            }
            akun akunModel = new akun();
            akunModel.where("username = '" + username + "' AND password = '" + password + "'");
            akun user = akunModel.get().stream().findFirst().orElse(null);
            if (user != null) {
                addToStaticCollection(user);
                System.out.println("Login successful for user: " + username);
                return true;
            }

            System.err.println("Nama pengguna atau kata sandi tidak valid.");
            return false;
        } catch (Exception e) {
            System.err.println("Error during login: " + e.getMessage());
            return false;
        }
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
