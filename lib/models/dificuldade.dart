class Dificuldade {
  final int id;
  final String nome;

  Dificuldade({
    required this.id,
    required this.nome,
  });

  factory Dificuldade.fromJson(Map<String, dynamic> json) {
    return Dificuldade(
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