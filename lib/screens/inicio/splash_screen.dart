import 'dart:async';
import 'package:flutter/material.dart';
import '../../repositories/usuario_repository.dart';
import '../../services/auth_service.dart';
import '../../services/senssion_service.dart';
import '../auth/login_screen.dart';
import '../home/home_screen.dart';

import '../../models/app_version.dart';
import '../../services/update_service.dart';
import '../../manegers/update_maneger.dart';
import '../../widgets/update_card.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthService _authService = AuthService();
  final UsuarioRepository _usuarioRepository = UsuarioRepository();

  final UpdateService _updateService = UpdateService();
  final UpdateManager _updateManager = UpdateManager();

  bool _temAtualizacao = false;
  bool _baixando = false;

  double _progresso = 0;

  AppVersion? _novaVersao;

  @override
  void initState() {
    super.initState();

    _inicializar();
  }

  Future<void> _inicializar() async {
    await Future.delayed(const Duration(seconds: 2));

    final update = await _updateService.checkForUpdate();

    if (update != null) {
      setState(() {
        _temAtualizacao = true;
        _novaVersao = update;
      });

      return;
    }

    // continua a lógica de login...

    if (!_authService.estaLogado) {
      print("7 - Usuário NÃO está logado");
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );

      return;
    }

    print("8 - Usuário logado");
    final authUser = _authService.usuarioAtual;

    if (authUser == null) {
      print("9 - AuthUser é null");
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );

      return;
    }

    print("10 - AuthUser OK");

    final usuario = await _usuarioRepository.buscarPorAuthId(authUser.id);

    if (usuario == null) {
      print("11 - Usuário não encontrado");
      await _authService.logout();

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );

      return;
    }

    print("12 - Usuário encontrado");

    SessionService.instance.setUsuario(usuario);

    print("13 - Indo para Home");

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _temAtualizacao
          ? UpdateCard(
              version: _novaVersao!,
              baixando: _baixando,
              progresso: _progresso,
              onAtualizar: _baixarAtualizacao,
            )
          : const SizedBox.expand(
              child: Image(
                image: AssetImage("assets/images/splash.png"),
                fit: BoxFit.cover,
              ),
            ),
    );
  }

  Future<void> _baixarAtualizacao() async {
    if (_novaVersao == null) return;

    setState(() {
      _baixando = true;
    });

    try {
      print("APK URL:");
      print(_novaVersao!.apkUrl);
      final apk = await _updateManager.downloadApk(
        url: _novaVersao!.apkUrl,
        onProgress: (progress) {
          setState(() {
            _progresso = progress;
          });
        },
      );

      await _updateManager.installApk(apk);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));

      setState(() {
        _baixando = false;
      });
    }
  }
}
