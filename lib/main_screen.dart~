import 'package:flutter/material.dart';
import 'navigation_buttons.dart';

class MainScreen extends StatelessWidget {
  static const String routeName = '/main';

  final List<Map<String, dynamic>> lessons = [
    {'title': 'Saludos', 'completed': true, 'color': Colors.green[600]!},
    {'title': 'Números', 'completed': true, 'color': Colors.blue[600]!},
    {'title': 'Familia', 'completed': false, 'color': Colors.orange[600]!},
    {'title': 'Comida', 'completed': false, 'color': Colors.red[600]!},
    {'title': 'Animales', 'completed': false, 'color': Colors.purple[600]!},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              child: Image.network(
                'https://tse2.mm.bing.net/th?id=OIG3.LoNbQX2sRwljKQrOkvNY&pid=ImgGn',
                height: 30,
                width: 30,
              ),
            ),
            SizedBox(width: 10),
            Text(
              'RAICES',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.blue[900],
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue[900]!, Colors.blue[300]!],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                itemCount: lessons.length,
                itemBuilder: (context, index) {
                  return LessonCard(
                    title: lessons[index]['title'],
                    completed: lessons[index]['completed'],
                    color: lessons[index]['color'],
                    onTap: () {
                      print('Lección seleccionada: ${lessons[index]["title"]}');
                    },
                  );
                },
              ),
            ),
            NavigationButtons(),
          ],
        ),
      ),
    );
  }
}

class LessonCard extends StatelessWidget {
  final String title;
  final bool completed;
  final Color color;
  final VoidCallback onTap;

  const LessonCard({
    Key? key,
    required this.title,
    required this.completed,
    required this.color,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              colors: [color, color.withOpacity(0.7)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      completed ? 'Completado' : 'Por completar',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Icon(
                  completed ? Icons.check_circle : Icons.play_circle_fill,
                  color: Colors.white,
                  size: 36,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}