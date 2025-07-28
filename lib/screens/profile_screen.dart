import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overpower/screens/login_screen.dart';

import '../blocs/auth/auth_cubit.dart';
import '../blocs/auth/auth_state.dart';
import '../widgets/bottom_navigation_bar_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().getMe();
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
        currentIndex: 3,
        body: SingleChildScrollView(
          child: Column(
            children: [
              _buildUserInfo(context),
              const SizedBox(height: 20),
              _buildSettingsList(context),
              const SizedBox(height: 20),
              _buildLogoutButton(context),
            ],
          ),
        ));
    ;
  }
}

Widget _buildUserInfo(BuildContext context) {
  return BlocBuilder<AuthCubit, AuthState>(
    builder: (context, state) {
      if (state is AuthLoading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is AuthError) {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error, color: Colors.red, size: 48),
              const SizedBox(height: 8),
              const Text(
                'Une erreur est survenue.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  // Relance la récupération des points
                  context.read<AuthCubit>().getMe();
                },
                child: const Text('Réessayer'),
              ),
            ],
          ),
        );
      } else if (state is MeLoaded) {
        final user = state.user;

        return Row(
          children: [
            const CircleAvatar(
              radius: 32,
              child: Icon(Icons.person),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${user.email}',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: Colors.white)),
                  const SizedBox(height: 4),
                  GestureDetector(
                    onTap: () {
                      // 👉 ici tu peux ouvrir un modal ou déclencher un event BLoC
                    },
                    child: const Text(
                      'Modifier le nom d\'utilisateur',
                      style: TextStyle(
                          color: Colors.cyanAccent,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      } else {
        return const SizedBox(); // State initial vide
      }
    },
  );
}

Widget _buildSettingsList(BuildContext context) {
  return Column(
    children: [
      _settingsTile(Icons.lock, 'Changer le mot de passe', () {
        // action
      }),
      _settingsTile(Icons.support_agent, 'Support / Contact', () {
        // action
      }),
      _settingsTile(Icons.info, 'À propos', () {
        // action
      }),
    ],
  );
}

Widget _settingsTile(IconData icon, String title, VoidCallback onTap) {
  return ListTile(
    leading: Icon(icon, color: Colors.white),
    title: Text(title, style: const TextStyle(color: Colors.white)),
    trailing: const Icon(Icons.chevron_right, color: Colors.white),
    onTap: onTap,
    contentPadding: const EdgeInsets.symmetric(horizontal: 0),
  );
}

Widget _buildLogoutButton(BuildContext context) {
  return SizedBox(
    width: double.infinity,
    child: TextButton.icon(
      style: TextButton.styleFrom(
        backgroundColor: Colors.redAccent,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: () {
        // 👉 Déclenche ton event BLoC de déconnexion ici
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      },
      icon: const Icon(Icons.logout, color: Colors.white),
      label: const Text('Se déconnecter',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
    ),
  );
}
