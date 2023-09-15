import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyTabbedPage(),
    );
  }
}

class MyTabbedPage extends StatefulWidget {
  @override
  _MyTabbedPageState createState() => _MyTabbedPageState();
}

class _MyTabbedPageState extends State<MyTabbedPage> {
  // Índice da guia selecionada
  int _selectedIndex = 0;

  // Lista de guias
  final List<Widget> _tabs = [
    InicioTab(),
    DocumentosTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Projeto RH'),
        
      ),
      body: _tabs[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder),
            label: 'Documentos',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}

class InicioTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Olá, Funcionário!',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Texto em branco
              ),
            ),
          ),
          SizedBox(height: 20.0), // Espaçamento entre a saudação e os anúncios
          Container(
            color: Colors.blue, // Fundo azul
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Anúncios',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Texto em branco
                  ),
                ),
                SizedBox(height: 20.0), // Espaçamento entre anúncios
                Container(
                  color: Colors.blue, // Fundo azul
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Feriados do mês de setembro',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // Texto em branco
                        ),
                      ),
                      Text(
                        '07 - Dia da independência do Brasil, será Recesso.',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.white, // Texto em branco
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.0), // Espaçamento entre anúncios
                Container(
                  color: Colors.blue, // Fundo azul
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Problemas com HOLERITES',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // Texto em branco
                        ),
                      ),
                      Text(
                        'Estamos cientes do problema para retirar holerites e estamos trabalhando em uma resolução.',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.white, // Texto em branco
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DocumentosTab extends StatefulWidget {
  @override
  _DocumentosTabState createState() => _DocumentosTabState();
}

class _DocumentosTabState extends State<DocumentosTab> {
  String selectedMonth = 'Janeiro';
  String selectedYear = '2021';

  List<String> months = [
    'Janeiro',
    'Fevereiro',
    'Março',
    'Abril',
    'Maio',
    'Junho',
    'Julho',
    'Agosto',
    'Setembro',
    'Outubro',
    'Novembro',
    'Dezembro',
  ];

  List<String> years = [
    '2021',
    '2022',
    '2023',
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Documentos',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            color: Colors.blue,
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Documentação',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10.0),
                ElevatedButton(
                  onPressed: () {
                    // Lógica para imprimir a documentação
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Colors.black,
                  ),
                  child: Text('Imprimir Documentação'),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.0), // Espaçamento entre os contêineres
          Container(
            width: double.infinity,
            color: Colors.blue,
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Holerite',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DropdownButton<String>(
                      dropdownColor: Colors.white,
                      value: selectedMonth,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedMonth = newValue!;
                        });
                      },
                      items: months.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(width: 20.0), // Espaçamento entre os dropdowns
                    DropdownButton<String>(
                      value: selectedYear,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedYear = newValue!;
                        });
                      },
                      items: years.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                ElevatedButton(
                  onPressed: () {
                    // Lógica para imprimir o holerite
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Colors.black,
                  ),
                  child: Text('Imprimir'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
