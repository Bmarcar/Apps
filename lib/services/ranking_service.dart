import 'package:supabase_flutter/supabase_flutter.dart';

class RankingService {
  final supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> carregarRanking() async {
    final response = await supabase
        .from('vw_ranking_usuarios')
        .select();

    return List<Map<String, dynamic>>.from(response);
  }
}