class TarefaAdmin {

  final int? id;

  final String nome;

  final String? descricao;

  final int categoriaId;

  final String? categoria;

  final int dificuldadeId;

  final String? dificuldade;

  final String frequencia;

  final int pontos;

  final int xp;

  final String destinatarioTipo;

  final int? perfilDestinoId;

  final String? perfilDestino;

  final int? usuarioDestinoId;

  final String? usuarioDestino;

  final bool necessitaAprovacao;

  final bool ativa;

  final List<int> diasSemana;

  const TarefaAdmin({

    this.id,

    required this.nome,

    this.descricao,

    required this.categoriaId,

    this.categoria,

    required this.dificuldadeId,

    this.dificuldade,

    required this.frequencia,

    required this.pontos,

    required this.xp,

    required this.destinatarioTipo,

    this.perfilDestinoId,

    this.perfilDestino,

    this.usuarioDestinoId,

    this.usuarioDestino,

    required this.necessitaAprovacao,

    required this.ativa,

    required this.diasSemana,
  });

  factory TarefaAdmin.fromJson(Map<String, dynamic> json) {

    return TarefaAdmin(

      id: json['id'],

      nome: json['nome'],

      descricao: json['descricao'],

      categoriaId: json['id_categoria'],

      categoria: json['categoria'],

      dificuldadeId: json['dificuldade_id'],

      dificuldade: json['dificuldade'],

      frequencia: json['frequencia'],

      pontos: json['pontos'] ?? 0,

      xp: json['xp'] ?? 0,

      destinatarioTipo:
          json['destinatario_tipo'] ?? 'TODOS',

      perfilDestinoId:
          json['perfil_destino_id'],

      perfilDestino:
          json['perfil_destino'],

      usuarioDestinoId:
          json['usuario_destino_id'],

      usuarioDestino:
          json['usuario_destino'],

      necessitaAprovacao:
          json['necessita_aprovacao'] ?? false,

      ativa:
          json['ativa'] ?? true,

      diasSemana: const [],
    );
  }
}