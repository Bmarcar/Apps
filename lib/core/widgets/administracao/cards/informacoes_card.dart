import 'package:flutter/material.dart';

import '../../../../models/categoria.dart';
import '../../../../models/dificuldade.dart';

class InformacoesCard extends StatelessWidget {
  final TextEditingController nomeController;
  final TextEditingController descricaoController;

  final List<Categoria> categorias;
  final Categoria? categoriaSelecionada;

  final List<Dificuldade> dificuldades;
  final Dificuldade? dificuldadeSelecionada;

  final String frequenciaSelecionada;

  final ValueChanged<Categoria?> onCategoriaChanged;
  final ValueChanged<Dificuldade?> onDificuldadeChanged;
  final ValueChanged<String?> onFrequenciaChanged;

  const InformacoesCard({
    super.key,
    required this.nomeController,
    required this.descricaoController,
    required this.categorias,
    required this.categoriaSelecionada,
    required this.dificuldades,
    required this.dificuldadeSelecionada,
    required this.frequenciaSelecionada,
    required this.onCategoriaChanged,
    required this.onDificuldadeChanged,
    required this.onFrequenciaChanged,
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
                Icon(Icons.description, color: Colors.blue),
                SizedBox(width: 8),
                Text(
                  "Informações Gerais",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ],
            ),

            const SizedBox(height: 20),

            TextFormField(
              controller: nomeController,
              decoration: const InputDecoration(
                labelText: "Nome da tarefa",
                prefixIcon: Icon(Icons.task_alt),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Informe o nome da tarefa";
                }
                return null;
              },
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: descricaoController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: "Descrição",
                prefixIcon: Icon(Icons.notes),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            DropdownButtonFormField<Categoria>(
              value: categoriaSelecionada,
              decoration: const InputDecoration(
                labelText: "Categoria",
                prefixIcon: Icon(Icons.category),
                border: OutlineInputBorder(),
              ),
              items: categorias
                  .map((c) => DropdownMenuItem(value: c, child: Text(c.nome)))
                  .toList(),
              onChanged: onCategoriaChanged,
            ),

            const SizedBox(height: 16),

            DropdownButtonFormField<Dificuldade>(
              value: dificuldadeSelecionada,
              decoration: const InputDecoration(
                labelText: "Dificuldade",
                prefixIcon: Icon(Icons.star),
                border: OutlineInputBorder(),
              ),
              items: dificuldades
                  .map((d) => DropdownMenuItem(value: d, child: Text(d.nome)))
                  .toList(),
              onChanged: onDificuldadeChanged,
            ),

            const SizedBox(height: 16),

            DropdownButtonFormField<String>(
              value: frequenciaSelecionada,
              decoration: const InputDecoration(
                labelText: "Frequência",
                prefixIcon: Icon(Icons.repeat),
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: "DIARIA", child: Text("☀ Diária")),

                DropdownMenuItem(value: "SEMANAL", child: Text("📅 Semanal")),

                DropdownMenuItem(value: "MENSAL", child: Text("🗓 Mensal")),

                DropdownMenuItem(value: "ANUAL", child: Text("🎉 Anual")),
              ],
              onChanged: onFrequenciaChanged,
            ),
          ],
        ),
      ),
    );
  }
}
