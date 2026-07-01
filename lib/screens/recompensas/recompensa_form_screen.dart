import 'package:flutter/material.dart';

import '../../models/recompensa.dart';
import '../../repositories/recompensa_repository.dart';

class RecompensaFormScreen extends StatefulWidget {
  final Recompensa? recompensa;

  const RecompensaFormScreen({
    super.key,
    this.recompensa,
  });

  @override
  State<RecompensaFormScreen> createState() =>
      _RecompensaFormScreenState();
}

class _RecompensaFormScreenState
    extends State<RecompensaFormScreen> {

  final _formKey = GlobalKey<FormState>();

  final _repository = RecompensaRepository();

  final _nomeController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _pontosController = TextEditingController();
  final _ordemController = TextEditingController();

  bool _ativa = true;

  String _tipo = "INDIVIDUAL";

  bool _salvando = false;

  @override
  void initState() {
    super.initState();

    if (widget.recompensa != null) {

      final r = widget.recompensa!;

      _nomeController.text = r.nome;
      _descricaoController.text = r.descricao ?? "";
      _pontosController.text = r.pontos.toString();
      _ordemController.text = r.ordem.toString();

      _tipo = r.tipo;
      _ativa = r.ativa;
    }
  }

  Future<void> salvar() async {

    if (!_formKey.currentState!.validate()) return;

    setState(() => _salvando = true);

    final recompensa = Recompensa(

      id: widget.recompensa?.id,

      nome: _nomeController.text,

      descricao: _descricaoController.text,

      pontos: int.parse(_pontosController.text),

      tipo: _tipo,

      ativa: _ativa,

      ordem: int.tryParse(
            _ordemController.text,
          ) ??
          0,

    );

    if (widget.recompensa == null) {

      await _repository.inserir(recompensa);

    } else {

      await _repository.atualizar(recompensa);

    }

    if (!mounted) return;

    Navigator.pop(context);

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: Text(

          widget.recompensa == null
              ? "Nova Recompensa"
              : "Editar Recompensa",

        ),

      ),

      body: Form(

        key: _formKey,

        child: ListView(

          padding: const EdgeInsets.all(16),

          children: [

            TextFormField(

              controller: _nomeController,

              decoration: const InputDecoration(

                labelText: "Nome",

              ),

              validator: (v) {

                if (v == null || v.isEmpty) {

                  return "Informe o nome";

                }

                return null;

              },

            ),

            const SizedBox(height: 16),

            TextFormField(

              controller: _descricaoController,

              maxLines: 3,

              decoration: const InputDecoration(

                labelText: "Descrição",

              ),

            ),

            const SizedBox(height: 16),

            TextFormField(

              controller: _pontosController,

              keyboardType: TextInputType.number,

              decoration: const InputDecoration(

                labelText: "Pontos",

              ),

              validator: (v) {

                if (v == null || v.isEmpty) {

                  return "Informe os pontos";

                }

                return null;

              },

            ),

            const SizedBox(height: 16),

            DropdownButtonFormField<String>(

              value: _tipo,

              decoration: const InputDecoration(

                labelText: "Tipo",

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

              onChanged: (v) {

                setState(() {

                  _tipo = v!;

                });

              },

            ),

            const SizedBox(height: 16),

            TextFormField(

              controller: _ordemController,

              keyboardType: TextInputType.number,

              decoration: const InputDecoration(

                labelText: "Ordem",

              ),

            ),

            const SizedBox(height: 16),

            SwitchListTile(

              title: const Text("Recompensa ativa"),

              value: _ativa,

              onChanged: (v) {

                setState(() {

                  _ativa = v;

                });

              },

            ),

            const SizedBox(height: 30),

            FilledButton.icon(

              onPressed: _salvando ? null : salvar,

              icon: const Icon(Icons.save),

              label: Text(

                _salvando

                    ? "Salvando..."

                    : "Salvar",

              ),

            )

          ],

        ),

      ),

    );

  }

}