import 'package:flutter/material.dart';

import '../../core/widgets/administracao/admin/admin_page_scaffold.dart';
import '../../core/widgets/administracao/admin/primary_save_button.dart';
import '../../models/recompensa.dart';
import '../../repositories/recompensa_repository.dart';

import 'widgets/recompensa_informacoes_card.dart';
import 'widgets/recompensa_pontuacao_card.dart';
import 'widgets/recompensa_configuracoes_card.dart';
import '../../core/theme/app_spacing.dart';

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

  bool _ativa = true;
  bool _salvando = false;

  String _tipo = "INDIVIDUAL";

  @override
  void initState() {
    super.initState();

    if (widget.recompensa != null) {

      final r = widget.recompensa!;

      _nomeController.text = r.nome;
      _descricaoController.text = r.descricao ?? "";
      _pontosController.text = r.pontos.toString();

      _tipo = r.tipo;
      _ativa = r.ativa;
    }
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _descricaoController.dispose();
    _pontosController.dispose();
    super.dispose();
  }

  Future<void> salvar() async {

    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _salvando = true;
    });

    try {

      final recompensa = Recompensa(

        id: widget.recompensa?.id,

        nome: _nomeController.text.trim(),

        descricao: _descricaoController.text.trim(),

        pontos: int.parse(_pontosController.text),

        tipo: _tipo,

        ativa: _ativa,

        ordem: widget.recompensa?.ordem ?? 0,

      );

      if (widget.recompensa == null) {

        await _repository.inserir(recompensa);

      } else {

        await _repository.atualizar(recompensa);

      }

      if (!mounted) return;

      Navigator.pop(context, true);

    } catch (e) {

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(

        SnackBar(

          content: Text(
            "Erro ao salvar recompensa.\n$e",
          ),

        ),

      );

    } finally {

      if (mounted) {

        setState(() {

          _salvando = false;

        });

      }

    }

  }

  @override
  Widget build(BuildContext context) {

    return AdminPageScaffold(

      title: widget.recompensa == null
          ? "Nova Recompensa"
          : "Editar Recompensa",

      child: Form(

        key: _formKey,

        child: ListView(

          padding: const EdgeInsets.all(AppSpacing.md),

          children: [

            RecompensaInformacoesCard(

              nomeController: _nomeController,

              descricaoController: _descricaoController,

            ),

            RecompensaPontuacaoCard(

              pontosController: _pontosController,

              tipo: _tipo,

              onTipoChanged: (valor) {

                if (valor == null) return;

                setState(() {

                  _tipo = valor;

                });

              },

            ),

            RecompensaConfiguracoesCard(

              ativa: _ativa,

              onChanged: (valor) {

                setState(() {

                  _ativa = valor;

                });

              },

            ),

            const SizedBox(height: 24),

            Padding(
                    padding: const EdgeInsets.only(
                      top: AppSpacing.lg,
                      bottom: AppSpacing.lg,
                    ),
                    child: PrimarySaveButton(
                      loading: _salvando,
                      onPressed: salvar,
                    ),
                  ),

          ],

        ),

      ),

    );

  }

}