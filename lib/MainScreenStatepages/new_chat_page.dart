import 'package:flutter/material.dart';

class NewChatPage extends StatefulWidget {
  const NewChatPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NewChatPageState createState() => _NewChatPageState();
}

class _NewChatPageState extends State<NewChatPage> {
  final List<String> contacts = [
    'Ahmed Mohamed',
    'Sara Ali',
    'Omar Tarek',
    'Laila Hassan',
    'Khaled Zaki',
    'Amira Salim',
    'Mona Ezzat',
    'Youssef El-Din',
  ]; // مثال بسيط على جهات الاتصال

  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Start a New Chat'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // مربع البحث
            TextField(
              decoration: const InputDecoration(
                labelText: 'Search for a contact',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value.toLowerCase();
                });
              },
            ),
            const SizedBox(height: 20),
            // قائمة جهات الاتصال
            Expanded(
              child: ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  final contact = contacts[index];
                  if (contact.toLowerCase().contains(searchQuery)) {
                    return ListTile(
                      title: Text(contact),
                      leading: const CircleAvatar(
                        backgroundColor: Colors.blue,
                        child: Icon(Icons.person, color: Colors.white),
                      ),
                      onTap: () {
                        // يمكنك هنا الانتقال إلى صفحة الدردشة مع هذا الشخص
                        print('Start chat with $contact');
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => ChatPage(contactName: contact),
                        //   ),
                        // );
                      },
                    );
                  } else {
                    return Container(); // إخفاء جهة الاتصال إذا لم تطابق البحث
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
