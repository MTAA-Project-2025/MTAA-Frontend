import 'package:flutter/material.dart';

/// Displays the Terms of Service and Privacy Policy for the Likely platform.
class TermsPolicyWidget extends StatelessWidget {
  /// Creates a [TermsPolicyWidget].
  const TermsPolicyWidget({super.key});

  /// Builds the UI with a scrollable list of terms and policy sections.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Terms of Service & Privacy Policy',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              SizedBox(height: 16),
              Text(
                'Last updated: [DATE]',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontStyle: FontStyle.italic),
              ),
              SizedBox(height: 24),
              Text(
                'Welcome to Likely, a platform built to connect, express, and discover. '
                'By using Likely, you agree to the following terms designed to ensure a safe, engaging, and evolving community experience.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 16),
              Text(
                '1. Account Usage & Eligibility',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(
                'We may, at our discretion, modify, suspend, or terminate your account, profile, access, or content at any time for any reason or no reason at all. '
                'This includes but is not limited to inactivity or behavior affecting the platform experience.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 16),
              Text(
                '2. Content and Licenses',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(
                'By sharing content, you grant Likely an unlimited, worldwide, perpetual, irrevocable, royalty-free license to use, host, reproduce, adapt, publish, '
                'modify, distribute, and display that content for any purpose, in any format. This license remains even after your account is removed.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 16),
              Text(
                '3. Platform Evolution',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(
                'Features, access, and policies may change at any time without prior notice. We may add, remove, or modify anything on the platform at our discretion.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 16),
              Text(
                '4. Your Responsibility',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(
                'You are responsible for activity under your account. You agree to avoid behavior that could be considered harmful or unlawful. '
                'However, we retain discretion in defining acceptable use.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 16),
              Text(
                '5. Termination',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(
                'We may terminate your access at any time, with or without cause. Data or content may be removed or retained at our discretion.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 16),
              Text(
                '6. Limitation of Liability',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(
                'Likely is provided "as is" without warranties. We are not liable for any damages related to your use of the platform.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 16),
              Text(
                '7. Privacy & Data Usage',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(
                'We may collect account info, content, device IDs, IPs, and behavioral data. This helps personalize and improve the platform.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 16),
              Text(
                '8. Data Sharing',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(
                'We may share anonymized or aggregated data with third parties. Data may be shared with vendors, partners, or during business transitions.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 16),
              Text(
                '9. Data Retention',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(
                'We may retain data indefinitely for legal, operational, and improvement purposes, even after account deletion.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 16),
              Text(
                '10. Your Rights',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(
                'You may request data access or deletion where legally applicable, but complete erasure may not be possible in all systems.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 16),
              Text(
                '11. Cookies & Tracking',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(
                'We use cookies and similar tech to enhance your experience and analyze behavior.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 16),
              Text(
                '12. Updates to Terms',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(
                'We may update this document at any time. Continued use constitutes acceptance of changes.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 32),
              Text(
                'By using Likely, you confirm that you have read, understood, and agreed to these terms.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontStyle: FontStyle.italic),
              ),
            ],
          )),
    );
  }
}
