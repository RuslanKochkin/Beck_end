package model;

public class Lesson {
  private Long id;
  private String lessonName ;
  private String lessonTopic ;



  public Lesson(String lessonName, String lessonTopic) {
    this.lessonName = lessonName;
    this.lessonTopic = lessonTopic;
  }

  public Lesson(Long id, String lessonName, String lessonTopic ) {
    this.id = id;
    this.lessonName = lessonName;
    this.lessonTopic = lessonTopic;

  }

  public String getLessonName() {
    return lessonName;
  }

  public void setLessonName(String lessonItem) {
    this.lessonName = lessonName;
  }

  public String getLessonTopic() {
    return lessonTopic;
  }

  public void setLessonTopic(String lessonTopic) {
    this.lessonTopic = lessonTopic;
  }

  public Long getId() {
    return id;
  }

  public void setId(Long id) {
    this.id = id;
  }

  @Override
  public String toString() {
    return "Lesson{" +
        "lessonItem='" + lessonName + '\'' +
        ", lessonTopic='" + lessonTopic + '\'' +
        '}';
  }
}
