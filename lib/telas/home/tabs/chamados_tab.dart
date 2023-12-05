import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChamadosTab extends StatefulWidget {
  @override
  _ChamadosTabState createState() => _ChamadosTabState();
}

class _ChamadosTabState extends State<ChamadosTab> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late String userID;

  Future<List<Map<String, dynamic>>> _getChamados() async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('chamados')
        .where('userID', isEqualTo: userID)
        .get();

    List<Map<String, dynamic>> chamados = [];

    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      Map<String, dynamic> chamado = doc.data() as Map<String, dynamic>;
      chamado['chamadoID'] = doc.id; // Adiciona o chamadoID ao mapa
      chamados.add(chamado);
    }

    return chamados;
  }

  void _createChamado(String userID, String title, String desc, String to) async {
    final DocumentReference docRef = await _firestore.collection('chamados').add({
      'userID': userID,
      'title': title,
      'desc': desc,
      'to': to,
    });

    // Obtém o ID do documento recém-adicionado e o atualiza no Firestore
    await docRef.update({'chamadoID': docRef.id});

    // Atualiza a interface do widget
    setState(() {});
  }

  void _deleteChamado(String chamadoID) async {
    await _firestore.collection('chamados').doc(chamadoID).delete();

    // Atualiza a interface do widget
    setState(() {});
  }

  String _selectedOption = 'HR'; // Valor inicial do dropmenu

  // Controladores para os campos de texto
  TextEditingController _tituloController = TextEditingController();
  TextEditingController _descricaoController = TextEditingController();

  // Opções disponíveis no dropmenu
  List<String> _opcoes = ['HR', 'DTI'];

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    userID = args['userID'];

    return Scaffold(
     appBar: AppBar(
        title: Text(
          'Chamados',
          style: TextStyle(
            color: Colors.white, // Cor do texto no topo
          ),
        ),
        backgroundColor: Color(0xFF99CA9B), // Cor do AppBar
        iconTheme: IconThemeData(
          color: Colors.white, // Cor dos ícones no topo
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _tituloController,
              decoration: InputDecoration(
                labelText: 'Título',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _descricaoController,
              decoration: InputDecoration(
                labelText: 'Descrição',
              ),
              maxLines: null,
            ),
            SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              value: _selectedOption,
              items: _opcoes.map((opcao) {
                return DropdownMenuItem<String>(
                  value: opcao,
                  child: Text(opcao),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  _selectedOption = value ?? 'HR';
                });
              },
              decoration: InputDecoration(
                labelText: 'Para',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              
              onPressed: () {
                _enviarChamado();
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF99CA9B)
              ),
              child: Text('Enviar'),
            ),
            SizedBox(height: 16.0),
            FutureBuilder(
              future: _getChamados(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Erro: ${snapshot.error}');
                } else {
                  List<Map<String, dynamic>> chamados =
                      snapshot.data as List<Map<String, dynamic>>;
                  return Expanded(
                    child: ListView.builder(
                      itemCount: chamados.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(chamados[index]['title']),
                          subtitle: Text(chamados[index]['desc']),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              _deleteChamado(chamados[index]['chamadoID']);
                            },
                          ),
                        );
                      },
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

  void _enviarChamado() {
    String titulo = _tituloController.text;
    String descricao = _descricaoController.text;

    if (titulo.isNotEmpty && descricao.isNotEmpty) {
      _createChamado(userID, titulo, descricao, _selectedOption);
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Erro'),
            content: Text('Preencha todos os campos'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
