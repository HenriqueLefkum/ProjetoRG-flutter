import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Perfil extends StatelessWidget {
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
        throw Exception('Usuário não encontrado');
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
          // Aqui você tem o usuário do Firestore
          Map<String, dynamic> usuario =
              snapshot.data as Map<String, dynamic>;

          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 8.0),
                  child: Icon(
                    Icons.account_circle,
                    size: 96.0,
                    color: Color(0xFF99CA9B), // Alterado para a cor #99ca9b
                  ),
                ),
                Text(
                  usuario['NOME'] ?? 'Nome não disponível',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF99CA9B), // Alterado para a cor #99ca9b
                  ),
                ),
                SizedBox(height: 16.0),
                Wrap(
                  spacing: 16.0,
                  runSpacing: 16.0,
                  children: [
                    buildDataRow("DATANAS", usuario['DATANAS'] ?? 'Dado Indisponivel'),
                    buildDataRow("CPF", usuario['CPF'] ?? 'Dado Indisponivel'),
                    buildDataRow("TEL", usuario['TEL'] ?? 'Dado Indisponivel'),
                    buildDataRow("ECIVIL", usuario['ECIVIL'] ?? 'Dado Indisponivel'),
                    buildDataRow("EEXP", usuario['EEXP'] ?? 'Dado Indisponivel'),
                    buildDataRow("CEP", usuario['CEP'] ?? 'Dado Indisponivel'),
                    buildDataRow("CIDADE", usuario['CIDADE'] ?? 'Dado Indisponivel'),
                    buildDataRow("ENDEREÇO", usuario['ENDERECO'] ?? 'Endereço não disponível'),
                    buildDataRow("ENUM", usuario['ENUM'] ?? 'Dado Indisponivel'),
                    buildDataRow("FUNÇÃO", usuario['FUNCAO'] ?? 'Função não disponível'),
                    buildDataRow("ESCOLARIDADE", usuario['ESCOLARIDADE'] ?? 'Dado Indisponivel'),
                    buildDataRow("NACIO", usuario['NACIO'] ?? 'Dado Indisponivel'),
                    buildDataRow("NESCOLARIDADE", usuario['NESCOLARIDADE'] ?? 'Dado Indisponivel'),
                    buildDataRow("NMAE", usuario['NMAE'] ?? 'Dado Indisponivel'),
                    buildDataRow("NPAI", usuario['NPAI'] ?? 'Dado Indisponivel'),
                    buildDataRow("SALHORA", usuario['SALHORA'] ?? 'Dado Indisponivel'),
                    buildDataRow("SALEXTRA", usuario['SALEXTRA'] ?? 'Dado Indisponivel'),
                    buildDataRow("UF", usuario['UF'] ?? 'Dado Indisponivel'),
                    buildDataRow("UFNAT", usuario['UFNAT'] ?? 'Dado Indisponivel'),
                    buildDataRow("VINCULADO", usuario['VINCULADO'] ?? 'Dado Indisponivel'),
                  ],
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Widget buildDataRow(String label, String value) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF99CA9B), // Alterado para a cor #99ca9b
              ),
            ),
          ),
          SizedBox(width: 8),
          Flexible(
            child: Text(
              value,
              style: TextStyle(fontSize: 16, color: Color(0xFF99CA9B)), // Alterado para a cor #99ca9b
            ),
          ),
        ],
      ),
    );
  }
}
