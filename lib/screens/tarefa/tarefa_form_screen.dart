import 'package:flutter/material.dart';

import '../../models/categoria.dart';
import '../../models/dificuldade.dart';
import '../../models/perfil.dart';
import '../../models/usuario.dart';
import '../../models/tarefa_admin.dart';

import '../../services/categoria_service.dart';
import '../../services/dificuldade_service.dart';
import '../../services/perfil_service.dart';
import '../../services/usuario_service.dart';
import '../../services/tarefa_admin_service.dart';

import '../../widgets/administracao/cards/informacoes_card.dart';
import '../../widgets/administracao/cards/destinatario_card.dart';
import '../../widgets/administracao/cards/agenda_card.dart';
import '../../widgets/administracao/cards/pontuacao_card.dart';
import '../../widgets/administracao/cards/configuracoes_card.dart';

class TarefaFormScreen extends StatefulWidget {
  final TarefaAdmin? tarefa;

  const TarefaFormScreen({super.key, this.tarefa});

  @override
  State<TarefaFormScreen> createState() => _TarefaFormScreenState();
}

class _TarefaFormScreenState extends State<TarefaFormScreen> {
  final _formKey = GlobalKey<FormState>();

  //------------------------------------------------------
  // SERVICES
  //------------------------------------------------------

  final CategoriaService _categoriaService = CategoriaService();

  final DificuldadeService _dificuldadeService = DificuldadeService();

  final PerfilService _perfilService = PerfilService();

  final UsuarioService _usuarioService = UsuarioService();

  final TarefaAdminService _tarefaService = TarefaAdminService();

  //------------------------------------------------------
  // CONTROLLERS
  //------------------------------------------------------

  final _nomeController = TextEditingController();

  final _descricaoController = TextEditingController();

  //------------------------------------------------------
  // LISTAS
  //------------------------------------------------------

  List<Categoria> categorias = [];

  List<Dificuldade> dificuldades = [];

  List<Perfil> perfis = [];

  List<Usuario> usuarios = [];

  String formatarDiasSemana(List<int> dias) {
    const nomes = {
      1: "Seg",
      2: "Ter",
      3: "Qua",
      4: "Qui",
      5: "Sex",
      6: "Sáb",
      7: "Dom",
    };
      return dias.map((d) => nomes[d]!).join(" • ");
  }
  //------------------------------------------------------
  // SELEÇÕES
  //------------------------------------------------------

  Categoria? categoriaSelecionada;

  Dificuldade? dificuldadeSelecionada;

  Perfil? perfilSelecionado;

  Usuario? usuarioSelecionado;

  //------------------------------------------------------
  // CAMPOS
  //------------------------------------------------------

  String frequencia = "DIARIA";

  int tipoDestinatario = 1;

  List<int> diasSemana = [];

  int pontos = 10;

  int xp = 10;

  bool ativa = true;

  bool necessitaAprovacao = false;

  bool carregando = true;

  //------------------------------------------------------
  // INIT
  //------------------------------------------------------

  @override
  void initState() {
    super.initState();

    carregarDados();
  }

  //------------------------------------------------------
  // CARREGAR DADOS
  //------------------------------------------------------

