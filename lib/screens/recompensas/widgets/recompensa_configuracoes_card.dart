import 'package:flutter/material.dart';

import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_colors.dart';

class RecompensaConfiguracoesCard extends StatelessWidget {

  final bool ativa;
  final ValueChanged<bool> onChanged;

  const RecompensaConfiguracoesCard({
    super.key,
    required this.ativa,
    required this.onChanged,
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
                Icons.settings,
                color: AppColors.primary,
              ),

              SizedBox(width: 8),

              Text(
                "Configurações",
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
            "Controle a disponibilidade da recompensa.",
            style: TextStyle(
              color: AppColors.textSecondary,
            ),
          ),

          const SizedBox(
            height: AppSpacing.sm,
          ),

          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text(
              "Recompensa ativa",
            ),
            subtitle: const Text(
              "A recompensa poderá ser utilizada pelos usuários.",
            ),
            value: ativa,
            onChanged: onChanged,
          ),

        ],
      ),
    ),
  );
}

}