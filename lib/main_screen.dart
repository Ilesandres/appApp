import 'package:flutter/material.dart';
import 'navigation_buttons.dart';

class MainScreen extends StatelessWidget {
  static const String routeName = '/main';

  final List<Lesson> lessons = [
    Lesson(title: 'Saludos', completed: true, color: Colors.green[600]!),
    Lesson(title: 'Números', completed: true, color: Colors.blue[600]!),
    Lesson(title: 'Familia', completed: false, color: Colors.orange[600]!),
    Lesson(title: 'Comida', completed: false, color: Colors.red[600]!),
    Lesson(title: 'Animales', completed: false, color: Colors.purple[600]!),
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
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.person, color: Colors.grey, size: 30);
                },
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
                    lesson: lessons[index],
                    onTap: () {
                      print('Lección seleccionada: ${lessons[index].title}');
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

class Lesson {
  final String title;
  final bool completed;
  final Color color;

  Lesson({
    required this.title,
    required this.completed,
    required this.color,
  });
}
