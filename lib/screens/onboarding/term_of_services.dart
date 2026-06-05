import 'package:flutter/material.dart';

class TermsOfServices extends StatelessWidget {
  const TermsOfServices({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Terms and Conditions")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              "Terms and Conditions",
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              "Last updated: June 04, 2026",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
            const SizedBox(height: 24),

            const Text(
              "Please read these terms and conditions carefully before using Our Service.",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),

            _buildSectionTitle("Interpretation and Definitions"),
            _buildSubTitle("Interpretation"),
            const Text(
              "The words whose initial letters are capitalized have meanings defined under the following conditions. The following definitions shall have the same meaning regardless of whether they appear in singular or in plural.",
            ),
            const SizedBox(height: 16),

            _buildSubTitle("Definitions"),
            const Text("For the purposes of these Terms and Conditions:"),
            const SizedBox(height: 12),

            _buildBulletPoint("Application", "means the software program provided by the Company downloaded by You on any electronic device, named Spendly."),
            _buildBulletPoint("Application Store", "means the digital distribution service operated and developed by Apple Inc. (Apple App Store) or Google Inc. (Google Play Store) in which the Application has been downloaded."),
            _buildBulletPoint("Affiliate", "means an entity that controls, is controlled by, or is under common control with a party, where \"control\" means ownership of 50% or more of the shares, equity interest or other securities entitled to vote for election of directors or other managing authority."),
            _buildBulletPoint("Country", "refers to: Nigeria"),
            _buildBulletPoint("Company", " (referred to as either \"the Company\", \"We\", \"Us\" or \"Our\" in these Terms and Conditions) refers to Spendly."),
            _buildBulletPoint("Device", "means any device that can access the Service such as a computer, a cell phone or a digital tablet."),
            _buildBulletPoint("Service", "refers to the Application."),
            // Add more definitions as needed...

            const SizedBox(height: 24),
            _buildSectionTitle("Acknowledgment"),
            const Text(
              "These are the Terms and Conditions governing the use of this Service and the agreement between You and the Company. These Terms and Conditions set out the rights and obligations of all users regarding the use of the Service.",
            ),
            const SizedBox(height: 12),
            const Text(
              "Your access to and use of the Service is conditioned on Your acceptance of and compliance with these Terms and Conditions...",
            ),
            // Continue adding other sections similarly...

            const SizedBox(height: 30),
            _buildSectionTitle("Contact Us"),
            const Text("If you have any questions about these Terms and Conditions, You can contact us:"),
            const Text("By email: demystiktech@gmail.com"),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSubTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 6),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
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
                style: const TextStyle(fontSize: 16, color: Colors.black),
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