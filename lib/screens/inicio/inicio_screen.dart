import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '/services/senssion_service.dart';

class InicioScreen extends StatefulWidget {
  const InicioScreen({super.key});

  @override
  State<InicioScreen> createState() => _InicioScreenState();
}

class _InicioScreenState extends State<InicioScreen> {
  Map<String, dynamic>? dados;
  bool carregando = true;

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  Future<void> carregarDados() async {
    try {
      // final usuarioId = Supabase.instance.client.auth.currentUser!.id;

      final usuarioId = SessionService.instance.usuarioId;

      final resultado = await Supabase.instance.client
          .from('vw_dashboard_usuario')
          .select()
          .eq('id', usuarioId)
          .single();

      setState(() {
        dados = resultado;
        carregando = false;
      });
    } catch (e) {
      debugPrint(e.toString());

      setState(() {
        carregando = false;
      });
    }
  }

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

  @override
  Widget build(BuildContext context) {
    if (carregando) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final xp = dados?['saldo_xp'] ?? 0;
    final xpMin = dados?['xp_min_nivel'] ?? 0;
    final xpMax = dados?['xp_max_nivel'] ?? 100;

    final progresso = xpMax == xpMin ? 1.0 : (xp - xpMin) / (xpMax - xpMin);

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: carregarDados,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              '$_saudacao, ${(dados?['nome'] ?? 'Jogador').split(' ')[0]}! 👋',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            // CARD PONTUAÇÃO
            Card(
              child: ListTile(
                leading: const Icon(Icons.star),
                title: const Text('Pontuação Atual'),
                subtitle: Text('${dados?['saldo_pontos'] ?? 0} pontos'),
              ),
            ),

            // CARD NÍVEL
            Card(
              child: ListTile(
                leading: const Icon(Icons.military_tech),
                title: const Text('Nível'),
                subtitle: Text('${dados?['nivel'] ?? 0}'),
              ),
            ),

            // CARD PROGRESSO
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Progresso para o próximo nível',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),

                    const SizedBox(height: 10),

                    LinearProgressIndicator(value: progresso),

                    const SizedBox(height: 10),

                    Text('$xp / $xpMax XP'),

                    const SizedBox(height: 5),

                    Text(
                      'Faltam ${xpMax - xp} XP para ${dados?['proximo_nivel']}',
                    ),
                  ],
                ),
              ),
            ),

            // CARD TAREFAS
            Card(
              child: ListTile(
                leading: const Icon(Icons.checklist),
                title: const Text('Tarefas Pendentes'),
                subtitle: Text('${dados?['tarefas_pendentes'] ?? 0} tarefas'),
              ),
            ),

            // CARD RANKING
            Card(
              child: ListTile(
                leading: const Icon(Icons.emoji_events),
                title: const Text('Posição no Ranking'),
                subtitle: Text('${dados?['posicao_ranking'] ?? '-'}º lugar'),
              ),
            ),

            // CARD CONQUISTA
            Card(
              child: ListTile(
                leading: const Icon(Icons.workspace_premium),
                title: const Text('Última Conquista'),
                subtitle: Text(
                  dados?['ultima_conquista'] ?? 'Nenhuma conquista',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
