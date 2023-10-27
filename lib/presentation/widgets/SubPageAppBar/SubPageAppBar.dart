import 'package:flutter/material.dart';

class SubPageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SubPageAppBar({super.key, required this.title});

  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: AppBar(
          toolbarHeight: double.infinity,
          scrolledUnderElevation: 0,
          backgroundColor: Colors.white,
          leading: BackButton(
            color: Theme.of(context).primaryColor,
          ),
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