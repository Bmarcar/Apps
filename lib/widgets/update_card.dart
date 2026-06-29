import 'package:flutter/material.dart';

import '../models/app_version.dart';

class UpdateCard extends StatelessWidget {
  final AppVersion version;
  final bool baixando;
  final double progresso;
  final VoidCallback onAtualizar;

  const UpdateCard({
    super.key,
    required this.version,
    required this.baixando,
    required this.progresso,
    required this.onAtualizar,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xffF5F7FA), Color(0xffE8EEF7)],
        ),
      ),
      child: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 430),
              child: Card(
                elevation: 12,
                shadowColor: Colors.black26,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28,
                    vertical: 32,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _logo(),

                      const SizedBox(height: 28),

                      _titulo(),

                      const SizedBox(height: 8),

                      _subtitulo(),

                      const SizedBox(height: 22),

                      _chipVersao(),

                      const SizedBox(height: 26),

                      _descricao(),

                      const SizedBox(height: 30),

                      _progresso(),

                      const SizedBox(height: 30),

                      _botao(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _logo() {
    return Container(
      width: 110,
      height: 110,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Image.asset("assets/images/logo.png", fit: BoxFit.contain),
      ),
    );
  }

  Widget _titulo() {
    return const Text(
      "Florida",
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w700,
        letterSpacing: 1,
      ),
    );
  }

  Widget _subtitulo() {
    return Text(
      "Nova atualização disponível",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 17,
        color: Colors.grey.shade700,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _chipVersao() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xffEEF4FF),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        "Versão ${version.version}",
        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
      ),
    );
  }

  Widget _descricao() {
    final linhas = (version.description ?? "")
        .split("\n")
        .where((e) => e.trim().isNotEmpty)
        .toList();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Novidades",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),

          const SizedBox(height: 15),

          ...linhas.map(
            (texto) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.check_circle, color: Colors.green, size: 20),

                  const SizedBox(width: 10),

                  Expanded(
                    child: Text(texto, style: const TextStyle(fontSize: 15)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _progresso() {
    if (!baixando) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: SizedBox(
            height: 12,
            child: LinearProgressIndicator(
              value: progresso,
              backgroundColor: Colors.grey.shade300,
              valueColor: const AlwaysStoppedAnimation(Color(0xff1976D2)),
            ),
          ),
        ),

        const SizedBox(height: 16),

        Text(
          "${(progresso * 100).toStringAsFixed(0)} %",
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 10),

        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(strokeWidth: 2.5),
            ),

            SizedBox(width: 12),

            Text("Baixando atualização...", style: TextStyle(fontSize: 15)),
          ],
        ),
      ],
    );
  }

  Widget _botao() {
    if (baixando) {
      return Column(
        children: [
          const SizedBox(height: 15),

          const Text(
            "Preparando instalação...",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),

          const SizedBox(height: 8),

          Text(
            "O instalador será aberto automaticamente.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey.shade700),
          ),
        ],
      );
    }

    return SizedBox(
      width: double.infinity,
      height: 58,
      child: ElevatedButton.icon(
        onPressed: onAtualizar,

        icon: const Icon(Icons.system_update_alt),

        label: const Text(
          "Atualizar agora",
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),

        style: ElevatedButton.styleFrom(
          elevation: 2,
          backgroundColor: const Color(0xff1976D2),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
    );
  }
}
