import 'package:flutter/material.dart';

class AgendaCard extends StatelessWidget {
  final List<int> diasSelecionados;

  final ValueChanged<List<int>> onChanged;

  const AgendaCard({
    super.key,
    required this.diasSelecionados,
    required this.onChanged,
  });

  static const dias = [
    {"id": 1, "nome": "Seg"},
    {"id": 2, "nome": "Ter"},
    {"id": 3, "nome": "Qua"},
    {"id": 4, "nome": "Qui"},
    {"id": 5, "nome": "Sex"},
    {"id": 6, "nome": "Sáb"},
    {"id": 7, "nome": "Dom"},
  ];

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
                Icon(Icons.calendar_month, color: Colors.deepOrange),

                SizedBox(width: 8),

                Text(
                  "Agenda",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),

            const SizedBox(height: 20),

            const Text(
              "Dias da semana",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            Wrap(
              spacing: 8,
              runSpacing: 8,

              children: dias.map((dia) {
                final selecionado = diasSelecionados.contains(dia["id"]);

                return FilterChip(
                  label: Text(dia["nome"] as String),

                  selected: selecionado,

                  avatar: const Icon(Icons.event, size: 18),

                  onSelected: (value) {
                    final lista = List<int>.from(diasSelecionados);

                    if (value) {
                      lista.add(dia["id"] as int);
                    } else {
                      lista.remove(dia["id"]);
                    }

                    onChanged(lista);
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 16),

            Text(
              "${diasSelecionados.length} dia(s) selecionado(s)",
              style: TextStyle(color: Colors.grey.shade700),
            ),
          ],
        ),
      ),
    );
  }
}
