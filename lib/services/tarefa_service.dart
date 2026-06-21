import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/tarefas.dart';

class TarefaService {
  final _supabase = Supabase.instance.client;

  Future<List<Tarefa>> listarTarefas() async {
    final response = await _supabase
        .from('vw_tarefas')
        .select()
        .eq('ativa', true)
        .order('nome');

    return response.map<Tarefa>((json) => Tarefa.fromJson(json)).toList();
  }
}
