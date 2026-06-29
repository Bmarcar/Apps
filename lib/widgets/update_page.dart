import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UpdatePage extends ConsumerWidget {
  const UpdatePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(updateProvider);
    final notifier = ref.read(updateProvider.notifier);

    return Scaffold(
      backgroundColor: const Color(0xffF3F4F6),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Card(
              elevation: 8,
              margin: const EdgeInsets.all(24),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              child: Padding(
                padding: const EdgeInsets.all(28),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 45,
                      backgroundColor: Colors.transparent,
                      backgroundImage: const AssetImage(
                        "assets/images/logo.png",
                      ),
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      "Florida",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      state.version == null
                          ? "Verificando atualização..."
                          : "Nova versão disponível",
                      style: TextStyle(color: Colors.grey.shade700),
                    ),

                    const SizedBox(height: 25),

                    if (state.version != null)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "Versão ${state.version!.version}",
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 15),

                            Text(
                              state.version!.description ?? "",
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),

                    const SizedBox(height: 25),

                    if (state.status == UpdateStatus.downloading)
                      Column(
                        children: [
                          LinearProgressIndicator(
                            value: state.progress,
                            minHeight: 10,
                            borderRadius: BorderRadius.circular(20),
                          ),

                          const SizedBox(height: 12),

                          Text(
                            "${(state.progress * 100).toStringAsFixed(0)} %",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),

                    if (state.status == UpdateStatus.available)
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            notifier.downloadUpdate();
                          },
                          icon: const Icon(Icons.download),
                          label: const Text("Atualizar agora"),
                        ),
                      ),

                    if (state.status == UpdateStatus.installing)
                      const Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Column(
                          children: [
                            CircularProgressIndicator(),

                            SizedBox(height: 15),

                            Text("Preparando instalação..."),
                          ],
                        ),
                      ),

                    if (state.status == UpdateStatus.error)
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(
                          state.message ?? "",
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
