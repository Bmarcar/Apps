import 'package:flutter/material.dart';

import '../../services/auth_service.dart';
import '../../services/senssion_service.dart';

import '../dashboard/dashboard_screen.dart';
import '../tarefa/tarefa_screen.dart';
import '../inicio/inicio_screen.dart';
import '../administracao/admin_screen.dart';
import '../auth/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthService _authService = AuthService();

  int _paginaAtual = 0;

  final List<Widget> _paginas = const [
    InicioScreen(),
    DashboardScreen(),
    TasksScreen(),
  ];

  String get _saudacao {
    final hora = DateTime.now().hour;

    if (hora < 12) {
      return "Bom dia";
    }

    if (hora < 18) {
      return "Boa tarde";
    }

    return "Boa noite";
  }

  Future<void> _logout() async {
    await _authService.logout();

    SessionService.instance.limparSessao();

    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final nome = SessionService.instance.nome;

    final administrador =
        (SessionService.instance.tipoUsuario ?? '').trim().toLowerCase() ==
        'administrador';

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        titleSpacing: 10,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset("assets/images/logo.png", width: 36, height: 36),
            const SizedBox(width: 10),
            const Text(
              "Florida",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ],
        ),

        actions: [
          if (administrador)
            IconButton(
              tooltip: "Administração",
              icon: const Icon(Icons.settings),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AdminScreen()),
                );
              },
            ),

          IconButton(
            tooltip: "Sair",
            icon: const Icon(Icons.logout),
            onPressed: _logout,
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
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Início"),

          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events),
            label: "Ranking",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.checklist),
            label: "Tarefas",
          ),
        ],
      ),
    );
  }
}
