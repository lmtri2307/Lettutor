import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lettutor/providers/AuthProvider.dart';
import 'package:lettutor/service/AuthService.dart';
import 'package:provider/provider.dart';

class SocialIcons extends StatelessWidget {
  const SocialIcons({super.key});

  final _authService = const AuthService();

  void _googleLogin(AuthProvider authProvider) async {
    final user = await _authService.loginWithGoogle();
    authProvider.setUser(user);
  }

  void _facebookLogin(AuthProvider authProvider) async {
    final user = await _authService.loginWithFacebook();
    authProvider.setUser(user);
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.read<AuthProvider>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.all(10),
            shape: const CircleBorder(),
            side: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 2.0, // border width
            ),
          ),
          onPressed: () => _facebookLogin(authProvider),
          child: const CircleAvatar(
            backgroundColor: Colors.transparent,
            child: FaIcon(FontAwesomeIcons.facebookF, color: Color(0xFF1877F2)),
          ),
        ),
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.all(10),
            shape: const CircleBorder(),
            side: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 2.0, // border width
            ),
          ),
          onPressed: () => _googleLogin(authProvider),
          child: const CircleAvatar(
            backgroundColor: Colors.transparent,
            child: FaIcon(FontAwesomeIcons.google, color: Color(0xFFDB4437)),
          ),
        ),
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.all(10),
            shape: const CircleBorder(),
            side: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 2.0, // border width
            ),
          ),
          onPressed: () {},
          child: const CircleAvatar(
            backgroundColor: Colors.transparent,
            child: FaIcon(FontAwesomeIcons.mobileAlt, color: Colors.black),
          ),
        ),
      ],
    );
  }
}
