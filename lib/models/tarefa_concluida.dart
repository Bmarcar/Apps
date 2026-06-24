class TarefaConcluida {
  final int id;
  final String nome;
  final String? categoria;
  final String? dificuldade;
  final int? pontos;
  final int? xp;
  final DateTime? dataExecucao;
  final DateTime? disponivelNovamente;

  TarefaConcluida({
    required this.id,
    required this.nome,
    this.categoria,
    this.dificuldade,
    this.pontos,
    this.xp,
    this.dataExecucao,
    this.disponivelNovamente,
  });

  factory TarefaConcluida.fromJson(Map<String, dynamic> json) {
    return TarefaConcluida(
      id: json['id'],
      nome: json['nome'],
      categoria: json['categoria'],
      dificuldade: json['dificuldade'],
      pontos: json['pontos'],
      xp: json['xp'],
      dataExecucao: json['data_execucao'] != null
          ? DateTime.parse(json['data_execucao'])
          : null,
      disponivelNovamente: json['disponivel_novamente'] != null
          ? DateTime.parse(json['disponivel_novamente'])
          : null,
    );
  }
}
