import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/auth/auth_cubit.dart';
import '../blocs/auth/auth_state.dart';
import 'login_screen.dart';



class ForgotPasswordScreen extends StatelessWidget {
   ForgotPasswordScreen({super.key});

  final emailController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A3D62),
      body:  BlocConsumer<AuthCubit, AuthState>(listener: (context, state) {
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
                color: const Color(0xFF0E4B6E),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("Mot de passe oublié", style: TextStyle(color: Colors.white, fontSize: 22)),
                      const SizedBox(height: 20),
                      _buildTextField(emailController, Icons.email, "Votre email"),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          final email = emailController.text;
                          context.read<AuthCubit>().forgotPasswordRequest(email);
                        },
                        child: const Text("Réinitialiser"),
                      ),
                      const SizedBox(height: 10),
                      TextButton(
                        onPressed: () => Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => LoginScreen()),
                        ),
                        child: const Text("Retour", style: TextStyle(color: Colors.cyanAccent)),
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

  Widget _buildTextField(TextEditingController fieldController, IconData icon, String label) {
    return TextField(
      style: const TextStyle(color: Colors.white),
      controller: fieldController,
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
