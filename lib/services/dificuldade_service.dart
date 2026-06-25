import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/dificuldade.dart';

class DificuldadeService {
  final _supabase = Supabase.instance.client;

  Future<List<Dificuldade>> listar() async {
    final response = await _supabase
        .from('dificuldades_tarefa')
        .select()
        .order('id');

    return (response as List)
        .map((json) => Dificuldade.fromJson(json))
        .toList();
  }
}
