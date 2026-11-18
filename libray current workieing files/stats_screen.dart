import 'package:flutter/material.dart';
import 'flag_data.dart';
import 'ad_helper.dart'; // Import AdHelper for BottomBannerAdWidget

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = ThemeColors.current;

    return Scaffold(
      backgroundColor: theme.bgEnd,
      appBar: AppBar(
        title: const Text('Player Statistics', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: theme.cardBg,
        foregroundColor: theme.text,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'OVERALL PERFORMANCE',
                style: TextStyle(color: theme.primary, fontWeight: FontWeight.bold, fontSize: 12),
              ),
              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      title: 'Total Games',
                      value: '${UserStats.totalGames}',
                      icon: '🎮',
                      theme: theme,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildStatCard(
                      title: 'Questions Played',
                      value: '${UserStats.totalQuestionsPlayed}',
                      icon: '❓',
                      theme: theme,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      title: 'Correct Answers',
                      value: '${UserStats.totalCorrectAnswers}',
                      icon: '✅',
                      theme: theme,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildStatCard(
                      title: 'Accuracy Rate',
                      value: '${UserStats.accuracyRate.toStringAsFixed(1)}%',
                      icon: '🎯',
                      theme: theme,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              Text(
                'BEST STREAK',
                style: TextStyle(color: theme.primary, fontWeight: FontWeight.bold, fontSize: 12),
              ),
              const SizedBox(height: 8),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.cardBg,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: theme.border.withValues(alpha: 0.3)),
                ),
                child: Row(
                  children: [
                    const Text('🔥', style: TextStyle(fontSize: 28)),
                    const SizedBox(width: 14),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Highest Combo', style: TextStyle(color: theme.text, fontWeight: FontWeight.bold, fontSize: 14)),
                        Text('${UserStats.highestStreak} Consecutive Correct Answers', style: TextStyle(color: theme.text.withValues(alpha: 0.6), fontSize: 12)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      // 📺 PINNED BOTTOM BANNER AD
      bottomNavigationBar: Container(
        color: theme.cardBg,
        child: const SafeArea(
          child: BottomBannerAdWidget(),
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required String icon,
    required ThemeColors theme,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: theme.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.border.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(icon, style: const TextStyle(fontSize: 22)),
          const SizedBox(height: 8),
          Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: theme.text)),
          const SizedBox(height: 2),
          Text(title, style: TextStyle(fontSize: 11, color: theme.text.withValues(alpha: 0.6), fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}