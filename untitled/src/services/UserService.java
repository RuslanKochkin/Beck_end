package services;

import model.User;

import java.util.List;

public interface UserService {
  void addNewUser(String name, String email);
  List<User> getAllUsers();
}
