import 'dart:async';
import 'package:flutter/material.dart';
import 'terms_of_service_screen.dart';
import 'privacy_policy_screen.dart';
import 'notification_service.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ad_helper.dart';
import 'flag_data.dart';
import 'settings_screen.dart';
import 'learning_screen.dart';
import 'history_screen.dart';
import 'stats_screen.dart';
import 'quiz_screen.dart';
import 'rate_us_screen.dart';
import 'flag_storage_service.dart';

void main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    // 🚀 Load App Open Ad and show it automatically the moment it finishes downloading
    try {
      MobileAds.instance.initialize();
      AdManager.loadAppOpenAd(onLoaded: () {
        AdManager.showAppOpenAdIfAvailable();
      });
      AdManager.loadInterstitialAd();
      AdManager.loadRewardedAd();
    } catch (e) {
      debugPrint("Failed to initialize Ads: $e");
    }

    // Initialize notifications & schedule reminders safely
    try {
      await NotificationService().scheduleInactivityReminders();
    } catch (e) {
      debugPrint("Failed to schedule notification: $e");
    }

    // Initialize offline flag storage and start silent background preload safely
    try {
      await FlagStorageService.instance.init();
      FlagStorageService.instance.preloadAllFlags();
    } catch (e) {
      debugPrint("Failed to initialize FlagStorageService: $e");
    }

    runApp(const FlagQuizApp());
  }, (error, stack) {
    debugPrint("Uncaught app error: $error\n$stack");
  });
}

class FlagQuizApp extends StatefulWidget {
  const FlagQuizApp({super.key});

  @override
  State<FlagQuizApp> createState() => _FlagQuizAppState();
}

