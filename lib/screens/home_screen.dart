import 'package:flutter/material.dart';
import 'package:spendly/themes/app_spacing.dart';
import 'package:spendly/themes/app_text_styles.dart';
import 'package:spendly/widgets/app_card.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderPart(),
            Divider(height: 1),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Hello, Alex!", style: AppTextStyles.displayMedium),
                    Text(
                      "Here is your financail summary for March",
                      style: AppTextStyles.bodyMedium,
                    ),
                    SizedBox(height: AppSpacing.md),
                    BalanceCard(),

                    SizedBox(height: AppSpacing.md),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Quick Insights",
                          style: AppTextStyles.titleMedium,
                        ),
                        Text(
                          "view all",
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: AppSpacing.md),

                    AppCard(
                      child: Column(
                        spacing: AppSpacing.sm,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.brown.shade100,
                            ),
                            child: SvgPicture.asset("assets/icons/arrow-trend-down-solid-full.svg"),
                          ),
                          Text("EXPENSES", style: AppTextStyles.bodyMedium),
                          Text("\$43.30", style: AppTextStyles.titleLarge),
                          Text("+12% from last month", style: AppTextStyles.labelMedium),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BalanceCard extends StatelessWidget {
  const BalanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      color: const Color.fromARGB(255, 244, 244, 255),
      child: Column(
        spacing: AppSpacing.sm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "MONTHLY BUDGET",
            style: AppTextStyles.titleMedium.copyWith(letterSpacing: 1.4),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text("\$2,000.00", style: AppTextStyles.displayLarge),
          LinearProgressIndicator(
            value: 0.7,
            minHeight: 7,
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("\$1,300.00 Spent", style: AppTextStyles.bodyMedium),
              Text("\$700.00 Spent", style: AppTextStyles.bodyMedium),
            ],
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
            child: Row(
              spacing: AppSpacing.xxl,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("DAILY AVERAGE", style: AppTextStyles.labelMedium),
                    Text("\$43.30", style: AppTextStyles.titleLarge),
                  ],
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("DAYS LEFT", style: AppTextStyles.labelMedium),
                    Text("14 DAYS", style: AppTextStyles.titleLarge),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HeaderPart extends StatelessWidget {
  const HeaderPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppSpacing.sm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            "assets/logos/spendly_logo2.png",
            width: 70,
            height: 70,
            fit: BoxFit.contain,
          ),

          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.notifications_none_rounded, size: 26),
              ),
              SizedBox(width: 10),
              CircleAvatar(
                radius: 15,
                foregroundImage: AssetImage("assets/images/profile_male.png"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
