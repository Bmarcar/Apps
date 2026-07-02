import 'package:flutter/material.dart';

import '../../../../models/perfil.dart';
import '../../../../models/usuario.dart';

class DestinatarioCard extends StatelessWidget {
  final int tipoDestinatario;

  final List<Perfil> perfis;
  final Perfil? perfilSelecionado;

  final List<Usuario> usuarios;
  final Usuario? usuarioSelecionado;

  final ValueChanged<int?> onTipoChanged;
  final ValueChanged<Perfil?> onPerfilChanged;
  final ValueChanged<Usuario?> onUsuarioChanged;

  const DestinatarioCard({
    super.key,
    required this.tipoDestinatario,
    required this.perfis,
    required this.perfilSelecionado,
    required this.usuarios,
    required this.usuarioSelecionado,
    required this.onTipoChanged,
    required this.onPerfilChanged,
    required this.onUsuarioChanged,
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
                Icon(Icons.people, color: Colors.green),

                SizedBox(width: 8),

                Text(
                  "Destinatário",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),

            const SizedBox(height: 20),

            RadioListTile<int>(
              title: const Text("Toda a Família"),
              value: 1,
              groupValue: tipoDestinatario,
              onChanged: onTipoChanged,
            ),

            RadioListTile<int>(
              title: const Text("Perfil"),
              value: 2,
              groupValue: tipoDestinatario,
              onChanged: onTipoChanged,
            ),

            if (tipoDestinatario == 2)
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),

                child: DropdownButtonFormField<Perfil>(
                  value: perfilSelecionado,

                  decoration: const InputDecoration(
                    labelText: "Perfil",

                    prefixIcon: Icon(Icons.groups),

                    border: OutlineInputBorder(),
                  ),

                  items: perfis
                      .map(
                        (perfil) => DropdownMenuItem(
                          value: perfil,

                          child: Text(perfil.nome),
                        ),
                      )
                      .toList(),

                  onChanged: onPerfilChanged,
                ),
              ),

            RadioListTile<int>(
              title: const Text("Usuário"),
              value: 3,
              groupValue: tipoDestinatario,
              onChanged: onTipoChanged,
            ),

            if (tipoDestinatario == 3)
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),

                child: DropdownButtonFormField<Usuario>(
                  value: usuarioSelecionado,

                  decoration: const InputDecoration(
                    labelText: "Usuário",

                    prefixIcon: Icon(Icons.person),

                    border: OutlineInputBorder(),
                  ),

                  items: usuarios
                      .map(
                        (usuario) => DropdownMenuItem(
                          value: usuario,

                          child: Text(usuario.nome),
                        ),
                      )
                      .toList(),

                  onChanged: onUsuarioChanged,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
