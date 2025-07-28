import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overpower/screens/home_screen.dart';
import 'package:overpower/screens/login_screen.dart';
import 'package:overpower/services/api_service.dart';

import 'blocs/auth/auth_cubit.dart';
import 'data/repositories/auth_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<AuthCubit>(
            create: (context) => AuthCubit(AuthRepository(ApiService())),
          ),

        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Nops',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: HomeScreen(),
        ));
  }
}
