import 'package:flutter/material.dart';

import '../../models/tarefa_admin.dart';
import '../../services/tarefa_admin_service.dart';
import '../tarefa/tarefa_form_screen.dart';

class TarefasAdminScreen extends StatefulWidget {
  const TarefasAdminScreen({super.key});

  @override
  State<TarefasAdminScreen> createState() => _TarefasAdminScreenState();
}

class _TarefasAdminScreenState extends State<TarefasAdminScreen> {
  final TarefaAdminService _service = TarefaAdminService();

  late Future<List<TarefaAdmin>> _future;

  @override
  void initState() {
    super.initState();

    carregar();
  }

  void carregar() {
    _future = _service.listar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tarefas')),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),

        onPressed: () async {
          await Navigator.push(
            context,

            MaterialPageRoute(builder: (_) => const TarefaFormScreen()),
          );

          setState(() {
            carregar();
          });
        },
      ),

      body: FutureBuilder<List<TarefaAdmin>>(
        future: _future,

        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final tarefas = snapshot.data!;

          if (tarefas.isEmpty) {
            return const Center(child: Text('Nenhuma tarefa cadastrada'));
          }

          return ListView.builder(
            itemCount: tarefas.length,

            itemBuilder: (context, index) {
              final tarefa = tarefas[index];

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),

                child: Padding(
                  padding: const EdgeInsets.all(12),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(
                        tarefa.nome,

                        style: const TextStyle(
                          fontWeight: FontWeight.bold,

                          fontSize: 18,
                        ),
                      ),

                      if (tarefa.descricao != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 4),

                          child: Text(tarefa.descricao!),
                        ),

                      const SizedBox(height: 10),

                      Wrap(
                        spacing: 8,

                        runSpacing: 8,

                        children: [
                          Chip(
                            avatar: const Icon(Icons.category),

                            label: Text(tarefa.categoria ?? ''),
                          ),

                          Chip(
                            avatar: const Icon(Icons.star),

                            label: Text(tarefa.dificuldade ?? ''),
                          ),

                          Chip(
                            avatar: const Icon(Icons.repeat),

                            label: Text(tarefa.frequencia),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      Text(
                        tarefa.destinatarioTipo == 'TODOS'
                            ? '👨 Toda a família'
                            : tarefa.destinatarioTipo == 'PERFIL'
                            ? '👦 ${tarefa.perfilDestinoId}'
                            : '👤 ${tarefa.usuarioDestinoId}',
                      ),

                      const SizedBox(height: 10),

                      Row(
                        children: [
                          Chip(
                            avatar: const Icon(Icons.star),

                            label: Text('${tarefa.pontos} pts'),
                          ),

                          const SizedBox(width: 8),

                          Chip(
                            avatar: const Icon(Icons.bolt),

                            label: Text('${tarefa.xp} XP'),
                          ),

                          const Spacer(),

                          IconButton(
                            onPressed: () async {
                              await Navigator.push(
                                context,

                                MaterialPageRoute(
                                  builder: (_) => const TarefaFormScreen(),
                                ),
                              );

                              setState(() {
                                carregar();
                              });
                            },

                            icon: const Icon(Icons.edit),
                          ),

                          IconButton(
                            onPressed: () {},

                            icon: const Icon(Icons.delete, color: Colors.red),
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
