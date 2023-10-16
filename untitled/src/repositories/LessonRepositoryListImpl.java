package repositories;

import java.util.ArrayList;
import java.util.List;
import model.Lesson;
import model.User;

public class LessonRepositoryListImpl implements LessonCrudRepository{
  private final List<Lesson> lessons = new ArrayList<>();
  private Long currentId =1L;

  @Override
  public void save(Lesson lesson) {
      lesson.setId(currentId++);
      lessons.add(lesson);
    }

  @Override
  public List<Lesson> findAll() {
    return new ArrayList<>(lessons);
  }

  @Override
  public Lesson findById(Long id) {
    return lessons.stream()
        .filter(u->u.getId()==id.longValue())
        .findFirst()
        .get();
  }

  @Override
  public void update(Lesson element) {

  }

  @Override
  public void deleteById(Long id) {

  }
}
