import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/usuario.dart';

class UsuarioService {
  final _supabase = Supabase.instance.client;

  Future<List<Usuario>> listar() async {
    final response = await _supabase.from('usuarios').select().order('nome');

    return (response as List).map((json) => Usuario.fromJson(json)).toList();
  }
}
