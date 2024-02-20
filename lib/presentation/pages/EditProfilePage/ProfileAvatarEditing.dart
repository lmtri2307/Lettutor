import 'package:flutter/material.dart';
import 'package:lettutor/presentation/widgets/EditAvatarWidget/EditAvatarWidget.dart';
import 'package:lettutor/providers/AuthProvider.dart';
import 'package:provider/provider.dart';

class ProfileAvatarEditing extends StatelessWidget {
  const ProfileAvatarEditing({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final authProvider = context.read<AuthProvider>();
    final user = authProvider.user!;
    return Padding(
      padding: const EdgeInsets.all(35),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: EditAvatarWidget(
              name: user.name!,
              avatarUrl: user.avatar,
              onChangeAvatar: authProvider.updateAvatar,
            ),
          ),
          Text(user.name!, style: theme.textTheme.headlineMedium?.copyWith(
            color: Colors.black
          ),),
          const SizedBox(height: 8,),
          Text("Account ID: ${user.id}", style: theme.textTheme.bodySmall,),
        ],
      ),
    );
  }
}
