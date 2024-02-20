
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lettutor/presentation/widgets/AvatarWidget/AvatarWidget.dart';

class EditAvatarWidget extends StatefulWidget {
  const EditAvatarWidget(
      {super.key,
      required this.avatarUrl,
      required this.name,
      required this.onChangeAvatar});

  final String? avatarUrl;
  final String name;
  final Future<void> Function(String path) onChangeAvatar;

  @override
  State<EditAvatarWidget> createState() => _EditAvatarWidgetState();
}

class _EditAvatarWidgetState extends State<EditAvatarWidget> {
  final ImagePicker _picker = ImagePicker();
  bool _isLoading = false;
  Image? _image;

  Future<void> _onEditImage() async {
    final file = await _picker.pickImage(source: ImageSource.gallery);
    if (file == null) {
      return;
    }

    setState(() {
      _isLoading = true;
    });
    await widget.onChangeAvatar(file.path);
    final bytes = await file.readAsBytes();
    setState(() {
      _isLoading = false;
      _image = Image.memory(bytes);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox.square(
          dimension: 160,
          child: _isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : _image == null
                  ? AvatarWidget(
                      name: widget.name,
                      avatarUrl: widget.avatarUrl,
                    )
                  : _image!,
        ),
        Positioned(
            bottom: 0,
            right: 0,
            child: InkWell(
              onTap: () async {
                await _onEditImage();
              },
              child: const CircleAvatar(
                radius: 20,
                backgroundColor: Colors.blue,
                child: Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ))
      ],
    );
  }
}
