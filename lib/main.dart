import 'package:flutter/material.dart';
import 'dart:math';
import 'segunda.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pedra, Papel, Tesoura',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: false,
      ),
      home: const MyHomePage(),
    );
  }
}

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
        ),
      ),
    );
  }

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
