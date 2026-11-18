import 'package:flutter/material.dart';
import 'flag_data.dart'; // Contains ThemeColors.current

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ThemeColors.current;

    return Scaffold(
      backgroundColor: theme.bgEnd,
      body: SizedBox.expand(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [theme.bgStart, theme.bgEnd],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                // Top Bar Header
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.arrow_back_rounded, color: theme.primary, size: 28),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Privacy Policy',
                        style: TextStyle(
                          color: theme.text,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),

                // Content Card
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: theme.cardBg,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: theme.border.withValues(alpha: 0.3)),
                    ),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildTitle('Privacy Policy', theme),
                          _buildSubHeader('Last Updated: November 2026', theme),
                          const SizedBox(height: 16),
                          _buildParagraph(
                            'Your privacy is important to us. Geo Clash is designed to give you a great gaming experience with minimal data footprint.',
                            theme,
                          ),
                          _buildSectionHeader('1. Data Collection', theme),
                          _buildParagraph(
                            'Geo Clash does not collect, track, or share personal information (such as your full name, email, address, or location). Player handle names and quiz scores are saved strictly on your local device.',
                            theme,
                          ),
                          _buildSectionHeader('2. Third-Party Ad Services', theme),
                          _buildParagraph(
                            'We use Google AdMob to deliver in-game ads. AdMob may process non-personal device identifiers and app interaction telemetry to serve contextually relevant ads and protect against fraudulent clicks.',
                            theme,
                          ),
                          _buildSectionHeader('3. Local Notifications', theme),
                          _buildParagraph(
                            'Our local notification service schedules game reminders locally on your hardware. No external communication or telemetry tracking is performed.',
                            theme,
                          ),
                          _buildSectionHeader('4. Children\'s Privacy', theme),
                          _buildParagraph(
                            'Geo Clash is suitable for general audiences and does not knowingly collect personal data from children under 13.',
                            theme,
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(String text, dynamic theme) {
    return Text(
      text,
      style: TextStyle(color: theme.primary, fontSize: 22, fontWeight: FontWeight.w900),
    );
  }

  Widget _buildSubHeader(String text, dynamic theme) {
    return Text(
      text,
      style: TextStyle(color: theme.text.withValues(alpha: 0.5), fontSize: 12),
    );
  }

  Widget _buildSectionHeader(String text, dynamic theme) {
    return Padding(
      padding: const EdgeInsets.only(top: 18.0, bottom: 6.0),
      child: Text(
        text,
        style: TextStyle(color: theme.text, fontSize: 15, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildParagraph(String text, dynamic theme) {
    return Text(
      text,
      style: TextStyle(color: theme.text.withValues(alpha: 0.8), fontSize: 13, height: 1.5),
    );
  }
}