import 'package:flutter/material.dart';

enum AppBarType { main, sub }

class PageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PageAppBar({super.key, required this.title, required this.type});

  final String title;
  final AppBarType type;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: AppBar(
          toolbarHeight: double.infinity,
          scrolledUnderElevation: 0,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          leading: type == AppBarType.sub
              ? BackButton(
                  color: Theme.of(context).primaryColor,
                )
              : null,
          title: Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ));
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(70);
}
