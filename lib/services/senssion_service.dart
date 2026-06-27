import '../models/usuario.dart';

class SessionService {
  SessionService._();

  static final SessionService instance = SessionService._();

  Usuario? _usuario;

  Usuario? get usuario => _usuario;

  bool get estaLogado => _usuario != null;

  int get usuarioId {
    if (_usuario == null) {
      throw Exception('Nenhum usuário está na sessão.');
    }

    return _usuario!.id;
  }

  String get nome => _usuario?.nome ?? "";

  String get email => _usuario?.email ?? "";

  String get tipoUsuario => _usuario?.tipoUsuario ?? "";

  int? get perfilFamiliaId => _usuario?.perfilFamiliaId;

  void setUsuario(Usuario usuario) {
    _usuario = usuario;
  }

  void limparSessao() {
    _usuario = null;
  }
}
