import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/tarefas.dart';
import '../models/tarefa_concluida.dart';

class TarefaService {
  final _supabase = Supabase.instance.client;

  Future<List<Tarefa>> listarTarefas(int usuarioId) async {
    final response = await _supabase.from('vw_tarefas_disponiveis').select();
    print('USUARIO: $usuarioId');
    print('QTD: ${response.length}');
    print(response);
    return response.map<Tarefa>((json) => Tarefa.fromJson(json)).toList();
  }

  Future<void> concluirTarefa(int tarefaId, int usuarioId) async {
    await _supabase.from('execucoes_tarefa').insert({
      'usuario_id': usuarioId,
      'tarefa_id': tarefaId,
      'data_execucao': DateTime.now().toIso8601String(),
    });
  }

  Future<List<TarefaConcluida>> listarConcluidas(int usuarioId) async {
    final response = await _supabase
        .from('vw_tarefas_concluidas')
        .select()
        .eq('usuario_id', usuarioId);

    return response
        .map<TarefaConcluida>((json) => TarefaConcluida.fromJson(json))
        .toList();
  }
}
