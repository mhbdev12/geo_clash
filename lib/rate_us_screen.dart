// ==========================================
// RATE US SCREEN - Star Rating & Feedback
// ==========================================
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'flag_data.dart';
import 'ad_helper.dart';

class RateUsScreen extends StatefulWidget {
  const RateUsScreen({super.key});

  @override
  State<RateUsScreen> createState() => _RateUsScreenState();
}

class _RateUsScreenState extends State<RateUsScreen> {
  int _selectedStars = 5;
  final TextEditingController _feedbackController = TextEditingController();
  String _selectedCategory = 'General Feedback';

  final List<String> _feedbackCategories = [
    'General Feedback',
    'Report a Bug 🐛',
    'Flag Data Correction 🚩',
    'Feature Suggestion 💡',
  ];

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  // 🚀 Open Google Play Store for Rating
  Future<void> _openPlayStore() async {
    const String packageName = 'com.hamza.geoclash';
    final Uri playStoreUri = Uri.parse('https://play.google.com/store/apps/details?id=$packageName');
    final Uri marketUri = Uri.parse('market://details?id=$packageName');

    try {
      if (await canLaunchUrl(marketUri)) {
        await launchUrl(marketUri, mode: LaunchMode.externalApplication);
      } else if (await canLaunchUrl(playStoreUri)) {
        await launchUrl(playStoreUri, mode: LaunchMode.externalApplication);
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Could not open Play Store URL')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error launching Play Store: $e')),
        );
      }
    }
  }

  // 📩 Submit internal feedback for lower ratings
  void _submitFeedback() {
    String message = _feedbackController.text.trim();
    if (message.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a brief note or feedback message.')),
      );
      return;
    }

    _feedbackController.clear();
    FocusScope.of(context).unfocus();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: ThemeColors.current.cardBg,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('🎉 Thank You!', textAlign: TextAlign.center, style: TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold)),
        content: Text(
          'Your feedback has been recorded. We continuously work to make GEO CLASH better!',
          textAlign: TextAlign.center,
          style: TextStyle(color: ThemeColors.current.text),
        ),
        actions: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                Navigator.pop(context); // Return to home
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ThemeColors.current.primary,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text('Back to Game', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = ThemeColors.current;

    return Scaffold(
      backgroundColor: theme.bgEnd,
      appBar: AppBar(
        title: const Text('Rate Us & Feedback', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: theme.cardBg,
        foregroundColor: theme.text,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),

              // 🌟 HEADER ICON
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: theme.primary.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.star_rounded, size: 64, color: Colors.amber),
              ),

              const SizedBox(height: 16),
              Text(
                'Enjoying GEO CLASH?',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: theme.text),
              ),
              const SizedBox(height: 6),
              Text(
                'Your rating helps us improve the game and bring new exciting features!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: theme.text.withValues(alpha: 0.7)),
              ),

              const SizedBox(height: 24),

              // ⭐ INTERACTIVE STAR RATING ROW
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: theme.cardBg,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: theme.border.withValues(alpha: 0.3)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    int starValue = index + 1;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedStars = starValue;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Icon(
                          starValue <= _selectedStars ? Icons.star_rounded : Icons.star_outline_rounded,
                          color: Colors.amber,
                          size: 42,
                        ),
                      ),
                    );
                  }),
                ),
              ),

              const SizedBox(height: 24),

              // 🚀 4 or 5 STARS -> REDIRECT TO PLAY STORE
              if (_selectedStars >= 4) ...[
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.greenAccent.withValues(alpha: 0.4)),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        '❤️ Glad you love the game!',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.greenAccent),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Please take a few seconds to give us 5 stars on the Play Store. It really supports our development!',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12, color: theme.text.withValues(alpha: 0.8)),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton.icon(
                          onPressed: _openPlayStore,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green.shade700,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          ),
                          icon: const Icon(Icons.shop_two, size: 22),
                          label: const Text('RATE ON PLAY STORE', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                        ),
                      ),
                    ],
                  ),
                ),
              ]

              // 📝 1 to 3 STARS -> IN-APP FEEDBACK FORM
              else ...[
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: theme.cardBg,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: theme.border.withValues(alpha: 0.3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'How can we make GEO CLASH better?',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: theme.text),
                      ),
                      const SizedBox(height: 10),

                      // Category Dropdown
                      DropdownButtonFormField<String>(
                        initialValue: _selectedCategory,
                        dropdownColor: theme.cardBg,
                        style: TextStyle(color: theme.text, fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                          filled: true,
                          fillColor: theme.bgEnd,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        items: _feedbackCategories.map((cat) {
                          return DropdownMenuItem(
                            value: cat,
                            child: Text(cat),
                          );
                        }).toList(),
                        onChanged: (val) {
                          if (val != null) {
                            setState(() {
                              _selectedCategory = val;
                            });
                          }
                        },
                      ),

                      const SizedBox(height: 12),

                      // Feedback Input
                      TextField(
                        controller: _feedbackController,
                        maxLines: 4,
                        style: TextStyle(color: theme.text),
                        decoration: InputDecoration(
                          hintText: 'Tell us what went wrong or what you would like improved...',
                          hintStyle: TextStyle(color: theme.text.withValues(alpha: 0.4), fontSize: 13),
                          filled: true,
                          fillColor: theme.bgEnd,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: theme.border.withValues(alpha: 0.3)),
                          ),
                        ),
                      ),

                      const SizedBox(height: 14),

                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton.icon(
                          onPressed: _submitFeedback,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.primary,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          icon: const Icon(Icons.send_rounded, size: 18),
                          label: const Text('SUBMIT FEEDBACK', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: theme.cardBg,
        child: const SafeArea(
          child: BottomBannerAdWidget(),
        ),
      ),
    );
  }
}