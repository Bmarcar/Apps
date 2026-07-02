import 'package:flutter/material.dart';

class RecompensaPontuacaoCard extends StatelessWidget {
  final TextEditingController pontosController;
  final String tipo;
  final ValueChanged<String?> onTipoChanged;

  const RecompensaPontuacaoCard({
    super.key,
    required this.pontosController,
    required this.tipo,
    required this.onTipoChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Row(
              children: [
                Icon(
                  Icons.stars,
                  color: Colors.amber,
                ),
                SizedBox(width: 8),
                Text(
                  "Pontuação",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 4),

            const Text(
              "Defina a quantidade de pontos necessária para resgatar esta recompensa.",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: pontosController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Pontos",
                prefixIcon: Icon(Icons.stars),
                border: OutlineInputBorder(),
              ),
              validator: (v) {
                if (v == null || v.isEmpty) {
                  return "Informe os pontos";
                }

                if (int.tryParse(v) == null) {
                  return "Valor inválido";
                }

                return null;
              },
            ),

            const SizedBox(height: 16),

            DropdownButtonFormField<String>(
              value: tipo,
              decoration: const InputDecoration(
                labelText: "Tipo",
                prefixIcon: Icon(Icons.people),
                border: OutlineInputBorder(),
              ),
              items: const [

                DropdownMenuItem(
                  value: "INDIVIDUAL",
                  child: Text("Individual"),
                ),

                DropdownMenuItem(
                  value: "FAMILIAR",
                  child: Text("Familiar"),
                ),

              ],
              onChanged: onTipoChanged,
            ),
          ],
        ),
      ),
    );
  }
}