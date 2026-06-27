class Usuario {
  final int id;
  final DateTime? createdAt;
  final String nome;
  final String? email;
  final String? senhaHash;
  final DateTime? dataNascimento;
  final String? tipoUsuario;
  final String? avatar;
  final int nivel;
  final int xpTotal;
  final bool ativo;
  final String? nomeUsuario;
  final int? perfilFamiliaId;
  final String? authUserId;

  Usuario({
    required this.id,
    this.createdAt,
    required this.nome,
    this.email,
    this.senhaHash,
    this.dataNascimento,
    this.tipoUsuario,
    this.avatar,
    required this.nivel,
    required this.xpTotal,
    required this.ativo,
    this.nomeUsuario,
    this.perfilFamiliaId,
    this.authUserId,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'] as int,

      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,

      nome: json['nome'] ?? '',

      email: json['email'],

      senhaHash: json['senha_hash'],

      dataNascimento: json['data_nascimento'] != null
          ? DateTime.parse(json['data_nascimento'])
          : null,

      tipoUsuario: json['tipo_usuario'],

      avatar: json['avatar'],

      nivel: json['nivel'] ?? 1,

      xpTotal: json['xp_total'] ?? 0,

      ativo: json['ativo'] ?? true,

      nomeUsuario: json['nome_usuario'],

      perfilFamiliaId: json['perfil_familia_id'],

      authUserId: json['auth_user_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt?.toIso8601String(),
      'nome': nome,
      'email': email,
      'senha_hash': senhaHash,
      'data_nascimento': dataNascimento?.toIso8601String(),
      'tipo_usuario': tipoUsuario,
      'avatar': avatar,
      'nivel': nivel,
      'xp_total': xpTotal,
      'ativo': ativo,
      'nome_usuario': nomeUsuario,
      'perfil_familia_id': perfilFamiliaId,
      'auth_user_id': authUserId,
    };
  }

  Usuario copyWith({
    int? id,
    DateTime? createdAt,
    String? nome,
    String? email,
    String? senhaHash,
    DateTime? dataNascimento,
    String? tipoUsuario,
    String? avatar,
    int? nivel,
    int? xpTotal,
    bool? ativo,
    String? nomeUsuario,
    int? perfilFamiliaId,
    String? authUserId,
  }) {
    return Usuario(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      nome: nome ?? this.nome,
      email: email ?? this.email,
      senhaHash: senhaHash ?? this.senhaHash,
      dataNascimento: dataNascimento ?? this.dataNascimento,
      tipoUsuario: tipoUsuario ?? this.tipoUsuario,
      avatar: avatar ?? this.avatar,
      nivel: nivel ?? this.nivel,
      xpTotal: xpTotal ?? this.xpTotal,
      ativo: ativo ?? this.ativo,
      nomeUsuario: nomeUsuario ?? this.nomeUsuario,
      perfilFamiliaId: perfilFamiliaId ?? this.perfilFamiliaId,
      authUserId: authUserId ?? this.authUserId,
    );
  }

  @override
  String toString() {
    return 'Usuario(id: $id, nome: $nome)';
  }
}