class _FlagQuizAppState extends State<FlagQuizApp> {
  void refreshTheme() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Geo Clash',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
        useMaterial3: true,
      ),
      home: HomeScreen(onThemeChanged: refreshTheme),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final VoidCallback onThemeChanged;

  const HomeScreen({super.key, required this.onThemeChanged});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _checkAndLoadSavedName();
  }

  Future<void> _checkAndLoadSavedName() async {
    final prefs = await SharedPreferences.getInstance();
    final String? savedName = prefs.getString('player_name');

    if (savedName != null && savedName.isNotEmpty) {
      setState(() {
        GameSettings.playerName = savedName;
      });
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showNameInputDialog(context, isFirstTime: true);
      });
    }
  }

  Future<void> _savePlayerNamePreference(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('player_name', name);
  }

  void _showNameInputDialog(BuildContext context, {bool isFirstTime = false}) {
    final theme = ThemeColors.current;
    final TextEditingController nameController = TextEditingController(
      text: GameSettings.playerName == 'Player 1' ? '' : GameSettings.playerName,
    );

    showDialog(
      context: context,
      barrierDismissible: !isFirstTime,
      builder: (context) {
        return AlertDialog(
          backgroundColor: theme.cardBg,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Row(
            children: [
              const Text('🎮 '),
              Text(
                isFirstTime ? 'Welcome Player!' : 'Edit Player Name',
                style: TextStyle(color: theme.primary, fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isFirstTime ? 'Please enter your name to customize your game profile:' : 'Update your gamer handle:',
                style: TextStyle(color: theme.text.withValues(alpha: 0.8), fontSize: 13),
              ),
              const SizedBox(height: 14),
              TextField(
                controller: nameController,
                autofocus: true,
                style: TextStyle(color: theme.text, fontSize: 15, fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  hintText: 'Enter your name...',
                  hintStyle: TextStyle(color: theme.text.withValues(alpha: 0.4)),
                  prefixIcon: Icon(Icons.person, color: theme.primary),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: theme.border.withValues(alpha: 0.5)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: theme.primary, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            if (!isFirstTime)
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancel', style: TextStyle(color: theme.text.withValues(alpha: 0.6))),
              ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.primary,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () async {
                String input = nameController.text.trim();
                if (input.isNotEmpty) {
                  setState(() {
                    GameSettings.playerName = input;
                  });
                  Navigator.pop(context);
                  await _savePlayerNamePreference(input);
                } else {
                  Navigator.pop(context);
                }
              },
              child: const Text('SAVE NAME', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }

  void _showTwoPlayerSetupDialog(BuildContext context) {
    final theme = ThemeColors.current;
    final TextEditingController p1Controller = TextEditingController(text: GameSettings.playerName);
    final TextEditingController p2Controller = TextEditingController(text: 'Player 2');
    int selectedQuestions = 10;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: theme.cardBg,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              title: Text(
                '🎮 2-Player Mode Setup',
                textAlign: TextAlign.center,
                style: TextStyle(color: theme.primary, fontWeight: FontWeight.bold, fontSize: 18),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: p1Controller,
                    style: TextStyle(color: theme.text, fontSize: 14),
                    decoration: InputDecoration(
                      labelText: 'Player 1 Name',
                      labelStyle: TextStyle(color: theme.primary),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: theme.border.withValues(alpha: 0.5)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: theme.primary),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: p2Controller,
                    style: TextStyle(color: theme.text, fontSize: 14),
                    decoration: InputDecoration(
                      labelText: 'Player 2 Name',
                      labelStyle: TextStyle(color: theme.primary),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: theme.border.withValues(alpha: 0.5)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: theme.primary),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Questions per Player:', style: TextStyle(color: theme.text, fontSize: 12, fontWeight: FontWeight.bold)),
                      DropdownButtonHideUnderline(
                        child: DropdownButton<int>(
                          value: selectedQuestions,
                          dropdownColor: theme.cardBg,
                          icon: Icon(Icons.arrow_drop_down, color: theme.primary),
                          items: [5, 10, 15, 20, 30, 50].map((int val) {
                            return DropdownMenuItem<int>(
                              value: val,
                              child: Text('$val Qs', style: TextStyle(color: theme.text, fontWeight: FontWeight.bold, fontSize: 13)),
                            );
                          }).toList(),
                          onChanged: (val) {
                            if (val != null) {
                              setDialogState(() => selectedQuestions = val);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel', style: TextStyle(color: theme.text.withValues(alpha: 0.6))),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.primary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () {
                    String p1 = p1Controller.text.trim().isEmpty ? GameSettings.playerName : p1Controller.text.trim();
                    String p2 = p2Controller.text.trim().isEmpty ? 'Player 2' : p2Controller.text.trim();
                    Navigator.pop(context);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QuizScreen(
                          categoryTitle: '2-Player Mode',
                          isTwoPlayer: true,
                          player1Name: p1,
                          player2Name: p2,
                          selectedOptionsCount: 4,
                          totalQuestionsCount: selectedQuestions,
                        ),
                      ),
                    );
                  },
                  child: const Text('START BATTLE', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = ThemeColors.current;

    return Scaffold(
      backgroundColor: theme.bgEnd,
      drawer: Drawer(
        backgroundColor: theme.cardBg,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: theme.primary),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 26,
                        child: Text('🌍', style: TextStyle(fontSize: 30)),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        GameSettings.playerName,
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const Text('Basic Player Mode', style: TextStyle(color: Colors.white70, fontSize: 12)),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.white, size: 20),
                    tooltip: 'Edit Name',
                    onPressed: () {
                      Navigator.pop(context);
                      _showNameInputDialog(context);
                    },
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home, color: theme.primary, size: 24),
              title: Text('Home', style: TextStyle(color: theme.text, fontWeight: FontWeight.bold)),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(Icons.school_rounded, color: theme.primary, size: 24),
              title: Text('Learn Flags & Capitals', style: TextStyle(color: theme.text, fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => const LearningScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.stacked_bar_chart, color: theme.primary, size: 24),
              title: Text('Player Stats', style: TextStyle(color: theme.text, fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => const StatsScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.history, color: theme.primary, size: 24),
              title: Text('Quiz History', style: TextStyle(color: theme.text, fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => const HistoryScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.settings, color: theme.primary, size: 24),
              title: Text('Settings', style: TextStyle(color: theme.text, fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsScreen(
                  onThemeChanged: () {
                    widget.onThemeChanged();
                    setState(() {});
                  },
                )));
              },
            ),
            ListTile(
              leading: Icon(Icons.star_rate_rounded, color: theme.primary, size: 24),
              title: Text('Rate Us & Feedback', style: TextStyle(color: theme.text, fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RateUsScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.description_rounded, color: theme.primary, size: 24),
              title: Text('Terms & Conditions', style: TextStyle(color: theme.text, fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => const TermsOfServiceScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.privacy_tip_rounded, color: theme.primary, size: 24),
              title: Text('Privacy Policy', style: TextStyle(color: theme.text, fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => const PrivacyPolicyScreen()));
              },
            ),
          ],
        ),
      ),
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Builder(
                builder: (context) => Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () => Scaffold.of(context).openDrawer(),
                          icon: Icon(
                            Icons.menu,
                            color: theme.primary,
                            size: 28,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1E293B),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.orange, width: 1.2),
                          ),
                          child: const Row(
                            children: [
                              Text('🔥', style: TextStyle(fontSize: 14)),
                              SizedBox(width: 6),
                              Text('0 STREAK', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 12, color: Colors.amberAccent)),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const StatsScreen()));
                          },
                          icon: Icon(
                            Icons.stacked_bar_chart,
                            color: theme.primary,
                            size: 28,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      height: 160,
                      width: 160,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(color: theme.primary.withValues(alpha: 0.3), blurRadius: 20, offset: const Offset(0, 4)),
                        ],
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/pics/flag_globe.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 22),
                    Text(
                      'GEO CLASH',
                      style: TextStyle(fontSize: 38, fontWeight: FontWeight.w900, color: theme.primary, letterSpacing: 2.0),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'WORLD FLAGS & CAPITALS',
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: theme.text.withValues(alpha: 0.6), letterSpacing: 1.5),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const ModeSelectionScreen()));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.primary,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                        child: const Text('START QUIZ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                      ),
                    ),
                    const SizedBox(height: 12),
                    OutlinedButton(
                      onPressed: () => _showTwoPlayerSetupDialog(context),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        side: BorderSide(color: theme.primary, width: 1.5),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      child: Text('2-PLAYER PASS & PLAY', style: TextStyle(color: theme.primary, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
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

class ModeSelectionScreen extends StatefulWidget {
  const ModeSelectionScreen({super.key});

  @override
  State<ModeSelectionScreen> createState() => _ModeSelectionScreenState();
}

class _ModeSelectionScreenState extends State<ModeSelectionScreen> {
  int selectedCategoryIndex = 2;
  final Map<int, int> categoryQuestionCounts = {0: 10, 1: 10, 2: 10, 3: 10, 4: 10, 5: 10, 6: 10, 7: 10};
  final Map<int, int> categoryOptionsCount = {0: 4, 1: 4, 2: 4, 3: 4, 4: 4, 5: 4, 6: 4, 7: 4};

  final List<Map<String, dynamic>> categories = const [
    {'title': 'CAPITALS QUIZ', 'isCapitalMode': true, 'sub': 'Guess Country Capitals', 'symbol': '🏛️'},
    {'title': 'ENDLESS MODE', 'isEndless': true, 'sub': '4 Lives Mode', 'symbol': '♾️'},
    {'title': 'CLASSIC ARCADE', 'sub': 'Mixed Flags', 'symbol': '⚡'},
    {'title': 'AFRICA FLAGS', 'sub': 'African Nations (54)', 'symbol': '🌍'},
    {'title': 'EUROPE FLAGS', 'sub': 'European Nations (40+)', 'symbol': '🏰'},
    {'title': 'ASIA FLAGS', 'sub': 'Asian Nations', 'symbol': '⛩️'},
    {'title': 'MUSLIM COUNTRIES', 'sub': 'Islamic World (30+)', 'symbol': '☪️'},
    {'title': 'UNITED KINGDOM', 'sub': 'UK Nations & Territories', 'symbol': '🇬🇧'},
  ];

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
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Icon(
                          Icons.arrow_back_rounded,
                          color: theme.primary,
                          size: 30,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text('SELECT GAME MODE', style: TextStyle(color: theme.text, fontWeight: FontWeight.bold, fontSize: 18)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: theme.cardBg,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: theme.border.withValues(alpha: 0.3)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DropdownButtonHideUnderline(
                          child: DropdownButton<int>(
                            value: selectedCategoryIndex,
                            dropdownColor: theme.cardBg,
                            icon: Icon(Icons.arrow_drop_down, color: theme.primary),
                            items: List.generate(categories.length, (idx) {
                              return DropdownMenuItem<int>(
                                value: idx,
                                child: Text(
                                  categories[idx]['title'] as String,
                                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: theme.primary),
                                ),
                              );
                            }),
                            onChanged: (int? newIndex) {
                              if (newIndex != null) {
                                setState(() {
                                  selectedCategoryIndex = newIndex;
                                });
                              }
                            },
                          ),
                        ),
                        DropdownButtonHideUnderline(
                          child: DropdownButton<int>(
                            value: categoryQuestionCounts[selectedCategoryIndex] ?? 10,
                            dropdownColor: theme.cardBg,
                            icon: Icon(Icons.arrow_drop_down, color: theme.primary),
                            items: [5, 10, 15, 20, 30, 50].map((int count) {
                              return DropdownMenuItem<int>(
                                value: count,
                                child: Text(
                                  '$count Questions',
                                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: theme.text),
                                ),
                              );
                            }).toList(),
                            onChanged: (int? newValue) {
                              if (newValue != null) {
                                setState(() {
                                  categoryQuestionCounts[selectedCategoryIndex] = newValue;
                                });
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  Expanded(
                    child: ListView.builder(
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final cat = categories[index];
                        int currentChoice = categoryOptionsCount[index] ?? 4;
                        int currentQuestions = categoryQuestionCounts[index] ?? 10;
                        bool isSelectedCategory = index == selectedCategoryIndex;

                        return Container(
                          margin: const EdgeInsets.only(bottom: 14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                decoration: BoxDecoration(
                                  color: theme.cardBg,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: isSelectedCategory ? theme.primary : theme.border.withValues(alpha: 0.3),
                                    width: isSelectedCategory ? 2.0 : 1.0,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Text(cat['symbol'] as String, style: const TextStyle(fontSize: 24)),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            cat['title'] as String,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: theme.text),
                                          ),
                                          const SizedBox(height: 3),
                                          Text(
                                            '${cat['sub']} ($currentQuestions Qs)',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(fontSize: 11, color: theme.text.withValues(alpha: 0.6)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: theme.primary,
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                        elevation: 2,
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => QuizScreen(
                                              categoryTitle: cat['title'] as String,
                                              isEndless: cat['isEndless'] ?? false,
                                              isCapitalMode: cat['isCapitalMode'] ?? false,
                                              selectedOptionsCount: currentChoice,
                                              totalQuestionsCount: currentQuestions,
                                            ),
                                          ),
                                        );
                                      },
                                      child: const Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text('START', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                                          SizedBox(width: 4),
                                          Icon(Icons.arrow_forward_rounded, size: 14),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [3, 4, 5].map((count) {
                                  bool isSelected = currentChoice == count;
                                  return GestureDetector(
                                    onTap: () => setState(() => categoryOptionsCount[index] = count),
                                    child: Container(
                                      margin: const EdgeInsets.only(right: 6),
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                      decoration: BoxDecoration(
                                        color: isSelected ? theme.primary : theme.cardBg,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(color: isSelected ? theme.primary : theme.border.withValues(alpha: 0.3)),
                                      ),
                                      child: Text(
                                        '$count Options',
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: isSelected ? Colors.white : theme.text.withValues(alpha: 0.7),
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
