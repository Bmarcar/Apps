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
    categorias = await _categoriaService.listar();

    dificuldades = await _dificuldadeService.listar();

    perfis = await _perfilService.listar();

    usuarios = await _usuarioService.listar();

    if (widget.tarefa != null) {
      final tarefa = widget.tarefa!;

      _nomeController.text = tarefa.nome;

      _descricaoController.text = tarefa.descricao ?? '';

      frequencia = tarefa.frequencia;

      pontos = tarefa.pontos;

      xp = tarefa.xp;

      ativa = tarefa.ativa;

      necessitaAprovacao = tarefa.necessitaAprovacao;

      categoriaSelecionada = categorias.firstWhere(
        (e) => e.id == tarefa.categoriaId,
      );

      dificuldadeSelecionada = dificuldades.firstWhere(
        (e) => e.id == tarefa.dificuldadeId,
      );

      tipoDestinatario = int.tryParse(tarefa.destinatarioTipo) ?? 1;

      if (tarefa.perfilDestinoId != null) {
        perfilSelecionado = perfis.firstWhere(
          (e) => e.id == tarefa.perfilDestinoId,
        );
      }

      if (tarefa.usuarioDestinoId != null) {
        usuarioSelecionado = usuarios.firstWhere(
          (e) => e.id == tarefa.destinatarioTipo,
        );
      }

      diasSemana = List.from(tarefa.diasSemana);
    }

    setState(() {
      carregando = false;
    });
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

              onPerfilChanged: (Perfil? perfil) {
                setState(() {
                  perfilSelecionado = perfil;
                });
              },

              onUsuarioChanged: (Usuario? usuario) {
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

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Salvar será implementado na próxima etapa.'),
      ),
    );
  }
}
