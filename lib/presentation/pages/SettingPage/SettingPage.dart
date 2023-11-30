import "package:avatars/avatars.dart";
import "package:flutter/material.dart";
import "package:lettutor/presentation/widgets/LetTutorAppBar/LetTutorAppBar.dart";
import "package:lettutor/providers/AuthProvider.dart";
import "package:provider/provider.dart";

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
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const AccountOperationTile(
                  icon: Icons.manage_accounts,
                  label: "Edit your account",
                ),
                const AccountOperationTile(
                  icon: Icons.assignment,
                  label: "Become a tutor",
                ),
                const AccountOperationTile(
                  icon: Icons.settings,
                  label: "Settings",
                ),
                const SizedBox(
                  height: 8,
                ),
                TextButton(
                  onPressed: () async {},
                  style: TextButton.styleFrom(
                    minimumSize: const Size.fromHeight(48),
                    backgroundColor: Colors.red.shade100,
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.logout, color: Colors.red),
                      SizedBox(width: 8),
                      Text(
                        'Log Out',
                        style: TextStyle(fontSize: 18, color: Colors.red),
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
      {super.key, required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  offset: Offset(0, 0),
                  blurRadius: 1,
                  spreadRadius: 1,
                  color: Colors.black26,
                ),
              ]),
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
      ),
    );
  }
}
