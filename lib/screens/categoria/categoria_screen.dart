import 'package:flutter/material.dart';
import '../../models/categoria.dart';
import '../../services/categoria_service.dart';

class CategoriasScreen extends StatefulWidget {
  const CategoriasScreen({super.key});

  @override
  State<CategoriasScreen> createState() =>
      _CategoriasScreenState();
}

class _CategoriasScreenState
    extends State<CategoriasScreen> {

  final CategoriaService _service =
      CategoriaService();

  late Future<List<Categoria>> _future;

  @override
  void initState() {
    super.initState();
    carregarCategorias();
  }

  void carregarCategorias() {
    _future = _service.listar();
  }

  Future<void> abrirFormulario({
    Categoria? categoria,
  }) async {
    final controller = TextEditingController(
      text: categoria?.nome ?? '',
    );

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            categoria == null
                ? 'Nova Categoria'
                : 'Editar Categoria',
          ),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              labelText: 'Nome',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),

            ElevatedButton(
              onPressed: () async {
                if (controller.text.trim().isEmpty) {
                  return;
                }

                if (categoria == null) {
                  await _service.inserir(
                    controller.text.trim(),
                  );
                } else {
                  await _service.atualizar(
                    categoria.id,
                    controller.text.trim(),
                  );
                }

                if (mounted) {
                  Navigator.pop(context);

                  setState(() {
                    carregarCategorias();
                  });
                }
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  Future<void> excluirCategoria(
    Categoria categoria,
  ) async {
    final confirmar =
        await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text(
                'Excluir categoria',
              ),
              content: Text(
                'Deseja excluir "${categoria.nome}"?',
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(
                      context,
                      false,
                    );
                  },
                  child: const Text('Não'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(
                      context,
                      true,
                    );
                  },
                  child: const Text('Sim'),
                ),
              ],
            );
          },
        ) ??
        false;

    if (!confirmar) return;

    await _service.excluir(categoria.id);

    setState(() {
      carregarCategorias();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Categorias',
        ),
      ),

      floatingActionButton:
          FloatingActionButton(
            onPressed: () {
              abrirFormulario();
            },
            child: const Icon(Icons.add),
          ),

      body: FutureBuilder<List<Categoria>>(
        future: _future,
        builder: (context, snapshot) {

          if (!snapshot.hasData) {
            return const Center(
              child:
                  CircularProgressIndicator(),
            );
          }

          final categorias =
              snapshot.data!;

          if (categorias.isEmpty) {
            return const Center(
              child: Text(
                'Nenhuma categoria cadastrada',
              ),
            );
          }

          return ListView.builder(
            itemCount: categorias.length,
            itemBuilder: (context, index) {

              final categoria =
                  categorias[index];

              return Card(
                margin:
                    const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                child: ListTile(
                  leading: const Icon(
                    Icons.category,
                  ),

                  title: Text(
                    categoria.nome,
                  ),

                  trailing: Row(
                    mainAxisSize:
                        MainAxisSize.min,
                    children: [

                      IconButton(
                        icon: const Icon(
                          Icons.edit,
                        ),
                        onPressed: () {
                          abrirFormulario(
                            categoria:
                                categoria,
                          );
                        },
                      ),

                      IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          excluirCategoria(
                            categoria,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}