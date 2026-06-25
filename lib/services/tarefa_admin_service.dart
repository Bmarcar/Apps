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
}