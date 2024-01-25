import 'package:flutter/material.dart';
import 'package:lettutor/helpers/pagination.dart';
import 'package:lettutor/presentation/pages/CoursesPage/PreviewCard.dart';
import 'package:lettutor/service/BookSevice.dart';
import 'package:number_paginator/number_paginator.dart';

class BookTabView extends StatefulWidget {
  const BookTabView({super.key});

  @override
  State<BookTabView> createState() => _BookTabViewState();
}

class _BookTabViewState extends State<BookTabView> {
  final _bookService = const BookService();
  final _pagination = Pagination();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _bookService.getBookList(
          _pagination.currentPage, _pagination.perPage),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.all(20.0),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final bookList = snapshot.data!.$1;
        _pagination.totalItems = snapshot.data!.$2;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 44.0),
              child: Column(
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
              ),
            ),
            NumberPaginator(
              initialPage: _pagination.currentPage - 1,
              numberPages: _pagination.totalPages,
              onPageChange: (int page) {
                setState(() {
                  _pagination.currentPage = page + 1;
                });
              },
            )
          ],
        );
      },
    );
  }
}
