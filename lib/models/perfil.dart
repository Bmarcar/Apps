class Perfil {
  final int id;
  final String nome;

  Perfil({
    required this.id,
    required this.nome,
  });

  factory Perfil.fromJson(Map<String, dynamic> json) {
    return Perfil(
      id: json['id'],
      nome: json['nome'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
    };
  }

  @override
  String toString() => nome;
}