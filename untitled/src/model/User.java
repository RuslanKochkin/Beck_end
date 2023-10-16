package model;

public class User {
  private long id;
  private String name;
  private String email;

  public User(String name) {
    this.name = name;
  }

  public User(String name, String email) {
    this.name = name;
    this.email = email;
  }

  public User(long id, String name, String email ) {
    this.id = id;
    this.name = name;
    this.email = email;

  }

  public String getName() {
    return name;
  }

  public String getEmail() {
    return email;
  }

  @Override
  public String toString() {
    return "User{" +
        "id=" + id +
        ", name='" + name + '\'' +
        ", email='" + email + '\'' +
        '}';
  }

  public long getId() {
    return id;
  }

  public void setId(long id) {
    this.id = id;
  }

  public void setName(String name) {
    this.name = name;
  }

  public void setEmail(String email) {
    this.email = email;
  }

}

