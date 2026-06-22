import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/tarefas.dart';

class TarefaService {
  final _supabase = Supabase.instance.client;

  Future<List<Tarefa>> listarTarefas() async {
    final response = await _supabase
        .from('tarefas')
        .select()
        .eq('ativa', true)
        .order('nome');

    return response.map<Tarefa>((json) => Tarefa.fromJson(json)).toList();
  }

  Future<void> concluirTarefa(int tarefaId) async {
    await _supabase.from('execucoes_tarefa').insert({
      'usuario_id': 1,
      'tarefa_id': tarefaId,
      'data_execucao': DateTime.now().toIso8601String(),
    });
  }
}