 Future<void> carregarDados() async {
  try {
    print("========== INÍCIO ==========");

    categorias = await _categoriaService.listar();
    print("Categorias: ${categorias.length}");

    dificuldades = await _dificuldadeService.listar();
    print("Dificuldades: ${dificuldades.length}");

    perfis = await _perfilService.listar();
    print("Perfis: ${perfis.length}");

    usuarios = await _usuarioService.listar();
    print("Usuários: ${usuarios.length}");

    if (widget.tarefa != null) {
      final tarefa = widget.tarefa!;

      print("Nome: ${tarefa.nome}");
      print("CategoriaId: ${tarefa.categoriaId}");
      print("DificuldadeId: ${tarefa.dificuldadeId}");
      print("DestinatárioTipo: ${tarefa.destinatarioTipo}");
      print("PerfilDestinoId: ${tarefa.perfilDestinoId}");
      print("UsuarioDestinoId: ${tarefa.usuarioDestinoId}");

      _nomeController.text = tarefa.nome;
      print("Nome OK");

      _descricaoController.text = tarefa.descricao ?? '';
      print("Descrição OK");

      frequencia = tarefa.frequencia;
      pontos = tarefa.pontos;
      xp = tarefa.xp;
      ativa = tarefa.ativa;
      necessitaAprovacao = tarefa.necessitaAprovacao;

      print("Procurando categoria...");
      categoriaSelecionada =
          categorias.firstWhere((e) => e.id == tarefa.categoriaId);
      print("Categoria OK");

      print("Procurando dificuldade...");
      dificuldadeSelecionada =
          dificuldades.firstWhere((e) => e.id == tarefa.dificuldadeId);
      print("Dificuldade OK");

      tipoDestinatario = tarefa.tipoDestinatarioId;
      print("Tipo destinatário OK");

      if (tarefa.perfilDestinoId != null) {
        print("Procurando perfil...");
        perfilSelecionado =
            perfis.firstWhere((e) => e.id == tarefa.perfilDestinoId);
        print("Perfil OK");
      }

      if (tarefa.usuarioDestinoId != null) {
        print("Procurando usuário...");
        usuarioSelecionado =
            usuarios.firstWhere((e) => e.id == tarefa.usuarioDestinoId);
        print("Usuário OK");
      }

      print("Carregando dias da semana...");

      diasSemana = await _tarefaService.listarDiasSemana(tarefa.id!);

      print("Dias da semana: $diasSemana");
      
      print("Dias semana OK");
    }

    print("Finalizando...");

    setState(() {
      carregando = false;
    });

    print("========== FIM ==========");
  } catch (e, s) {
    print("========== ERRO ==========");
    print(e);
    print(s);
  }
}

  //------------------------------------------------------

