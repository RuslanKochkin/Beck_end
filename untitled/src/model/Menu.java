package model;

public class Menu {
  private final static String MAIN_MENU_TEXT = """
            1: Зарегистрироватся
            2: Добавить урок:
            3: Вывести уроки по предмету:
            4: Добавить оценку студенту
            5: Покозать список студентов в Map
            6: Выйти:""";
  public static void showMainMenu() {
    System.out.println(MAIN_MENU_TEXT);
  }

}
