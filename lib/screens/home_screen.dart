import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

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
            _buildInfoCard(screenWidth),
            const SizedBox(height: 10),
            _buildInfoCard(screenWidth),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }



  Widget _buildInfoCard(double screenWidth) {
    return Container(
      width: screenWidth * 0.9,
      height: 60,
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Center(
        child: Text(
          '',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }


  Widget buildSkeletonLoader() {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                color: Colors.white,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(height: 10, width: double.infinity, color: Colors.white),
                    const SizedBox(height: 5),
                    Container(height: 10, width: 150, color: Colors.white),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



