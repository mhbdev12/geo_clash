import 'package:flutter/material.dart';
import 'flag_data.dart'; // Contains ThemeColors.current

class TermsOfServiceScreen extends StatelessWidget {
  const TermsOfServiceScreen({super.key});

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
                        'Terms & Conditions',
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
                          _buildTitle('Terms & Conditions', theme),
                          _buildSubHeader('Last Updated: November 2026', theme),
                          const SizedBox(height: 16),
                          _buildParagraph(
                            'Welcome to Geo Clash! By downloading or playing the game, you agree to comply with these terms.',
                            theme,
                          ),
                          _buildSectionHeader('1. License & Usage', theme),
                          _buildParagraph(
                            'Geo Clash is a free-to-play educational geography quiz game. You may not copy, modify, reverse-engineer, or redistribute any portion of the app assets or code.',
                            theme,
                          ),
                          _buildSectionHeader('2. In-Game Advertisements', theme),
                          _buildParagraph(
                            'The app is supported by Google AdMob. By using the app, you agree to view contextual ads. Users are strictly prohibited from using automated tools or artificial clicks to interact with ads.',
                            theme,
                          ),
                          _buildSectionHeader('3. Local Data & Storage', theme),
                          _buildParagraph(
                            'Your gameplay stats, streaks, and custom player names are saved locally on your device. Clearing app cache or uninstalling the game may erase your saved progress.',
                            theme,
                          ),
                          _buildSectionHeader('4. Limitation of Liability', theme),
                          _buildParagraph(
                            'Geo Clash is provided "as-is" without warranties of any kind. The developers are not liable for any issues arising from app usage.',
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