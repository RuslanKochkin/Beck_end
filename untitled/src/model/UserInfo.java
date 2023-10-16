package model;
public class UserInfo extends User {
  private int quantityGrade;


  public UserInfo(String name,int quantityGrade) {
    super(name);
    this.quantityGrade = quantityGrade;
  }

  public int getQuantityGrade() {
    return quantityGrade;
  }

  public void setQuantityGrade(int quantityGrade) {
    this.quantityGrade = quantityGrade;
  }

}
