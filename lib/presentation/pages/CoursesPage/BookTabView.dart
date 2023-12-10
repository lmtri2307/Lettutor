import 'package:flutter/material.dart';
import 'package:lettutor/presentation/pages/CoursesPage/PreviewCard.dart';
import 'package:lettutor/service/BookSevice.dart';

class BookTabView extends StatelessWidget {
  const BookTabView({super.key});

  final _bookService = const BookService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _bookService.getBookList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.all(20.0),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final bookList = snapshot.data!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: bookList
              .map((book) => PreviewCard(
                    imageUrl: book.imageUrl,
                    title: book.name,
                    description: book.description,
                    additionalDetail: book.level.name,
                  ))
              .toList(),
        );
      },
    );
  }
}
