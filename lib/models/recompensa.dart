class Recompensa {
  final int? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  final String nome;
  final String? descricao;

  final int pontos;

  final String? imagemUrl;
  final String? icone;
  final String? cor;

  final String tipo;

  final int quantidade;

  final bool ativa;

  final int ordem;

  Recompensa({
    this.id,
    this.createdAt,
    this.updatedAt,
    required this.nome,
    this.descricao,
    required this.pontos,
    this.imagemUrl,
    this.icone,
    this.cor,
    this.tipo = "INDIVIDUAL",
    this.quantidade = 1,
    this.ativa = true,
    this.ordem = 0,
  });

  factory Recompensa.fromMap(Map<String, dynamic> map) {
    return Recompensa(
      id: map["id"],
      createdAt: map["created_at"] != null
          ? DateTime.parse(map["created_at"])
          : null,
      updatedAt: map["updated_at"] != null
          ? DateTime.parse(map["updated_at"])
          : null,
      nome: map["nome"],
      descricao: map["descricao"],
      pontos: map["pontos"],
      imagemUrl: map["imagem_url"],
      icone: map["icone"],
      cor: map["cor"],
      tipo: map["tipo"] ?? "INDIVIDUAL",
      quantidade: map["quantidade"] ?? 1,
      ativa: map["ativa"] ?? true,
      ordem: map["ordem"] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "nome": nome,
      "descricao": descricao,
      "pontos": pontos,
      "imagem_url": imagemUrl,
      "icone": icone,
      "cor": cor,
      "tipo": tipo,
      "quantidade": quantidade,
      "ativa": ativa,
      "ordem": ordem,
    };
  }

  Recompensa copyWith({
    int? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? nome,
    String? descricao,
    int? pontos,
    String? imagemUrl,
    String? icone,
    String? cor,
    String? tipo,
    int? quantidade,
    bool? ativa,
    int? ordem,
  }) {
    return Recompensa(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      nome: nome ?? this.nome,
      descricao: descricao ?? this.descricao,
      pontos: pontos ?? this.pontos,
      imagemUrl: imagemUrl ?? this.imagemUrl,
      icone: icone ?? this.icone,
      cor: cor ?? this.cor,
      tipo: tipo ?? this.tipo,
      quantidade: quantidade ?? this.quantidade,
      ativa: ativa ?? this.ativa,
      ordem: ordem ?? this.ordem,
    );
  }
}