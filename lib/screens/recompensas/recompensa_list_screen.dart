import 'package:flutter/material.dart';

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

  List<Recompensa> _lista = [];
  List<Recompensa> _filtrada = [];

  bool _loading = true;

  final _pesquisaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    carregar();
  }

  Future<void> carregar() async {
    setState(() => _loading = true);

    final dados = await _repository.listar();

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

        title: const Text("Excluir"),

        content: Text(
          "Deseja excluir '${recompensa.nome}'?"
        ),

        actions: [

          TextButton(

            onPressed: () =>
                Navigator.pop(context, false),

            child: const Text("Cancelar"),

          ),

          ElevatedButton(

            onPressed: () =>
                Navigator.pop(context, true),

            child: const Text("Excluir"),

          )

        ],

      ),

    );

    if (ok != true) return;

    await _repository.excluir(recompensa.id!);

    carregar();

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Recompensas"),
      ),

      floatingActionButton: FloatingActionButton(

        child: const Icon(Icons.add),

        onPressed: () async {

          await Navigator.push(

            context,

            MaterialPageRoute(

              builder: (_) =>
                  const RecompensaFormScreen(),

            ),

          );

          carregar();

        },

      ),

      body: Column(

        children: [

          Padding(

            padding: const EdgeInsets.all(16),

            child: TextField(

              controller: _pesquisaController,

              decoration: const InputDecoration(

                hintText: "Pesquisar",

                prefixIcon: Icon(Icons.search),

              ),

              onChanged: pesquisar,

            ),

          ),

          Expanded(

            child: _loading

                ? const Center(
                    child: CircularProgressIndicator(),
                  )

                : ListView.builder(

                    itemCount: _filtrada.length,

                    itemBuilder: (_, index) {

                      final recompensa =
                          _filtrada[index];

                      return Card(

                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),

                        child: ListTile(

                          leading: const CircleAvatar(

                            child: Icon(
                              Icons.card_giftcard,
                            ),

                          ),

                          title: Text(
                            recompensa.nome,
                          ),

                          subtitle: Text(

                            "${recompensa.pontos} pontos",

                          ),

                          trailing: Row(

                            mainAxisSize: MainAxisSize.min,

                            children: [

                              IconButton(

                                icon: const Icon(
                                  Icons.edit,
                                ),

                                onPressed: () async {

                                  await Navigator.push(

                                    context,

                                    MaterialPageRoute(

                                      builder: (_) =>
                                          RecompensaFormScreen(
                                              recompensa:
                                                  recompensa),

                                    ),

                                  );

                                  carregar();

                                },

                              ),

                              IconButton(

                                icon: const Icon(
                                  Icons.delete,
                                ),

                                onPressed: () =>
                                    excluir(recompensa),

                              )

                            ],

                          ),

                        ),

                      );

                    },

                  ),

          )

        ],

      ),

    );

  }

}