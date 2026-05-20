// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:spendly/themes/app_text_styles.dart';

class MiddleSectionHeader extends StatelessWidget {
  final String leftText;
  final  String rightText;
  final  VoidCallback? onTap;
  const MiddleSectionHeader({
    super.key, 
    required this.leftText,
    required this.rightText,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(leftText, style: AppTextStyles.titleMedium),
        GestureDetector(
          onTap: onTap,
          child: Text(
            rightText,
            style: AppTextStyles.bodyMedium.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}
