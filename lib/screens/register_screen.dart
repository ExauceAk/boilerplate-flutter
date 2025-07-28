import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/auth/auth_cubit.dart';
import '../blocs/auth/auth_state.dart';
import '../widgets/effet_neon_card_widget.dart';
import 'login_screen.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final fullnameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final referrerCodeController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A3D62),
      body: BlocConsumer<AuthCubit, AuthState>(listener: (context, state) {
        if (state is AuthSuccess) {
          Navigator.push( context, MaterialPageRoute(builder: (context) => LoginScreen()));
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
        builder:  (context, state) {
          if (state is AuthLoading) {
            return Center(child: CircularProgressIndicator());
          }
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("Créer un compte", style: TextStyle(color: Colors.white, fontSize: 22)),
                      const SizedBox(height: 20),
                      _buildTextField(fullnameController, Icons.person, "Nom complet"),
                      const SizedBox(height: 16),
                      _buildTextField(emailController, Icons.email, "Email"),
                      const SizedBox(height: 16),
                      _buildTextField(passwordController, Icons.lock, "Mot de passe", isPassword: true),
                      const SizedBox(height: 16),
                      _buildTextField(confirmPasswordController, Icons.lock, "Mot de passe", isPassword: true),
                      const SizedBox(height: 16),
                      _buildTextField(referrerCodeController, Icons.supervised_user_circle, "Code de parrainage"),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          final email = emailController.text;
                          final fullname = fullnameController.text;
                          final password = passwordController.text;
                          final confirmPassword = confirmPasswordController.text;
                          final referrerCode = referrerCodeController.text;

                          context.read<AuthCubit>().register(email, fullname, password, confirmPassword, referrerCode);
                        },
                        child: const Text("S'inscrire"),
                      ),
                      const SizedBox(height: 10),
                      TextButton(
                        onPressed: () => Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => LoginScreen()),
                        ),
                        child: const Text("J'ai déjà un compte", style: TextStyle(color: Colors.cyanAccent)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),

    );
  }

  Widget _buildTextField(TextEditingController fieldController, IconData icon, String label, {bool isPassword = false}) {
    return TextField(
      obscureText: isPassword,
      controller: fieldController,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.cyan),
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white),
        filled: true,
        fillColor: const Color(0xFF103D5C),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
