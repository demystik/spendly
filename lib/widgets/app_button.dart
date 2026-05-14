import 'package:flutter/material.dart';
import 'package:spendly/themes/app_spacing.dart';


class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.variant = AppButtonVariant.primary,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final AppButtonVariant variant;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return SizedBox(
      height: 52,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: variant == AppButtonVariant.outlined ? Colors.grey.shade50 : colors.primary,
          
          shape: RoundedRectangleBorder(
            side: variant == AppButtonVariant.outlined ? BorderSide(width: 1, color: Theme.of(context).colorScheme.surfaceContainerHighest) : BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : Text(
                label,
                style: text.titleMedium?.copyWith(
                  color: variant == AppButtonVariant.outlined ? Colors.black54 : colors.onPrimary),
              ),
      ),
    );
  }
}

enum AppButtonVariant { primary, outlined, ghost }
