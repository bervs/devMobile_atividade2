import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:http/http.dart' as http;
import 'dart:convert';
=======
import 'dart:math';
import 'segunda.dart';
>>>>>>> 91b5881ddc74ee056146909d98b3d62d28755772

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
<<<<<<< HEAD
      title: 'Busca Usuário',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const UserSearchPage(),
=======
      debugShowCheckedModeBanner: false,
      title: 'Pedra, Papel, Tesoura',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: false,
      ),
      home: const MyHomePage(),
>>>>>>> 91b5881ddc74ee056146909d98b3d62d28755772
    );
  }
}

<<<<<<< HEAD
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
=======
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void jogar(String escolhaUsuario) {
    final opcoes = ['pedra', 'papel', 'tesoura'];
    final escolhaComputador = opcoes[Random().nextInt(3)];

    String resultado;
    if (escolhaUsuario == escolhaComputador) {
      resultado = 'Empate';
    } else if ((escolhaUsuario == 'pedra' && escolhaComputador == 'tesoura') ||
        (escolhaUsuario == 'papel' && escolhaComputador == 'pedra') ||
        (escolhaUsuario == 'tesoura' && escolhaComputador == 'papel')) {
      resultado = 'Você Venceu';
    } else {
      resultado = 'Você Perdeu';
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Segunda(
          resultado: resultado,
          imagemJogador: 'assets/images/$escolhaUsuario.png',
          imagemApp: 'assets/images/$escolhaComputador.png',
>>>>>>> 91b5881ddc74ee056146909d98b3d62d28755772
        ),
      ),
    );
  }
<<<<<<< HEAD
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
=======

  @override
  Widget build(BuildContext context) {
    double imageSize = MediaQuery.of(context).size.width * 0.25;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xDFFF1F1F),
        title: const Text(
          'Pedra, Papel, Tesoura',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 4,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset('assets/images/padrao.png', width: imageSize),
          const SizedBox(height: 10),
          const Text(
            'Escolha do App',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 30),

          const Text(
            'Escolha sua jogada:',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),


          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => jogar('pedra'),
                child: Image.asset('assets/images/pedra.png', width: imageSize),
              ),
              const SizedBox(width: 20),
              GestureDetector(
                onTap: () => jogar('papel'),
                child: Image.asset('assets/images/papel.png', width: imageSize),
              ),
              const SizedBox(width: 20),
              GestureDetector(
                onTap: () => jogar('tesoura'),
                child: Image.asset('assets/images/tesoura.png', width: imageSize),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
>>>>>>> 91b5881ddc74ee056146909d98b3d62d28755772
