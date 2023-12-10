import 'package:lettutor/dummy/book.dart';
import 'package:lettutor/models/Book.dart';

class BookService{
  const BookService();
  Future<List<Book>> getBookList() async{
    await Future.delayed(const Duration(seconds: 2));
    return bookList;
  }
}