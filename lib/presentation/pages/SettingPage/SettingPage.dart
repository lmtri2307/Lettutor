import "package:avatars/avatars.dart";
import "package:flutter/material.dart";
import "package:lettutor/presentation/widgets/LetTutorAppBar/LetTutorAppBar.dart";
import "package:lettutor/providers/AuthProvider.dart";
import "package:provider/provider.dart";
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    return Scaffold(
      appBar: const LetTutorAppBar(isLoggedIn: true),
      body: SingleChildScrollView(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
            child: AccountInfo(
              name: authProvider.user?.name ?? "",
              email: authProvider.user?.email ?? "",
              avatarUrl: authProvider.user?.avatar,
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AccountOperationTile(
                  icon: Icons.manage_accounts,
                  label: AppLocalizations.of(context).editYourAccount,
                  onTap: () {
                    Navigator.pushNamed(context, "/edit-profile");
                  },
                ),
                AccountOperationTile(
                  icon: Icons.assignment,
                  label: AppLocalizations.of(context).becomeATutor,
                  onTap: () {
                    Navigator.pushNamed(context, "/become-tutor");
                  },
                ),
                AccountOperationTile(
                  icon: Icons.settings,
                  label: AppLocalizations.of(context).settings,
                ),
                const SizedBox(
                  height: 8,
                ),
                TextButton(
                  onPressed: () async {
                    await authProvider.logout();
                  },
                  style: TextButton.styleFrom(
                    minimumSize: const Size.fromHeight(48),
                    backgroundColor: Colors.red.shade100,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.logout, color: Colors.red),
                      const SizedBox(width: 8),
                      Text(
                        AppLocalizations.of(context).logout,
                        style: const TextStyle(fontSize: 18, color: Colors.red),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}

class AccountInfo extends StatelessWidget {
  const AccountInfo(
      {super.key, required this.name, required this.email, this.avatarUrl});

  final String name;
  final String email;
  final String? avatarUrl;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(children: [
      ClipOval(
        child: SizedBox.fromSize(
            size: const Size.fromRadius(40),
            child: Image.network(avatarUrl ?? "",
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Avatar(name: name))),
      ),
      const SizedBox(
        width: 32,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: theme.textTheme.bodyMedium,
          ),
          Text(
            email,
            style: theme.textTheme.bodySmall,
          )
        ],
      )
    ]);
  }
}

class AccountOperationTile extends StatelessWidget {
  const AccountOperationTile(
      {super.key, required this.icon, required this.label, this.onTap});

  final IconData icon;
  final String label;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextButton(
        style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            side: const BorderSide(
                color: Colors.black26, width: 1, style: BorderStyle.solid)),
        onPressed: onTap ?? () {},
        child: Row(
          children: [
            Icon(icon, color: theme.primaryColor),
            const SizedBox(
              width: 12,
            ),
            Text(
              label,
              style: theme.textTheme.bodySmall,
            )
          ],
        ),
      ),
    );
  }
}
