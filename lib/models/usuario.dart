class Usuario {
  final int id;
  final String nome;
  final int? perfilId;

  Usuario({
    required this.id,
    required this.nome,
    this.perfilId,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'],
      nome: json['nome'] ?? '',
      perfilId: json['perfil_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'perfil_id': perfilId,
    };
  }

  @override
  String toString() => nome;
}