import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/perfil.dart';

class PerfilService {
  final _supabase = Supabase.instance.client;

  Future<List<Perfil>> listar() async {
    final response = await _supabase
        .from('perfil_familia')
        .select()
        .order('nome');

    return (response as List).map((json) => Perfil.fromJson(json)).toList();
  }
}
