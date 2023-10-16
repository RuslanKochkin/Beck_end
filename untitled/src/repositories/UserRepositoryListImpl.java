package repositories;

import java.util.HashMap;
import java.util.Map;
import model.User;

import java.util.ArrayList;
import java.util.List;

public class UserRepositoryListImpl implements UserCrudRepository {
  private final List<User> users = new ArrayList<>();
  private Long currentId =1L;

  @Override
  public void save(User user) {
    user.setId(currentId++);
    users.add(user);
  }

  @Override
  public List<User> findAll() {
    return new ArrayList<>(users);
  }

  @Override
  public User findById(Long id) {
    return users.stream()
        .filter(u->u.getId()==id.longValue())
        .findFirst()
        .get();
  }


  @Override
  public void update(User element) {

  }

  @Override
  public void deleteById(Long id) {

  }
}