  @override
  void dispose() {
    _nomeController.dispose();

    _descricaoController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (carregando) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.tarefa == null ? 'Nova Tarefa' : 'Editar Tarefa'),
      ),

      body: Form(
        key: _formKey,

        child: ListView(
          padding: const EdgeInsets.all(16),

          children: [
            //----------------------------------------
            // Informações Gerais
            //----------------------------------------
            InformacoesCard(
              nomeController: _nomeController,

              descricaoController: _descricaoController,

              categorias: categorias,

              categoriaSelecionada: categoriaSelecionada,

              dificuldades: dificuldades,

              dificuldadeSelecionada: dificuldadeSelecionada,

              frequenciaSelecionada: frequencia,

              onCategoriaChanged: (Categoria? categoria) {
                setState(() {
                  categoriaSelecionada = categoria;
                });
              },

              onDificuldadeChanged: (Dificuldade? dificuldade) {
                setState(() {
                  dificuldadeSelecionada = dificuldade;
                });
              },

              onFrequenciaChanged: (valor) {
                setState(() {
                  frequencia = valor ?? "DIARIA";
                });
              },
            ),

            //----------------------------------------
            // Destinatário
            //----------------------------------------
            DestinatarioCard(
              tipoDestinatario: tipoDestinatario,

              perfis: perfis,

              perfilSelecionado: perfilSelecionado,

              usuarios: usuarios,

              usuarioSelecionado: usuarioSelecionado,

              onTipoChanged: (tipo) {
                setState(() {
                  tipoDestinatario = tipo ?? 1;
                });
              },

              onPerfilChanged: (perfil) {
                setState(() {
                  perfilSelecionado = perfil;
                });
              },

              onUsuarioChanged: (usuario) {
                setState(() {
                  usuarioSelecionado = usuario;
                });
              },
            ),

            //----------------------------------------
            // Agenda
            //----------------------------------------
            if (frequencia == "SEMANAL")
              AgendaCard(
                diasSelecionados: diasSemana,

                onChanged: (dias) {
                  setState(() {
                    diasSemana = dias;
                  });
                },
              ),

            //----------------------------------------
            // Pontuação
            //----------------------------------------
            PontuacaoCard(
              pontos: pontos,

              xp: xp,

              onPontosChanged: (valor) {
                setState(() {
                  pontos = valor;
                });
              },

              onXpChanged: (valor) {
                setState(() {
                  xp = valor;
                });
              },
            ),

            //----------------------------------------
            // Configurações
            //----------------------------------------
            ConfiguracoesCard(
              ativa: ativa,

              necessitaAprovacao: necessitaAprovacao,

              onAtivaChanged: (valor) {
                setState(() {
                  ativa = valor;
                });
              },

              onNecessitaAprovacaoChanged: (valor) {
                setState(() {
                  necessitaAprovacao = valor;
                });
              },
            ),

            const SizedBox(height: 20),

            //=====================================================
            // PRÉ-VISUALIZAÇÃO
            //=====================================================
            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.visibility, color: Colors.deepPurple),

                        SizedBox(width: 8),

                        Text(
                          "Pré-visualização",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    Text(
                      _nomeController.text.isEmpty
                          ? "Nome da tarefa"
                          : _nomeController.text,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    if (_descricaoController.text.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(_descricaoController.text),
                      ),

                    const SizedBox(height: 15),

                    Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            if (categoriaSelecionada != null)
                              Chip(
                                avatar: const Icon(Icons.category),
                                label: Text(categoriaSelecionada!.nome),
                              ),

                            if (dificuldadeSelecionada != null)
                              Chip(
                                avatar: const Icon(Icons.star),
                                label: Text(dificuldadeSelecionada!.nome),
                              ),

                            Chip(
                              avatar: const Icon(Icons.repeat),
                              label: Text(frequencia),
                            ),

                            if (frequencia == "SEMANAL" && diasSemana.isNotEmpty)
                              Chip(
                                avatar: const Icon(Icons.calendar_today),
                                label: Text(formatarDiasSemana(diasSemana)),
                              ),
                          ],
                        ),

                    const SizedBox(height: 15),

                    Row(
                      children: [
                        Chip(
                          avatar: const Icon(Icons.workspace_premium),
                          label: Text("$pontos pts"),
                        ),

                        const SizedBox(width: 10),

                        Chip(
                          avatar: const Icon(Icons.bolt),
                          label: Text("$xp XP"),
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    Text(
                      tipoDestinatario == 1
                          ? "👨 Toda a família"
                          : tipoDestinatario == 2
                          ? "👦 ${perfilSelecionado?.nome ?? '-'}"
                          : "👤 ${usuarioSelecionado?.nome ?? '-'}",
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            //=====================================================
            // BOTÕES
            //=====================================================
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.close),

                    label: const Text("Cancelar"),

                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.save),

                    label: Text(widget.tarefa == null ? "Salvar" : "Atualizar"),

                    onPressed: _salvar,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Future<void> _salvar() async {
  if (!_formKey.currentState!.validate()) {
    return;
  }

  final dados = {
    "nome": _nomeController.text.trim(),
    "descricao": _descricaoController.text.trim(),

    "id_categoria": categoriaSelecionada?.id,

    "frequencia": frequencia,

    "dificuldade_id": dificuldadeSelecionada?.id,

    "pontos": pontos,
    "xp": xp,

    "tipo_destinatario_id": tipoDestinatario,

    "perfil_familia_id": perfilSelecionado?.id,

    "usuario_id": usuarioSelecionado?.id,

    "necessita_aprovacao": necessitaAprovacao,

    "ativa": ativa,
  };

  try {

    if (widget.tarefa == null) {

  final id = await _tarefaService.inserir(dados);

  await _tarefaService.salvarDiasSemana(
    id,
    diasSemana,
  );

} else {

  await _tarefaService.atualizar(
    widget.tarefa!.id!,
    dados,
  );

  await _tarefaService.salvarDiasSemana(
    widget.tarefa!.id!,
    diasSemana,
  );

}

    if (!mounted) return;

    Navigator.pop(context, true);

  } catch (e) {

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Erro ao salvar: $e"),
      ),
    );
  }
}
}
