import 'package:flutter/material.dart';

import '../widgets/bottom_navigation_bar_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return MainScaffold(      currentIndex: 0,
      body: SingleChildScrollView(
        child: Column(
          children: [
          ],
        ),
      ),
    );
  }


}



