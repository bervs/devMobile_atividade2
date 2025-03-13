import 'package:flutter/material.dart';

class Segunda extends StatelessWidget {
  final String resultado;
  final String imagemJogador;
  final String imagemApp;

  const Segunda({
    Key? key,
    required this.resultado,
    required this.imagemJogador,
    required this.imagemApp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String iconeResultado = '';
    String descricaoResultado = '';

    if (resultado == 'Você Venceu') {
      iconeResultado = 'assets/images/icons8-vitória-48.png';
      descricaoResultado = 'Vitória!';
    } else if (resultado == 'Você Perdeu') {
      iconeResultado = 'assets/images/icons8-perder-48.png';
      descricaoResultado = 'Derrota!';
    } else {
      iconeResultado = 'assets/images/icons8-aperto-de-mãos-100.png';
      descricaoResultado = 'Empate!';
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Resultado'),
        backgroundColor: const Color(0xDFFF1F1F),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(imagemApp, width: 100),
            const SizedBox(height: 8),
            const Text('Escolha do App', style: TextStyle(fontSize: 18)),

            const SizedBox(height: 20),

            Image.asset(imagemJogador, width: 100),
            const SizedBox(height: 8),
            const Text('Sua Escolha', style: TextStyle(fontSize: 18)),

            const SizedBox(height: 20),

            Image.asset(iconeResultado, width: 100),
            const SizedBox(height: 8),
            Text(descricaoResultado, style: const TextStyle(fontSize: 18)),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xDFFF1F1F),
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                textStyle: const TextStyle(fontSize: 18),
              ),
              child: const Text("Jogar Novamente"),
            ),
          ],
        ),
      ),
    );
  }
}
