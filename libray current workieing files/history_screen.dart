import 'package:flutter/material.dart';
import 'flag_data.dart';
import 'ad_helper.dart'; // Import AdHelper for BottomBannerAdWidget

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = ThemeColors.current;

    return Scaffold(
      backgroundColor: theme.bgEnd,
      appBar: AppBar(
        title: const Text('Quiz History', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: theme.cardBg,
        foregroundColor: theme.text,
        elevation: 0,
      ),
      body: SafeArea(
        child: UserStats.history.isEmpty
            ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('📜', style: TextStyle(fontSize: 48)),
              const SizedBox(height: 12),
              Text(
                'No Quiz History Yet',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: theme.text),
              ),
              const SizedBox(height: 4),
              Text(
                'Complete a game to see your past scores here.',
                style: TextStyle(color: theme.text.withValues(alpha: 0.6), fontSize: 13),
              ),

            ],

          ),
        )
            : ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: UserStats.history.length,
          itemBuilder: (context, index) {
            final result = UserStats.history[index];
            double pct = result.total == 0 ? 0 : (result.correct / result.total) * 100;
            String timeStr = '${result.date.hour.toString().padLeft(2, '0')}:${result.date.minute.toString().padLeft(2, '0')}';

            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: theme.cardBg,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: theme.border.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: theme.primary.withValues(alpha: 0.2),
                    child: Text(
                      '${pct.toStringAsFixed(0)}%',
                      style: TextStyle(color: theme.primary, fontWeight: FontWeight.w900, fontSize: 11),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          result.mode,
                          style: TextStyle(color: theme.text, fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${result.correct} / ${result.total} Correct  •  Streak: 🔥${result.streak}',
                          style: TextStyle(color: theme.text.withValues(alpha: 0.6), fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    timeStr,
                    style: TextStyle(color: theme.text.withValues(alpha: 0.4), fontSize: 11),
                  ),
                ],
              ),
            );
          },
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
}