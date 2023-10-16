package services;

import model.User;
import repositories.UserCrudRepository;

import java.util.List;

public class UserServiceImpl implements UserService{
  UserCrudRepository repository;

  public UserServiceImpl(UserCrudRepository repository) {
    this.repository = repository;
  }


  @Override
  public void addNewUser(String name, String email) {
    if (name != null && email != null && !email.isEmpty() && !name.isEmpty() && email.contains("@")) {
      User user = new User(name, email);
      repository.save(user);
      System.out.println("Пользователь добавлен.");
    }
  }



  @Override
  public List<User> getAllUsers() {
    return repository.findAll();
  }
}
