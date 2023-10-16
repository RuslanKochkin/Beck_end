package services;

import java.util.List;


import model.Lesson;
import repositories.LessonCrudRepository;

public class LessonsServiceImpl implements LessonsService{
  LessonCrudRepository repository;

  public LessonsServiceImpl(LessonCrudRepository repository) {
    this.repository = repository;
  }
  @Override
  public void addNewLesson(Long id, String lessonName, String lessonTopic ) {
    List<Lesson> lessons = getAllLessons();
    for (Lesson lesson : lessons) {
      if (lesson.getId() == id && lesson.getLessonName().equals(lessonName)) {
        System.out.println("Ошибка: Урок с таким номером и предметом уже существует.");
        return;
      }
    }
      if (id <= 0 || lessonName.isEmpty() || lessonTopic.isEmpty()) {
      System.out.println("Ошибка: Все поля должны быть заполнены.");
      return;
    }
        Lesson newLesson = new Lesson(id, lessonName, lessonTopic);
        repository.save(newLesson);
        System.out.println("Урок добавлен.");
      }

  public void displayLessonsBySubject(String subject) {
    System.out.println("Уроки по предмету " + subject + ":");
    List<Lesson> lessons = getAllLessons();
    for (Lesson lesson : lessons) {
      if (lesson.getLessonTopic().equals(subject)) {
        System.out.println(lesson);
      }
    }
  }




  @Override
  public List<Lesson> getAllLessons() {
    return repository.findAll();
  }
}
