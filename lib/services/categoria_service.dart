import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/categoria.dart';

class CategoriaService {
  final _supabase = Supabase.instance.client;

  Future<List<Categoria>> listar() async {
    final response = await _supabase
        .from('categorias')
        .select()
        .order('nome');

    return response
        .map<Categoria>(
          (json) => Categoria.fromJson(json),
        )
        .toList();
  }

  Future<void> inserir(String nome) async {
    await _supabase.from('categorias').insert({
      'nome': nome,
    });
  }

  Future<void> atualizar(
    int id,
    String nome,
  ) async {
    await _supabase
        .from('categorias')
        .update({
          'nome': nome,
        })
        .eq('id', id);
  }

  Future<void> excluir(int id) async {
    await _supabase
        .from('categorias')
        .delete()
        .eq('id', id);
  }
}