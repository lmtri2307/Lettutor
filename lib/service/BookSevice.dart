import 'package:lettutor/dummy/book.dart';
import 'package:lettutor/models/Book.dart';
import 'package:lettutor/repository/CourseRepository.dart';

class BookService{
  const BookService();
  final _courseRepository = const CourseRepository();
  Future<(List<Book>, int)> getBookList(int page, int perPage) async{
    return await _courseRepository.getBookList(page, perPage);
  }
}