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
                child: ListTile(
                  title: Text(tarefa.nome),
                  subtitle: Text(tarefa.descricao ?? ''),
                  trailing: Chip(label: Text('${tarefa.pontos ?? 0} pts')),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
