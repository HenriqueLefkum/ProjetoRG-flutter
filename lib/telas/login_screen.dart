import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _cpfController = TextEditingController();
  final _firestore = FirebaseFirestore.instance;

  bool isLogoRotated = false;

  Future<void> _verificaCPF() async {
    String cpf = _cpfController.text;

    QuerySnapshot querySnapshot = await _firestore
        .collection('funcionarios')
        .where('CPF', isEqualTo: cpf)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      String userID = querySnapshot.docs.first.id;
      Navigator.pushReplacementNamed(context, '/home',
          arguments: {'cpf': cpf, 'userID': userID});
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("CPF não encontrado"),
            content: Text("O CPF informado não foi encontrado. Entre em contato com a administração."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  isLogoRotated = !isLogoRotated;
                });
              },
              child: Transform.rotate(
                angle: isLogoRotated ? 0.174533 : 0, // 0.174533 radianos = 10 graus
                child: Container(
                  margin: EdgeInsets.only(bottom: 20.0),
                  child: Text(
                    'BG',
                    style: TextStyle(
                      fontSize: 80.0, // Aumentei o tamanho da fonte
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // Alterei a cor para preto
                    ),
                  ),
                ),
              ),
            ),
            TextField(
              controller: _cpfController,
              decoration: InputDecoration(labelText: 'CPF'),
              keyboardType: TextInputType.number, // Alterei para exibir o teclado numérico
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => _verificaCPF(),
              child: Text(
                'Login',
                style: TextStyle(color: Colors.white), // Alterei a cor do texto para branco
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.grey, // Alterei a cor do botão para cinza
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20), // Aumentei o tamanho do botão
              ),
            ),
          ],
        ),
      ),
    );
  }
}
