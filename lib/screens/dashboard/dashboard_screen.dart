import 'package:flutter/material.dart';
import '../../services/ranking_service.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final RankingService _rankingService = RankingService();

  late Future<List<Map<String, dynamic>>> _ranking;

  @override
  void initState() {
    super.initState();
    _ranking = _rankingService.carregarRanking();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Jogo da Família')),

      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _ranking,

        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          }

          final ranking = snapshot.data ?? [];

          return ListView.builder(
            itemCount: ranking.length,

            itemBuilder: (context, index) {
              final usuario = ranking[index];

              return ListTile(
                leading: Text('${index + 1}º'),

                title: Text(usuario['nome'] ?? ''),

                subtitle: Text('${usuario['total_pontos']} pontos'),
              );
            },
          );
        },
      ),
    );
  }
}
