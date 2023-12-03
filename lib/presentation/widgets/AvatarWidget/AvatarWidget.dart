import 'package:avatars/avatars.dart';
import 'package:flutter/material.dart';

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({super.key, this.avatarUrl, required this.name});

  final String? avatarUrl;
  final String name;
  @override
  Widget build(BuildContext context) {
    return FittedBox(
        child: SizedBox.square(
            child: CircleAvatar(
                child: avatarUrl != null
                    ? Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.contain,
                            image: AssetImage(avatarUrl!),
                          ),
                        ),
                      )
                    : FittedBox(child: Avatar(name: name)))));
  }
}
