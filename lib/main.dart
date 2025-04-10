import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Busca Usuário',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const UserSearchPage(),
    );
  }
}

class UserSearchPage extends StatefulWidget {
  const UserSearchPage({super.key});

  @override
  State<UserSearchPage> createState() => _UserSearchPageState();
}

class _UserSearchPageState extends State<UserSearchPage> {
  final TextEditingController _controller = TextEditingController();
  Future<User?>? _userFuture;

  void _fetchUser() {
    final id = int.tryParse(_controller.text);
    if (id == null || id < 1 || id > 12) {
      setState(() {
        _userFuture = Future.value(null);
      });
    } else {
      setState(() {
        _userFuture = fetchUser(id);
      });
    }
  }

  Future<User?> fetchUser(int id) async {
    try {
      final response = await http.get(Uri.parse('https://reqres.in/api/users/$id'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return User.fromJson(data['data']);
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Erro ao buscar usuário');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar Usuário'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Icon(Icons.search, size: 80, color: Colors.indigo),
            const SizedBox(height: 20),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'ID do usuário (1 a 12)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton.icon(
              onPressed: _fetchUser,
              icon: const Icon(Icons.search, color: Colors.white),
              label: const Text('Buscar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 20),
            FutureBuilder<User?>(
              future: _userFuture,
              builder: (context, snapshot) {
                if (_userFuture == null) return const SizedBox();

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return const Text('Erro ao buscar usuário', style: TextStyle(color: Colors.red));
                } else if (snapshot.data == null) {
                  return const Text('Usuário não encontrado!', style: TextStyle(fontSize: 18));
                } else {
                  final user = snapshot.data!;
                  return Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(user.avatar),
                            radius: 40,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '${user.firstName} ${user.lastName}',
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 5),
                          Text(user.email),
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class User {
  final String firstName;
  final String lastName;
  final String email;
  final String avatar;

  User({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.avatar,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      avatar: json['avatar'],
    );
  }
}