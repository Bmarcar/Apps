import 'package:flutter/material.dart';

import '../../../theme/app_spacing.dart';

class AdminSectionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget child;

  const AdminSectionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.child,
    this.subtitle,
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

          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            Row(

              children: [

                Icon(icon),

                const SizedBox(width: 8),

                Expanded(

                  child: Text(

                    title,

                    style: const TextStyle(

                      fontSize: 18,

                      fontWeight:
                          FontWeight.bold,

                    ),

                  ),

                ),

              ],

            ),

            if (subtitle != null) ...[

              const SizedBox(height: 4),

              Text(

                subtitle!,

                style: TextStyle(

                  color: Colors.grey.shade700,

                ),

              ),

            ],

            const SizedBox(height: AppSpacing.md),

            child,

          ],

        ),

      ),

    );

  }

}