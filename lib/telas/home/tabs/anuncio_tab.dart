import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AnuncioTab extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> _getAnuncios() async {
    QuerySnapshot querySnapshot =
        await _firestore.collection('anuncios').get();
    List<Map<String, dynamic>> anuncios = querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();

    return anuncios;
  }

  Future<Map<String, dynamic>> _getData(String userID) async {
    DocumentSnapshot documentSnapshot =
        await _firestore.collection('funcionarios').doc(userID).get();

    if (documentSnapshot.exists) {
      Map<String, dynamic> usuario =
          documentSnapshot.data() as Map<String, dynamic>;
      return usuario;
    } else {
      throw Exception('Usuário não encontrado');
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    String userID = args['userID'];

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

          return Scaffold(
            appBar: AppBar(
              title: Text('Anúncios'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  for (var anuncio in anuncios)
                    Card(
                      elevation: 3, // Adiciona uma sombra ao card
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      child: ListTile(
                        title: Text(
                          anuncio['titulo'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        subtitle: Text(anuncio['descricao']),
                      ),
                    ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
