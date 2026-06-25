import 'package:flutter/material.dart';

class ConfiguracoesCard extends StatelessWidget {
  final bool ativa;
  final bool necessitaAprovacao;

  final ValueChanged<bool> onAtivaChanged;
  final ValueChanged<bool> onNecessitaAprovacaoChanged;

  const ConfiguracoesCard({
    super.key,
    required this.ativa,
    required this.necessitaAprovacao,
    required this.onAtivaChanged,
    required this.onNecessitaAprovacaoChanged,
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
                Icon(Icons.settings, color: Colors.blueGrey),

                SizedBox(width: 8),

                Text(
                  "Configurações",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),

            const SizedBox(height: 20),

            SwitchListTile(
              value: ativa,

              title: const Text("Tarefa ativa"),

              subtitle: const Text(
                "A tarefa ficará disponível para os membros da família.",
              ),

              secondary: const Icon(Icons.check_circle, color: Colors.green),

              onChanged: onAtivaChanged,
            ),

            const Divider(),

            SwitchListTile(
              value: necessitaAprovacao,

              title: const Text("Necessita aprovação"),

              subtitle: const Text(
                "Após a conclusão, um responsável deverá aprovar a tarefa.",
              ),

              secondary: const Icon(Icons.approval, color: Colors.orange),

              onChanged: onNecessitaAprovacaoChanged,
            ),
          ],
        ),
      ),
    );
  }
}
