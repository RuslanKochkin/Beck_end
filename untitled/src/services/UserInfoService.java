package services;
import repositories.UserInfoRepositoryList;

public class UserInfoService {
  UserInfoRepositoryList repository;

  public UserInfoService(UserInfoRepositoryList repository) {
    this.repository = repository;
  }

}
