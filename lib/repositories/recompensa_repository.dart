import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/recompensa.dart';

class RecompensaRepository {
  final _supabase = Supabase.instance.client;

  Future<List<Recompensa>> listar({
    bool somenteAtivas = false,
  }) async {
    var query = _supabase
        .from('recompensas')
        .select();

    if (somenteAtivas) {
      query = query.eq('ativa', true);
    }

    final response = await query.order('ordem').order('nome');

    return (response as List)
        .map((e) => Recompensa.fromMap(e))
        .toList();
  }

  Future<Recompensa?> buscarPorId(int id) async {
    final response = await _supabase
        .from('recompensas')
        .select()
        .eq('id', id)
        .maybeSingle();

    if (response == null) return null;

    return Recompensa.fromMap(response);
  }

  Future<void> inserir(Recompensa recompensa) async {
    await _supabase
        .from('recompensas')
        .insert(recompensa.toMap());
  }

  Future<void> atualizar(Recompensa recompensa) async {
    await _supabase
        .from('recompensas')
        .update(recompensa.toMap())
        .eq('id', recompensa.id!);
  }

  Future<void> excluir(int id) async {
    await _supabase
        .from('recompensas')
        .delete()
        .eq('id', id);
  }

Future<void> desativar(int id) async {
  await _supabase
      .from('recompensas')
      .update({
        'ativa': false,
      })
      .eq('id', id);
}

}