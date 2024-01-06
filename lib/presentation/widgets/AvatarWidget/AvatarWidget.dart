import 'package:avatars/avatars.dart';
import 'package:flutter/material.dart';

class AvatarWidget extends StatefulWidget {
  const AvatarWidget({super.key, this.avatarUrl, required this.name});

  final String? avatarUrl;
  final String name;

  @override
  State<AvatarWidget> createState() => _AvatarWidgetState();
}

class _AvatarWidgetState extends State<AvatarWidget> {
  bool isImageError = false;

  @override
  Widget build(BuildContext context) {
    if (widget.avatarUrl == null) {
      return FittedBox(
          child: SizedBox.square(
              child: CircleAvatar(
                  child: FittedBox(child: Avatar(name: widget.name)))));
    }

    return FittedBox(
        child: SizedBox.square(
            child: CircleAvatar(
                foregroundImage:
                    isImageError ? null : NetworkImage(widget.avatarUrl!),
                onForegroundImageError: isImageError
                    ? null
                    : (exception, stackTrace) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          setState(() {
                            isImageError = true;
                          });
                        });
                      },
                child: isImageError
                    ? FittedBox(child: Avatar(name: widget.name))
                    : null)));
  }
}
