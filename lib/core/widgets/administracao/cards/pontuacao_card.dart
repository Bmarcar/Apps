import 'package:flutter/material.dart';

class PontuacaoCard extends StatelessWidget {
  final int pontos;
  final int xp;

  final ValueChanged<int> onPontosChanged;
  final ValueChanged<int> onXpChanged;

  const PontuacaoCard({
    super.key,
    required this.pontos,
    required this.xp,
    required this.onPontosChanged,
    required this.onXpChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 20),

      child: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            const Row(
              children: [
                Icon(Icons.workspace_premium, color: Colors.amber),

                SizedBox(width: 8),

                Text(
                  "Pontuação",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue: pontos.toString(),

                    keyboardType: TextInputType.number,

                    decoration: const InputDecoration(
                      labelText: "Pontos",

                      prefixIcon: Icon(Icons.star),

                      border: OutlineInputBorder(),
                    ),

                    onChanged: (valor) {
                      onPontosChanged(int.tryParse(valor) ?? 0);
                    },
                  ),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: TextFormField(
                    initialValue: xp.toString(),

                    keyboardType: TextInputType.number,

                    decoration: const InputDecoration(
                      labelText: "XP",

                      prefixIcon: Icon(Icons.bolt),

                      border: OutlineInputBorder(),
                    ),

                    onChanged: (valor) {
                      onXpChanged(int.tryParse(valor) ?? 0);
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Container(
              width: double.infinity,

              padding: const EdgeInsets.all(12),

              decoration: BoxDecoration(
                color: Colors.amber.shade50,

                borderRadius: BorderRadius.circular(10),
              ),

              child: Column(
                children: [
                  const Text(
                    "Pré-visualização",

                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                    children: [
                      Chip(
                        avatar: const Icon(Icons.star),

                        label: Text("$pontos pontos"),
                      ),

                      Chip(
                        avatar: const Icon(Icons.bolt),

                        label: Text("$xp XP"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
