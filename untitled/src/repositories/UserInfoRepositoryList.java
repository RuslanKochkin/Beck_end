package repositories;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.UserInfo;

public class UserInfoRepositoryList {
  private final List<UserInfo> users = new ArrayList<>();

  public List<UserInfo> saveUserInfo(String name, int quantityGrade) {
    UserInfo userInfo = new UserInfo(name, quantityGrade);
    users.add(userInfo);
    return users;
  }
  public void UserMap (){
    Map<String, Integer> userInfoMap = new HashMap<>();
        for (UserInfo userInfo : users) {
    userInfoMap.put(userInfo.getName(), userInfo.getQuantityGrade());
    System.out.print(userInfoMap);
  }
}

  public List<UserInfo> getUsers() {
    return users;
  }
}
