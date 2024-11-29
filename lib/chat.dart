import 'package:flutter/material.dart';
import 'navigation_buttons.dart';

class Chat extends StatelessWidget {
  static const String routeName = '/chat';

  const Chat({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> conversations = [
      {
        'title': 'Buenos días',
        'language': 'Kamentsa',
        'messages': [
          {'text': 'Botamán binÿe', 'translation': '¡Buenos días!', 'isUser': false},
          {'text': '¿Ntsäm tcojatsjinÿna?', 'translation': '¿Cómo amaneciste?', 'isUser': false},
          {'text': 'Botamán binÿe, ts̈abá sënjatsjinÿna, jtsimpadesesëngcá', 'translation': 'Buenos días, amanecí bien, gracias.', 'isUser': true},
        ]
      },
      {
        'title': 'Buenas tardes',
        'language': 'Kamentsa',
        'messages': [
          {'text': 'Botamán yebtsana', 'translation': 'Buenas tardes.', 'isUser': false},
          {'text': '¿Ntsäm entsemna akna te?', 'translation': '¿Cómo va tu día?', 'isUser': false},
          {'text': 'Botamán yebtsana, ats̈be te entsemna ts̈abá', 'translation': 'Buenas tardes, mi día va bien.', 'isUser': true},
        ]
      },
      {
        'title': 'Buenas noches',
        'language': 'Kamentsa',
        'messages': [
          {'text': 'Botamán ibet', 'translation': 'Buenas noches.', 'isUser': false},
          {'text': '¿Ntsäm yojtsemna akna te?', 'translation': '¿Qué tal estuvo tu día?', 'isUser': false},
          {'text': 'Botamán ibet, ats̈be te yojtsemna puerte ts̈abá', 'translation': 'Buenas noches, mi día estuvo productivo.', 'isUser': true},
        ]
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Conversaciones en Kamentsa'),
        backgroundColor: Colors.blue[900],
        elevation: 0,
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
                itemCount: conversations.length,
                itemBuilder: (context, index) {
                  return ConversationCard(conversation: conversations[index]);
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

class ConversationCard extends StatelessWidget {
  final Map<String, dynamic> conversation;

  const ConversationCard({Key? key, required this.conversation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        title: Text(
          conversation['title'],
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Text(
          'Lengua: ${conversation['language']}',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
        trailing: Icon(Icons.chat_bubble_outline, color: Colors.blue[900]),
        onTap: () {
          _showConversationDialog(context, conversation);
        },
      ),
    );
  }

void _showConversationDialog(BuildContext context, Map<String, dynamic> conversation) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        insetPadding: EdgeInsets.zero,
        child: Container(
          width: double.infinity,
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.7,
            maxWidth: MediaQuery.of(context).size.width * 0.9,
          ),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),              
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: Colors.blue[900],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      conversation['title'],
                      style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                      
            
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Lengua: ${conversation['language']}',
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                      
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(16),
                  itemCount: (conversation['messages'] as List).length,
                  itemBuilder: (context, index) {
                    final message = conversation['messages'][index];
                    return MessageBubble(
                      text: message['text'],
                      translation: message['translation'],
                      isUser: message['isUser'],
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[900],
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  child: Text(
                    'Cerrar',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
}
class MessageBubble extends StatelessWidget {
  final String text;
  final String translation;
  final bool isUser;

  const MessageBubble({Key? key, required this.text, required this.translation, required this.isUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isUser ? Colors.blue[100] : Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.play_arrow, size: 20),
                  onPressed: () {
                    // TODO: Implementar reproducción de audio
                    print('Reproduciendo audio: $text');
                  },
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                ),
                SizedBox(width: 8),
                Flexible(
                  child: Text(
                    text,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            SizedBox(height: 4),
            Text(
              translation,
              style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}