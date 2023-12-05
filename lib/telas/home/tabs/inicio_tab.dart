import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'anuncio_tab.dart'; // Importe a tela de anúncios
import 'ponto_tab.dart'; // Importe a tela de ponto
import 'chamados_tab.dart';

class InicioTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    String cpf = args['cpf'];
    String userID = args['userID'];

    Future<Map<String, dynamic>> _getData(String userID) async {
      DocumentSnapshot documentSnapshot =
          await _firestore.collection('funcionarios').doc(userID).get();

      if (documentSnapshot.exists) {
        Map<String, dynamic> usuario =
            documentSnapshot.data() as Map<String, dynamic>;
        return usuario;
      } else {
        throw Exception('Usuario não encontrado');
      }
    }

    return FutureBuilder(
      future: _getData(userID),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Erro: ${snapshot.error}'));
        } else {
          Map<String, dynamic> usuario = snapshot.data as Map<String, dynamic>;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Olá, ${usuario['NOME']}!',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Botão para a tela de Anúncios
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AnuncioTab(),
                            settings: RouteSettings(
                              arguments: {'userID': args['userID']},
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue, // Cor de fundo do botão
                        onPrimary: Colors.white, // Cor do texto do botão
                        minimumSize: Size(150.0, 150.0), // Define o tamanho mínimo
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.message, size: 40),
                          Text('Anúncios'),
                        ],
                      ),
                    ),
                    // Botão para a tela de Ponto
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PontoTab(),
                            settings: RouteSettings(
                              arguments: {'userID': args['userID']},
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green, // Cor de fundo do botão
                        onPrimary: Colors.white, // Cor do texto do botão
                        minimumSize: Size(150.0, 150.0), // Define o tamanho mínimo
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.access_time, size: 40),
                          Text('Ponto'),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0), // Adiciona um espaçamento entre as linhas
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Botão para a tela de Chamados
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChamadosTab(),
                            settings: RouteSettings(
                              arguments: {'userID': args['userID']},
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red, // Cor de fundo do botão
                        onPrimary: Colors.white, // Cor do texto do botão
                        minimumSize: Size(150.0, 150.0), // Define o tamanho mínimo
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.call, size: 40),
                          Text('Chamados'),
                        ],
                      ),
                    ),
                    // Adicione aqui um segundo botão conforme necessário
                  ],
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
