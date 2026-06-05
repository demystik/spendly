import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Privacy Policy")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Privacy Policy",
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              "Last updated: June 04, 2026",
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
            ),
            const SizedBox(height: 24),

            const Text(
              "This Privacy Policy describes Our policies and procedures on the collection, use and disclosure of Your information when You use the Service and tells You about Your privacy rights and how the law protects You.",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),

            const Text(
              "We use Your Personal Data to provide and improve the Service. By using the Service, You agree to the collection and use of information in accordance with this Privacy Policy.",
            ),
            const SizedBox(height: 24),

            _buildSectionTitle("Interpretation and Definitions"),
            _buildSubTitle("Interpretation"),
            const Text(
              "The words whose initial letters are capitalized have meanings defined under the following conditions. The following definitions shall have the same meaning regardless of whether they appear in singular or in plural.",
            ),
            const SizedBox(height: 16),

            _buildSubTitle("Definitions"),
            const Text("For the purposes of this Privacy Policy:"),
            const SizedBox(height: 12),

            _buildBulletPoint(
              "Account",
              "means a unique account created for You to access our Service or parts of our Service.",
            ),
            _buildBulletPoint(
              "Application",
              "refers to spendly, the software program provided by the Company.",
            ),
            _buildBulletPoint(
              "Company",
              "(referred to as either \"the Company\", \"We\", \"Us\" or \"Our\" in this Privacy Policy) refers to spendly.",
            ),
            _buildBulletPoint("Country", "refers to: Nigeria"),
            _buildBulletPoint(
              "Personal Data",
              "means any information that relates to an identified or identifiable individual.",
            ),
            _buildBulletPoint("Service", "refers to the Application."),
            _buildBulletPoint(
              "Service Provider",
              "means any natural or legal person who processes the data on behalf of the Company...",
            ),

            // You can continue adding the rest
            const SizedBox(height: 24),
            _buildSectionTitle("Collecting and Using Your Personal Data"),
            _buildSubTitle("Types of Data Collected"),
            _buildSubSubTitle("Personal Data"),
            const Text(
              "While using Our Service, We may ask You to provide Us with certain personally identifiable information that can be used to contact or identify You. Personally identifiable information may include, but is not limited to:",
            ),
            const Padding(
              padding: EdgeInsets.only(left: 16, top: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("• Email address"),
                  Text("• First name and last name"),
                ],
              ),
            ),

            const SizedBox(height: 30),
            _buildSectionTitle("Contact Us"),
            const Text(
              "If you have any questions about this Privacy Policy, You can contact us:",
            ),
            const Text("By email: demystiktech@gmail.com"),
          ],
        ),
      ),
    );
  }

  // Helper Widgets
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 8),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildSubTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 6),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildSubSubTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 6),
      child: Text(
        title,
        style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildBulletPoint(String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("•  ", style: TextStyle(fontSize: 18)),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 16, color: Colors.black87),
                children: [
                  TextSpan(
                    text: "$title ",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: description),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
