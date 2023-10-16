
import model.Menu;
import repositories.LessonCrudRepository;
import repositories.LessonRepositoryFileImpl;
import repositories.UserCrudRepository;
import repositories.UserInfoRepositoryList;
import repositories.UserRepositoryFileImpl;
import services.LessonsService;
import services.LessonsServiceImpl;
import services.UserService;
import services.UserServiceImpl;

import java.util.Scanner;

public class Main {

  public static void main(String[] args) {
    UserInfoRepositoryList repository1 = new UserInfoRepositoryList();
    UserCrudRepository repository = new UserRepositoryFileImpl("user.txt");
    UserService service = new UserServiceImpl(repository);
    LessonCrudRepository lessonManager = new LessonRepositoryFileImpl("lessons.txt");
    LessonsService serviceLesson = new LessonsServiceImpl(lessonManager);

    Scanner scanner = new Scanner(System.in);
    while (true) {
      try {
        Thread.sleep(2000);
      } catch (InterruptedException ignore) {
      }
      Menu.showMainMenu();
      int choice = scanner.nextInt();
      scanner.nextLine();

      switch (choice) {
        case 1:
          System.out.print("Введите имя пользователя (или 'exit' для завершения): ");
          String name = scanner.nextLine();
          if (name.equals("exit")) {
            break;
          }
          System.out.print("Введите email пользователя: ");
          String email = scanner.nextLine();
          service.addNewUser(name, email);
        case 2:
          System.out.println("Введите номер урока:");
          long number = scanner.nextLong();
          scanner.nextLine();
          System.out.println("Введите предмет урока:");
          String subject = scanner.nextLine();
          System.out.println("Введите тему урока:");
          String topic = scanner.nextLine();
          serviceLesson.addNewLesson(number, subject, topic);
          break;
        case 3:
          System.out.println("Введите предмет, чтобы увидеть список уроков:");
          String searchSubject = scanner.nextLine();
          serviceLesson.displayLessonsBySubject(searchSubject);
          break;
        case 4:
          while (true) {
            System.out.println("Введите Имя студента (или 'exit' для завершения):");
            String userName = scanner.nextLine();
            if (userName.equals("exit")) {
              break;
            }
            System.out.println("Введите оценку :");
            int quantityGrade = scanner.nextInt();
            repository1.saveUserInfo(userName,quantityGrade);
            scanner.nextLine();
          }
          break;
        case 5:
          repository1.UserMap();
          scanner.nextLine();
          break;
        case 6:
          System.exit(0);
        default:
          System.out.println("Неверный выбор. Попробуйте снова.");
      }
    }
  }
}