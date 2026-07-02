import 'package:flutter/material.dart';
import '../../../../core/theme/app_radius.dart';

class PrimarySaveButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool loading;
  final String text;
  final IconData icon;

  const PrimarySaveButton({
    super.key,
    required this.onPressed,
    this.loading = false,
    this.text = "Salvar",
    this.icon = Icons.save,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: FilledButton.icon(
        onPressed: loading ? null : onPressed,
        icon: loading
            ? const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              )
            : Icon(icon),
        label: Text(
          loading ? "Salvando..." : text,
        ),
        style: FilledButton.styleFrom(
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
          ),
        ),
      ),
    );
  }
}