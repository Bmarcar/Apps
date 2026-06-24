import 'package:flutter/material.dart';
import 'package:teste_flutter_2/models/tarefa_concluida.dart';
import '../../models/tarefas.dart';
import '../../services/tarefa_service.dart';

const int usuarioAtual = 1;

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen>
    with SingleTickerProviderStateMixin {
  final TarefaService _service = TarefaService();

  late Future<List<Tarefa>> _future;
  late Future<List<TarefaConcluida>> _futureConcluidas;

  Widget estrelasDificuldade(String? dificuldade) {
    int quantidade = 1;

    switch (dificuldade) {
      case 'Fácil':
        quantidade = 1;
        break;

      case 'Média':
        quantidade = 2;
        break;

      case 'Difícil':
        quantidade = 3;
        break;

      case 'Épica':
        quantidade = 4;
        break;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        quantidade,
        (index) => const Icon(Icons.star, color: Colors.amber, size: 16),
      ),
    );
  }

  Color corDificuldade(String? dificuldade) {
    switch (dificuldade) {
      case 'Fácil':
        return Colors.green;

      case 'Média':
        return Colors.blue;

      case 'Difícil':
        return Colors.orange;

      case 'Épica':
        return Colors.red;

      default:
        return Colors.grey;
    }
  }

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    const usuarioAtual = 1;

    _tabController = TabController(length: 2, vsync: this);

    _future = _service.listarTarefas(usuarioAtual);

    _futureConcluidas = _service.listarConcluidas(usuarioAtual);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tarefas'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.assignment), text: 'Disponíveis'),
            Tab(icon: Icon(Icons.check_circle), text: 'Concluídas'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // ABA DISPONÍVEIS
          FutureBuilder<List<Tarefa>>(
            future: _future,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final tarefas = snapshot.data!;

              return Column(
                children: [
                  Card(
                    margin: const EdgeInsets.all(12),
                    color: Colors.blue.shade50,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Text(
                            '📅 Hoje: ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 8),

                          Text(
                            '🎯 ${tarefas.length} tarefas disponíveis',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Expanded(
                    child: ListView.builder(
                      itemCount: tarefas.length,
                      itemBuilder: (context, index) {
                        final tarefa = tarefas[index];

                        return Card(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  tarefa.nome,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                if (tarefa.descricao != null &&
                                    tarefa.descricao!.isNotEmpty)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: Text(tarefa.descricao!),
                                  ),

                                const SizedBox(height: 12),

                                Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: [
                                    if (tarefa.categoria != null)
                                      Chip(
                                        avatar: const Icon(
                                          Icons.category,
                                          size: 18,
                                        ),
                                        label: Text(tarefa.categoria!),
                                      ),

                                    if (tarefa.frequencia != null)
                                      Chip(
                                        avatar: const Icon(
                                          Icons.repeat,
                                          size: 18,
                                        ),
                                        label: Text(tarefa.frequencia!),
                                      ),

                                    if (tarefa.dificuldade != null)
                                      Chip(
                                        backgroundColor: corDificuldade(
                                          tarefa.dificuldade,
                                        ),
                                        label: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            estrelasDificuldade(
                                              tarefa.dificuldade,
                                            ),
                                            const SizedBox(width: 4),
                                            Text(tarefa.dificuldade!),
                                          ],
                                        ),
                                      ),
                                  ],
                                ),

                                const SizedBox(height: 12),

                                Row(
                                  children: [
                                    Chip(
                                      avatar: const Icon(Icons.star, size: 18),
                                      label: Text('${tarefa.pontos ?? 0} pts'),
                                    ),

                                    const SizedBox(width: 8),

                                    Chip(
                                      avatar: const Icon(Icons.bolt, size: 18),
                                      label: Text('${tarefa.xp ?? 0} XP'),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 12),

                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton.icon(
                                    onPressed: () async {
                                      try {
                                        await _service.concluirTarefa(
                                          tarefa.id,
                                          usuarioAtual,
                                        );

                                        setState(() {
                                          _future = _service.listarTarefas(
                                            usuarioAtual,
                                          );

                                          _futureConcluidas = _service
                                              .listarConcluidas(usuarioAtual);
                                        });

                                        if (mounted) {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                'Tarefa registrada',
                                              ),
                                            ),
                                          );
                                        }
                                      } catch (e) {
                                        if (mounted) {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(content: Text('Erro: $e')),
                                          );
                                        }
                                      }
                                    },
                                    icon: const Icon(Icons.check),
                                    label: const Text('Concluir'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),

          // ABA CONCLUÍDAS
          FutureBuilder<List<TarefaConcluida>>(
            future: _futureConcluidas,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final tarefas = snapshot.data!;

              if (tarefas.isEmpty) {
                return const Center(child: Text('Nenhuma tarefa concluída'));
              }

              final hoje = DateTime.now();

              final tarefasHoje = tarefas.where((t) {
                if (t.dataExecucao == null) {
                  return false;
                }

                return t.dataExecucao!.day == hoje.day &&
                    t.dataExecucao!.month == hoje.month &&
                    t.dataExecucao!.year == hoje.year;
              }).toList();

              final pontosHoje = tarefasHoje.fold<int>(
                0,
                (total, tarefa) => total + (tarefa.pontos ?? 0),
              );

              return Column(
                children: [
                  Card(
                    margin: const EdgeInsets.all(12),
                    color: Colors.green.shade50,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Text(
                            '✅ ${tarefasHoje.length} tarefas concluídas hoje',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 8),

                          Text(
                            '⭐ $pontosHoje pontos ganhos hoje',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Expanded(
                    child: ListView.builder(
                      itemCount: tarefas.length,
                      itemBuilder: (context, index) {
                        final tarefa = tarefas[index];

                        return Card(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.check_circle,
                                      color: Colors.green,
                                    ),

                                    const SizedBox(width: 8),

                                    Expanded(
                                      child: Text(
                                        tarefa.nome,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 10),

                                if (tarefa.categoria != null)
                                  Text('Categoria: ${tarefa.categoria}'),

                                if (tarefa.dificuldade != null)
                                  Text('Dificuldade: ${tarefa.dificuldade}'),

                                const SizedBox(height: 8),

                                Text(
                                  'Concluída em: '
                                  '${tarefa.dataExecucao?.day}/${tarefa.dataExecucao?.month}/${tarefa.dataExecucao?.year}',
                                ),

                                Text(
                                  'Disponível novamente: '
                                  '${tarefa.disponivelNovamente?.day}/${tarefa.disponivelNovamente?.month}/${tarefa.disponivelNovamente?.year}',
                                ),

                                const SizedBox(height: 10),

                                Row(
                                  children: [
                                    Chip(
                                      avatar: const Icon(Icons.star),
                                      label: Text('${tarefa.pontos ?? 0} pts'),
                                    ),

                                    const SizedBox(width: 8),

                                    Chip(
                                      avatar: const Icon(Icons.bolt),
                                      label: Text('${tarefa.xp ?? 0} XP'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
