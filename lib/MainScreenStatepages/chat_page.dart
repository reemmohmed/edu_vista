import 'package:edu_vista/MainScreenStatepages/CartPage.dart';
import 'package:edu_vista/pages/Chat_detail%20_page.dart';
import 'package:edu_vista/MainScreenStatepages/new_chat_page.dart';
import 'package:flutter/material.dart';

class ChatsPage extends StatelessWidget {
  static const String id = 'chats'; // لتعريف هذه الصفحة

  const ChatsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // قائمة المحادثات الوهمية
    final List<Map<String, String>> chats = [
      {
        'name': 'Jerry',
        'message': 'Hello!',
        'time': '12:30 PM',
        'profileImage': 'https://via.placeholder.com/150'
      },
      {
        'name': 'Sara',
        'message': 'How are you?',
        'time': '11:45 AM',
        'profileImage': 'https://via.placeholder.com/150'
      },
      {
        'name': 'Aliya',
        'message': 'What\'s up?',
        'time': 'Yesterday',
        'profileImage': 'https://via.placeholder.com/150'
      },
      {
        'name': 'Jackie',
        'message': 'See you later',
        'time': 'Monday',
        'profileImage': 'https://via.placeholder.com/150'
      },
      {
        'name': 'Jackie',
        'message': 'See you later',
        'time': 'Monday',
        'profileImage': 'https://via.placeholder.com/150'
      },
      {
        'name': 'Jackie',
        'message': 'See you later',
        'time': 'Monday',
        'profileImage': 'https://via.placeholder.com/150'
      },
      {
        'name': 'Jackie',
        'message': 'See you later',
        'time': 'Monday',
        'profileImage': 'https://via.placeholder.com/150'
      },
    ];

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CartPage()));

          // الكود الذي سيتم تنفيذه عند الضغط على الزر
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewChatPage(), // صفحة محادثة جديدة
            ),
          );
        },
        backgroundColor: Color(0xffEBEBEB), // لون الخلفية مثلما في الصورة
        child: const Icon(Icons.chat), // أيقونة الزر
      ),
      appBar: AppBar(
        title: Center(child: const Text('Chats')),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              // Action when shopping cart is clicked
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) {
          final chat = chats[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(chat['profileImage']!),
            ),
            title: Text(chat['name']!),
            subtitle: Text(chat['message']!),
            trailing: Text(chat['time']!),
            onTap: () {
              // الانتقال إلى صفحة الدردشة مع المستخدم عند النقر
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatDetailPage(
                    userName: chat['name']!,
                    profileImage: chat['profileImage']!,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
