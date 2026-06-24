class Tarefa {
  final int id;
  final String nome;
  final String? descricao;

  final int? pontos;
  final int? xp;

  final String? categoria;
  final String? frequencia;
  final String? dificuldade;

  final bool? necessitaAprovacao;
  final bool? ativa;

  Tarefa({
    required this.id,
    required this.nome,
    this.descricao,
    this.pontos,
    this.xp,
    this.categoria,
    this.frequencia,
    this.dificuldade,
    this.necessitaAprovacao,
    this.ativa,
  });

  factory Tarefa.fromJson(Map<String, dynamic> json) {
    return Tarefa(
      id: json['id'],

      nome: json['nome'] ?? '',

      descricao: json['descricao'],

      pontos: json['pontos'],

      xp: json['xp'],

      categoria: json['categoria'],

      frequencia: json['frequencia'],

      dificuldade: json['dificuldade'],

      necessitaAprovacao: json['necessita_aprovacao'],

      ativa: json['ativa'],
    );
  }
}
