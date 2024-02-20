import 'package:flutter/material.dart';
import 'package:lettutor/presentation/pages/EditProfilePage/ProfileAvatarEditing.dart';
import 'package:lettutor/presentation/pages/EditProfilePage/ProfileForm.dart';
import 'package:lettutor/presentation/widgets/PageAppBar/PageAppBar.dart';
import 'package:lettutor/providers/AuthProvider.dart';
import 'package:provider/provider.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final authProvider = context.read<AuthProvider>();
    return SafeArea(
      child: Scaffold(
        appBar: const PageAppBar(
          title: "Edit Profile",
          type: AppBarType.sub,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 10),
            child: Card(
              shape:
                  Border(top: BorderSide(width: 4, color: theme.primaryColor)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ProfileAvatarEditing(),
                  Container(
                    color: Colors.grey.shade300,
                    padding: const EdgeInsets.all(12),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Account",
                        style: theme.textTheme.bodySmall,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 25, horizontal: 35),
                    child: Theme(
                      data: theme.copyWith(
                          inputDecorationTheme: InputDecorationTheme(
                        contentPadding: const EdgeInsets.all(10),
                        isDense: true,
                        hintStyle: TextStyle(color: Colors.grey.shade300),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(12)),
                      )),
                      child: ProfileForm(user: authProvider.user!),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


