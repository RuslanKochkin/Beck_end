package repositories;

import java.util.List;

public interface CrudRepository<T> {

  void save(T element);
  List<T> findAll();
  T findById(Long id);

  void update(T element);
  void  deleteById(Long id);

}
