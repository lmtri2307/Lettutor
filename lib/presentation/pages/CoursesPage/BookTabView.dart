import 'package:flutter/material.dart';
import 'package:lettutor/models/Book.dart';
import 'package:lettutor/presentation/pages/CoursesPage/PreviewCard.dart';


class BookTabView extends StatelessWidget {
  const BookTabView({super.key, required this.bookList});

  final List<Book> bookList;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: bookList
          .map((book) => PreviewCard(
        imageUrl: book.imageUrl,
        title: book.name,
        description: book.description,
        additionalDetail:
        book.level.name,
      ))
          .toList(),
    );
  }
}
