import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/auth/auth_cubit.dart';
import '../blocs/auth/auth_state.dart';
import 'home_screen.dart';
class LoginScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A3D62),
      body: BlocConsumer<AuthCubit, AuthState>(listener: (context, state) {
        if (state is AuthSuccess) {
          Navigator.push( context, MaterialPageRoute(builder: (context) => HomeScreen()));
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
                      const Text("Connexion", style: TextStyle(color: Colors.white, fontSize: 22)),
                      const SizedBox(height: 20),
                      _buildTextField(emailController, Icons.email, "Email"),
                      const SizedBox(height: 16),
                      _buildTextField(passwordController, Icons.lock, "Mot de passe", isPassword: true),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          final email = emailController.text;
                          final password = passwordController.text;
                          context.read<AuthCubit>().login(email, password);
                        },
                        child: Text('Login'),
                      ),
                      const SizedBox(height: 10),
                      TextButton(
                        onPressed: () => {},
                        child: const Text("Mot de passe oublié ?", style: TextStyle(color: Colors.cyanAccent)),
                      ),
                      TextButton(
                        onPressed: () => {},
                        child: const Text("Créer un compte", style: TextStyle(color: Colors.cyanAccent)),
                      ),
                    ],
                  ),
                ),
              ) ,
            ),
          );
        },
      ),
    );
  }
}




  Widget _buildTextField(TextEditingController fieldController,IconData icon, String label, {bool isPassword = false}) {
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


void myAuthListener(BuildContext context, AuthState state) {
  if (state is AuthSuccess) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  } else if (state is AuthError) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(state.message)));
  }
}

