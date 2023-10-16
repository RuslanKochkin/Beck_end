package repositories;

import model.User;

import java.io.*;


import java.util.List;

public class UserRepositoryFileImpl implements UserCrudRepository{
  private String fileName;
  private Long currentId=1L;

  public UserRepositoryFileImpl(String fileName) {
    this.fileName = fileName;
  }

  @Override
  public void save(User user) {
    user.setId(currentId++);
    try(BufferedWriter writer = new BufferedWriter(new FileWriter(fileName,true));) {
      String line = user.getId() +"," + user.getName() + "," + user.getEmail();
      writer.write(line);
      writer.newLine();
    } catch (IOException e) {
      System.out.println("Ошибка при сохранении пользователей в файл.");
      e.printStackTrace();
    }
  }

  @Override
  public List<User> findAll() {
    try(BufferedReader reader = new BufferedReader(new FileReader(fileName))){
      return reader.lines()  // 1,john,john@mail.com
          .map(l->l.split(","))
          .map(userArr -> new User(Long.parseLong(userArr[0]), userArr[1], userArr[2]))
          .toList();
    } catch (FileNotFoundException e) {
      throw new RuntimeException(e);
    } catch (IOException e) {
      throw new RuntimeException(e);
    }
  }

  @Override
  public User findById(Long id) {
    return findAll().stream()
        .filter(u->u.getId()==id)
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
