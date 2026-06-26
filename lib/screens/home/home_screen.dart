import 'package:flutter/material.dart';
import '../dashboard/dashboard_screen.dart';
import '/screens/tarefa/tarefa_screen.dart';
import '/screens/inicio/inicio_screen.dart';
import '/screens/administracao/admin_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _paginaAtual = 0;

  final List<Widget> _paginas = [
    const InicioScreen(),
    const DashboardScreen(),
    const TasksScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
    title: const Text('Florida'),
    actions: [
      IconButton(
        icon: const Icon(Icons.settings),
        tooltip: 'Administração',
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AdminScreen(),
            ),
          );
        },
      ),
    ],
  ),
      
      body: _paginas[_paginaAtual],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _paginaAtual,
        onTap: (index) {
          setState(() {
            _paginaAtual = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Início'),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events),
            label: 'Ranking',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.checklist),
            label: 'Tarefas',
          ),
        ],
      ),
    );
  }
}
