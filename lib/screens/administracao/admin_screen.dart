import 'package:flutter/material.dart';
import 'categorias_screen.dart';
import 'tarefas_admin_screen.dart';
import 'package:teste_flutter_2/screens/recompensas/recompensa_list_screen.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Administração'),
      ),

      body: ListView(
        padding: const EdgeInsets.all(12),

        children: [

          _menuCard(
            context,
            icon: Icons.category,
            titulo: 'Categorias',
            subtitulo: 'Gerenciar categorias',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const CategoriasScreen(),
                ),
              );
            },
          ),

          _menuCard(
  context,
  icon: Icons.task,
  titulo: 'Tarefas',
  subtitulo: 'Criar e editar tarefas',
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const TarefasAdminScreen(),
      ),
    );
  },
),

          _menuCard(
                    context,
                    icon: Icons.card_giftcard,
                    titulo: 'Recompensas',
                    subtitulo: 'Loja e recompensas',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const RecompensaListScreen(),
                        ),
                      );
                    },
                  ),

          _menuCard(
            context,
            icon: Icons.approval,
            titulo: 'Aprovações',
            subtitulo: 'Tarefas pendentes',
            onTap: () {},
          ),

          _menuCard(
            context,
            icon: Icons.calendar_month,
            titulo: 'Calendário',
            subtitulo: 'Histórico por dia',
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _menuCard(
    BuildContext context, {
    required IconData icon,
    required String titulo,
    required String subtitulo,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(
        bottom: 12,
      ),

      child: ListTile(
        leading: Icon(
          icon,
          size: 32,
        ),

        title: Text(
          titulo,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        subtitle: Text(subtitulo),

        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
        ),

        onTap: onTap,
      ),
    );
  }
}