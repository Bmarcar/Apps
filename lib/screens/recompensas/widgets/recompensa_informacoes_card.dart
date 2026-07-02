import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';

class RecompensaInformacoesCard extends StatelessWidget {
  final TextEditingController nomeController;
  final TextEditingController descricaoController;

  const RecompensaInformacoesCard({
    super.key,
    required this.nomeController,
    required this.descricaoController,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(
        bottom: AppSpacing.md,
      ),
      child: Padding(
        padding: const EdgeInsets.all(
          AppSpacing.md,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Row(
              children: [

                Icon(
                  Icons.card_giftcard,
                  color: AppColors.primary,
                ),

                SizedBox(width: AppSpacing.sm),

                Text(
                  "Informações",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

              ],
            ),

            const SizedBox(
              height: AppSpacing.xs,
            ),

            const Text(
              "Informe os dados principais da recompensa.",
              style: TextStyle(
                color: AppColors.textSecondary,
              ),
            ),

            const SizedBox(
              height: AppSpacing.md,
            ),

            TextFormField(
              controller: nomeController,
              decoration: const InputDecoration(
                labelText: "Nome",
                prefixIcon: Icon(Icons.sell),
                border: OutlineInputBorder(),
              ),
              validator: (v) {

                if (v == null || v.trim().isEmpty) {
                  return "Informe o nome";
                }

                return null;
              },
            ),

            const SizedBox(
              height: AppSpacing.md,
            ),

            TextFormField(
              controller: descricaoController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: "Descrição",
                prefixIcon: Icon(Icons.description),
                border: OutlineInputBorder(),
              ),
            ),

          ],
        ),
      ),
    );
  }
}