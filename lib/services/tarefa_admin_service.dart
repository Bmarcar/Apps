import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/tarefa_admin.dart';
import '../models/categoria.dart';
import '../models/dificuldade.dart';
import '../models/perfil.dart';
import '../models/usuario.dart';

class TarefaAdminService {
  final _supabase = Supabase.instance.client;

  Future<List<TarefaAdmin>> listar() async {
    final response = await _supabase
        .from('vw_tarefas_admin')
        .select()
        .order('nome');

  print('RETORNO TAREFAS ADMIN:');
  print(response);

    return (response as List)
        .map((json) => TarefaAdmin.fromJson(json))
        .toList();
  }

  Future<List<Categoria>> listarCategorias() async {
    final response = await _supabase
        .from('categorias')
        .select()
        .order('nome');

    return (response as List)
        .map((json) => Categoria.fromJson(json))
        .toList();
  }

  Future<List<Dificuldade>> listarDificuldades() async {
    final response = await _supabase
        .from('dificuldades_tarefa')
        .select()
        .order('id');

    return (response as List)
        .map((json) => Dificuldade.fromJson(json))
        .toList();
  }

  Future<List<Perfil>> listarPerfis() async {
    final response = await _supabase
        .from('perfis')
        .select()
        .order('nome');

    return (response as List)
        .map((json) => Perfil.fromJson(json))
        .toList();
  }

  Future<List<Usuario>> listarUsuarios() async {
    final response = await _supabase
        .from('usuarios')
        .select()
        .order('nome');

    return (response as List)
        .map((json) => Usuario.fromJson(json))
        .toList();
  }

  Future<int> inserir(Map<String, dynamic> dados) async {

  final response = await _supabase
      .from('tarefas')
      .insert(dados)
      .select('id')
      .single();

  return response['id'] as int;
}

  Future<void> atualizar(int id, Map<String, dynamic> dados) async {
  final resposta = await _supabase
      .from('tarefas')
      .update(dados)
      .eq('id', id)
      .select();

  print("UPDATE:");
  print(resposta);
}

Future<void> excluir(int id) async {
  await _supabase
      .from('tarefas')
      .delete()
      .eq('id', id);
}

Future<void> salvarDiasSemana(
  int tarefaId,
  List<int> diasSemana,
) async {

  await _supabase
      .from('tarefa_dias_semana')
      .delete()
      .eq('tarefa_id', tarefaId);

  if (diasSemana.isEmpty) return;

  final registros = diasSemana.map((dia) {
    return {
      "tarefa_id": tarefaId,
      "dia_semana": dia,
    };
  }).toList();

  await _supabase
      .from('tarefa_dias_semana')
      .insert(registros);
}

Future<List<int>> listarDiasSemana(int tarefaId) async {

  final response = await _supabase
      .from('tarefa_dias_semana')
      .select('dia_semana')
      .eq('tarefa_id', tarefaId);

  return (response as List)
      .map((e) => e['dia_semana'] as int)
      .toList();
}

}