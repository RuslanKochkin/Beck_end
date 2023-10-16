package repositories;

import java.io.*;

import java.util.List;
import model.Lesson;

public class LessonRepositoryFileImpl implements LessonCrudRepository{
  private String fileName;
  private Long currentId=1L;

  public LessonRepositoryFileImpl(String fileName) {
    this.fileName = fileName;
    this.currentId = currentId;
  }

  public void save(Lesson lesson) {
    lesson.setId(currentId++);
    try(BufferedWriter writer = new BufferedWriter(new FileWriter(fileName,true));) {
      String line = lesson.getId() +"," + lesson.getLessonName() + "," + lesson.getLessonTopic();
      writer.write(line);
      writer.newLine();
    } catch (IOException e) {
      System.out.println("Ошибка все поля должны быть заполнены.");
      e.printStackTrace();
    }
  }

  @Override
  public List<Lesson> findAll() {
    try(BufferedReader reader = new BufferedReader(new FileReader(fileName))){
      return reader.lines()
          .map(l->l.split(","))
          .map(userArr -> new Lesson(Long.parseLong(userArr[0]), userArr[1], userArr[2]))
          .toList();
    } catch (FileNotFoundException e) {
      throw new RuntimeException(e);
    } catch (IOException e) {
      throw new RuntimeException(e);
    }
  }

  @Override
  public Lesson findById(Long id) {
    return findAll().stream()
        .filter(u->u.getId()==id)
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
