import 'package:flutter/material.dart';

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
            color: Color(0xFF99CA9B), // Alterada para a cor #99ca9b
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
          SizedBox(height: 20.0),
          Container(
            width: double.infinity,
            color: Color(0xFF99CA9B), // Alterada para a cor #99ca9b
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
                      items: months.map<DropdownMenuItem<String>>(
                        (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          );
                        },
                      ).toList(),
                    ),
                    SizedBox(width: 20.0),
                    DropdownButton<String>(
                      value: selectedYear,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedYear = newValue!;
                        });
                      },
                      items: years.map<DropdownMenuItem<String>>(
                        (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          );
                        },
                      ).toList(),
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
