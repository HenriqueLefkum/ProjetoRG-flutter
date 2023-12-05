import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PontoTab extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _baterPonto(BuildContext context) async {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    String userID = args['userID'];
    // Obter a data e hora atuais
    DateTime dataHoraAtual = DateTime.now();

    await _firestore.collection('registros-pontos').add({
      'DATAHORA': dataHoraAtual,
      'USERID': userID,
    });

    // Mostrar um pop-up
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Bater Ponto'),
          content: Text('Deseja bater o ponto agora em $dataHoraAtual?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Adicione aqui a lógica para bater o ponto digitalmente
                // Pode chamar uma função, enviar uma requisição para o servidor, etc.
                print('Ponto batido em: $dataHoraAtual');
                Navigator.of(context).pop(); // Fecha o pop-up
              },
              child: Text('Sim'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o pop-up
              },
              child: Text('Não'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bater Ponto'),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black), // Cor do ícone de voltar
      ),
      body: Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder(
              future: _getHorarioAtual(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else {
                  String horarioAtual = snapshot.data as String;
                  return Text(
                    horarioAtual,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  );
                }
              },
            ),
            SizedBox(height: 10.0),
            Text(
              'Bater Ponto',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10.0),
            Center(
              child: ElevatedButton(
                onPressed: () => _baterPonto(context),
                child: Text('Bater Ponto'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<String> _getHorarioAtual() async {
    DateTime now = DateTime.now();
    String formattedTime = '${now.hour}:${now.minute}';
    return formattedTime;
  }
}
