import 'package:flutter/material.dart';
import '../../models/tarefas.dart';
import '../../services/tarefa_service.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  final TarefaService _service = TarefaService();

  late Future<List<Tarefa>> _future;

  @override
  void initState() {
    super.initState();
    _future = _service.listarTarefas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tarefas')),
      body: FutureBuilder<List<Tarefa>>(
        future: _future,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final tarefas = snapshot.data!;

          return ListView.builder(
            itemCount: tarefas.length,
            itemBuilder: (context, index) {
              final tarefa = tarefas[index];

              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
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
                      Text(tarefa.descricao ?? ''),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Chip(label: Text('${tarefa.pontos ?? 0} pts')),
                          ElevatedButton(
                            onPressed: () async {
                              print('CLICOU NA TAREFA ${tarefa.id}');

                              try {
                                await _service.concluirTarefa(tarefa.id);

                                print('GRAVOU COM SUCESSO');

                                if (mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Tarefa registrada'),
                                    ),
                                  );
                                }
                              } catch (e) {
                                print('ERRO: $e');

                                if (mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Erro: $e')),
                                  );
                                }
                              }
                            },
                            child: const Text('Concluir'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
