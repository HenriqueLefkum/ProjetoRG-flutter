import 'package:flutter/material.dart';
import 'tabs/inicio_tab.dart';
import 'tabs/documentos_tab.dart';
import 'tabs/perfil_tab.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final List<Widget> _tabs = [InicioTab(), DocumentosTab(), Perfil(),];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Projeto RH'),
        backgroundColor: Color(0xFF99CA9B), // Alterado para a cor #99ca9b
      ),
      body: _tabs[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: _selectedIndex == 0 ? Color(0xFF99CA9B) : null), // Adicionado a cor apenas quando o ícone está selecionado
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder, color: _selectedIndex == 1 ? Color(0xFF99CA9B) : null), // Adicionado a cor apenas quando o ícone está selecionado
            label: 'Documentos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle, color: _selectedIndex == 2 ? Color(0xFF99CA9B) : null), // Adicionado a cor apenas quando o ícone está selecionado
            label: 'Perfil',
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
