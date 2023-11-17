import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
        throw Exception('Usuario nao encontrado');
      }
    }

    Future<List<Map<String, dynamic>>> _getAnuncios() async {
      QuerySnapshot querySnapshot =
          await _firestore.collection('anuncios').get();
      List<Map<String, dynamic>> anuncios = querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();

      return anuncios;
    }

    return FutureBuilder(
      future: Future.wait([_getData(userID), _getAnuncios()]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Erro: ${snapshot.error}'));
        } else {
          List<Map<String, dynamic>> anuncios =
              snapshot.data![1] as List<Map<String, dynamic>>;
          Map<String, dynamic> usuario =
              snapshot.data![0] as Map<String, dynamic>;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                BaterPontoWidget(),
                SizedBox(height: 16.0),
                Container(
                  color: Color(0xFF99CA9B), // Alterada para a cor #99ca9b
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Anúncios',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 20.0),
                      // Use ListView.builder para construir dinamicamente os anúncios
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: anuncios.length,
                        itemBuilder: (context, index) {
                          return Container(
                            color: Color(0xFF99CA9B), // Alterada para a cor #99ca9b
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  anuncios[index]['titulo'],
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  anuncios[index]['descricao'],
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

class BaterPontoWidget extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _baterPonto(BuildContext context) async {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
    return Container(
      color: Color(0xFF99CA9B), // Alterada para a cor #99ca9b
      width: double.infinity,
      height: 150.0, // Ajuste a altura conforme necessário
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Bater Ponto',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors
                    .white, // Alterado para branco para melhor legibilidade
              ),
            ),
          ),
          SizedBox(height: 10.0),
          Center(
            // Adicionado Center para centralizar o botão
            child: ElevatedButton(
              onPressed: () => _baterPonto(context),
              child: Text('Bater Ponto'),
            ),
          ),
        ],
      ),
    );
  }
}
