class TarefaAdmin {
  int? id;

  String nome;
  String? descricao;

  // IDs gravados na tabela
  int categoriaId;
  int dificuldadeId;

  String frequencia;

  int pontos;
  int xp;

  // Mantemos como String por enquanto.
  // Depois refatoraremos para int tipoDestinatarioId.
  int tipoDestinatarioId;

  int? perfilDestinoId;
  int? usuarioDestinoId;

  bool necessitaAprovacao;
  bool ativa;

  String? diasSemana;

  // Campos vindos da VIEW (somente leitura)
  String? categoria;
  String? dificuldade;
  String? perfilDestino;
  String? usuarioDestino;
  String? destinatarioTipo;

  TarefaAdmin({
  this.id,
  required this.nome,
  this.descricao,
  required this.categoriaId,
  required this.dificuldadeId,
  required this.frequencia,
  required this.pontos,
  required this.xp,

  required this.tipoDestinatarioId,
  this.destinatarioTipo,

  this.perfilDestinoId,
  this.usuarioDestinoId,

  required this.necessitaAprovacao,
  required this.ativa,

  required this.diasSemana,

  this.categoria,
  this.dificuldade,
  this.perfilDestino,
  this.usuarioDestino,
});

  factory TarefaAdmin.fromJson(Map<String, dynamic> json) {
    return TarefaAdmin(
      id: json['id'],

      nome: json['nome'] ?? '',

      descricao: json['descricao'],

      categoriaId: json['id_categoria'] ?? 0,

      dificuldadeId: json['dificuldade_id'] ?? 0,

      frequencia: json['frequencia'] ?? 'DIARIA',

      pontos: json['pontos'] ?? 0,

      xp: json['xp'] ?? 0,

       // Temporário até fazermos a refatoração
      tipoDestinatarioId: json['tipo_destinatario_id'] ?? 1,

      destinatarioTipo: json['destinatario_tipo']
      
      .toString(),

      perfilDestinoId: json['perfil_familia_id'],

      usuarioDestinoId: json['usuario_id'],

      necessitaAprovacao: json['necessita_aprovacao'] ?? false,

      ativa: json['ativa'] ?? true,

      diasSemana: json['dias_semana'],

      categoria: json['categoria'],

      dificuldade: json['dificuldade'],

      perfilDestino: json['perfil_destino'],

      usuarioDestino: json['usuario_destino'],
      
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'descricao': descricao,
      'id_categoria': categoriaId,
      'dificuldade_id': dificuldadeId,
      'frequencia': frequencia,
      'pontos': pontos,
      'xp': xp,

      'tipo_destinatario_id': tipoDestinatarioId,

      // Temporário
      
      'perfil_familia_id': perfilDestinoId,

      'usuario_id': usuarioDestinoId,

      'necessita_aprovacao': necessitaAprovacao,

      'ativa': ativa,
    };
  }
}
