package services;

import java.util.List;
import model.Lesson;
import model.User;

public interface LessonsService {
  void addNewLesson(Long Id, String name, String email);
  List<Lesson> getAllLessons();
  void displayLessonsBySubject(String subject);
}
