import 'package:flutter/material.dart';

import '../../core/widgets/administracao/admin/admin_page_scaffold.dart';
import '../../core/widgets/administracao/fields/admin_search_field.dart';
import '../../models/recompensa.dart';
import '../../repositories/recompensa_repository.dart';
import 'recompensa_form_screen.dart';

class RecompensaListScreen extends StatefulWidget {
  const RecompensaListScreen({super.key});

  @override
  State<RecompensaListScreen> createState() =>
      _RecompensaListScreenState();
}

class _RecompensaListScreenState
    extends State<RecompensaListScreen> {

  final _repository = RecompensaRepository();

  final _pesquisaController = TextEditingController();

  List<Recompensa> _lista = [];
  List<Recompensa> _filtrada = [];

  bool _loading = true;

  @override
  void initState() {
    super.initState();
    carregar();
  }

  @override
  void dispose() {
    _pesquisaController.dispose();
    super.dispose();
  }

  Future<void> carregar() async {

    setState(() {
      _loading = true;
    });

    final dados = await _repository.listar();

    if (!mounted) return;

    setState(() {
      _lista = dados;
      _filtrada = dados;
      _loading = false;
    });
  }

  void pesquisar(String texto) {

    texto = texto.toLowerCase();

    setState(() {

      _filtrada = _lista.where((r) {

        return r.nome.toLowerCase().contains(texto);

      }).toList();

    });

  }

  Future<void> excluir(Recompensa recompensa) async {

    final ok = await showDialog<bool>(

      context: context,

      builder: (_) => AlertDialog(

        title: const Text("Excluir recompensa"),

        content: Text(
          "Deseja realmente excluir '${recompensa.nome}'?",
        ),

        actions: [

          TextButton(

            onPressed: () =>
                Navigator.pop(context, false),

            child: const Text("Cancelar"),

          ),

          FilledButton(

            onPressed: () =>
                Navigator.pop(context, true),

            child: const Text("Excluir"),

          ),

        ],

      ),

    );

    if (ok != true) return;

    await _repository.excluir(recompensa.id!);

    await carregar();

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(

      const SnackBar(

        content: Text(
          "Recompensa excluída com sucesso!",
        ),

      ),

    );

  }

  Future<void> abrirFormulario({
    Recompensa? recompensa,
  }) async {

    final alterou = await Navigator.push<bool>(

      context,

      MaterialPageRoute(

        builder: (_) => RecompensaFormScreen(
          recompensa: recompensa,
        ),

      ),

    );

    if (alterou == true) {

      await carregar();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(

        SnackBar(

          content: Text(

            recompensa == null
                ? "Recompensa cadastrada com sucesso!"
                : "Recompensa atualizada com sucesso!",

          ),

        ),

      );

    }

  }

  @override
  Widget build(BuildContext context) {

    return AdminPageScaffold(

      title: "Recompensas",

      floatingActionButton: FloatingActionButton(

        onPressed: () => abrirFormulario(),

        child: const Icon(Icons.add),

      ),

      child: Column(

        children: [

          AdminSearchField(

            controller: _pesquisaController,

            hint: "Pesquisar recompensa...",

            onChanged: pesquisar,

          ),

          Expanded(

            child: _loading

                ? const Center(
                    child: CircularProgressIndicator(),
                  )

                : _filtrada.isEmpty

                    ? const Center(

                        child: Text(
                          "Nenhuma recompensa encontrada.",
                        ),

                      )

                    : ListView.builder(

                        itemCount: _filtrada.length,

                        itemBuilder: (_, index) {

                          final recompensa = _filtrada[index];

                          return Card(

                            margin: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 6,
                            ),

                            elevation: 2,

                            child: ListTile(

                              contentPadding:
                                  const EdgeInsets.all(12),

                              leading: CircleAvatar(

                                radius: 26,

                                child: const Icon(
                                  Icons.card_giftcard,
                                ),

                              ),

                              title: Text(

                                recompensa.nome,

                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),

                              ),

                              subtitle: Column(

                                crossAxisAlignment:
                                    CrossAxisAlignment.start,

                                children: [

                                  if ((recompensa.descricao ?? "")
                                      .isNotEmpty)

                                    Padding(

                                      padding:
                                          const EdgeInsets.only(
                                              top: 4),

                                      child: Text(
                                        recompensa.descricao!,
                                      ),

                                    ),

                                  const SizedBox(height: 6),

                                  Row(

                                    children: [

                                      const Icon(
                                        Icons.stars,
                                        size: 16,
                                        color: Colors.amber,
                                      ),

                                      const SizedBox(width: 4),

                                      Text(
                                        "${recompensa.pontos} pontos",
                                      ),

                                    ],

                                  ),

                                  const SizedBox(height: 4),

                                  Text(

                                    recompensa.tipo ==
                                            "FAMILIAR"
                                        ? "👨‍👩‍👧 Familiar"
                                        : "👤 Individual",

                                  ),

                                ],

                              ),

                              trailing: Column(

                                mainAxisAlignment:
                                    MainAxisAlignment.center,

                                children: [

                                  IconButton(
                                              visualDensity: VisualDensity.compact,
                                              constraints: const BoxConstraints(
                                              minWidth: 36,
                                              minHeight: 36,
                                            ),
                                    icon: const Icon(
                                      Icons.edit,
                                    ),

                                    tooltip: "Editar",

                                    onPressed: () {

                                      abrirFormulario(
                                        recompensa: recompensa,
                                      );

                                    },

                                  ),

                                  IconButton(
                                              visualDensity: VisualDensity.compact,
                                              constraints: const BoxConstraints(
                                              minWidth: 36,
                                              minHeight: 36,
                                            ),

                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),

                                    tooltip: "Excluir",

                                    onPressed: () {

                                      excluir(recompensa);

                                    },

                                  ),

                                ],

                              ),

                            ),

                          );

                        },

                      ),

          ),

        ],

      ),

    );

  }

}