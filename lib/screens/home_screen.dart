import 'package:flutter/material.dart';

import '../widgets/bottom_navigation_bar_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> notes = [
    {
      "id": 1,
      "title": "Courses",
      "content": "Acheter du pain, du lait et des œufs"
    },
    {
      "id": 2,
      "title": "Idées de contenu",
      "content": "Poster un article à propos de nos voyages propos de nos voyages propos de nos voyages propos de nos voyages"
    },
    {"id": 3, "title": "RDV", "content": "Déjeuner avec François"},
    {"id": 4, "title": "Musique", "content": "Trouver de nouvelles chansons"},
    {"id": 5, "title": "Musique", "content": "Trouver de nouvelles chansons"},
    {"id": 6, "title": "Musique", "content": "Trouver de nouvelles chansons"},
    {"id": 7, "title": "À faire", "content": "Réserver un billet d’avion"},
    {"id": 8, "title": "À faire", "content": "Réserver un billet d’avion"},
    {"id": 9, "title": "À faire", "content": "Réserver un billet d’avion"},
    {"id": 10, "title": "À faire", "content": "Réserver un billet d’avion"},
  ];

  // Couleurs disponibles
  final List<Color> colors = [
    const Color(0xFFFFF9C4), // jaune clair
    const Color(0xFFC8E6C9), // vert clair
    const Color(0xFFBBDEFB), // bleu clair
    const Color(0xFFFFCDD2), // rouge clair
    const Color(0xFFE0E0E0), // gris clair
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;


    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.deepPurple,
        shape: CircleBorder(),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
          padding: EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'My Notes',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              Text(
                "Organize your ideas and tasks easily",
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 15,
                ),
              ),
              SizedBox(
                height: size.height * 0.9,
                child: GridView.builder(
                  itemCount: notes.length + 1,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // 2 colonnes
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.2, // forme des cartes
                  ),
                  itemBuilder: (context, index) {
                    if (index == notes.length) {
                      // Bloc vide
                      return Container(
                        decoration: BoxDecoration(
                          color: colors.last,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.note_outlined,
                                  size: 40, color: Colors.grey),
                              SizedBox(height: 8),
                              Text(
                                'No notes click on +',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    final note = notes[index];
                    final color = colors[index % (colors.length - 1)];

                    return Container(
                      height: 10,
                      width: 10,
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(16)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            note['title'],
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            note['content'],
                            style: const TextStyle(fontSize: 15),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          )),
    );
  }
}
