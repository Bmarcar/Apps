import 'dart:async';

import 'package:flutter/material.dart';

import '../../repositories/usuario_repository.dart';
import '../../services/auth_service.dart';
import '../../services/senssion_service.dart';
import '../auth/login_screen.dart';
import '../home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthService _authService = AuthService();
  final UsuarioRepository _usuarioRepository = UsuarioRepository();

  @override
  void initState() {
    super.initState();

    _inicializar();
  }

  Future<void> _inicializar() async {
    await Future.delayed(const Duration(seconds: 2));

    if (!_authService.estaLogado) {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );

      return;
    }

    final authUser = _authService.usuarioAtual;

    if (authUser == null) {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );

      return;
    }

    final usuario = await _usuarioRepository.buscarPorAuthId(authUser.id);

    if (usuario == null) {
      await _authService.logout();

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );

      return;
    }

    SessionService.instance.setUsuario(usuario);

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SizedBox.expand(
        child: Image(
          image: AssetImage("assets/images/splash.png"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
