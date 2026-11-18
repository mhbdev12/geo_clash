// ==========================================
// QUIZ SCREEN - Main Gameplay, Scoring, & Animations
// ==========================================
import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'flag_data.dart';
import 'audio_manager.dart';
import 'ad_helper.dart';
import 'offline_flag_image.dart';
import 'notification_service.dart';

class QuizScreen extends StatefulWidget {
  final String categoryTitle;
  final bool isEndless;
  final bool isTwoPlayer;
  final String player1Name;
  final String player2Name;
  final bool isCapitalMode;
  final bool isMapMode;
  final int selectedOptionsCount;
  final int totalQuestionsCount;

  const QuizScreen({
    super.key,
    required this.categoryTitle,
    this.isEndless = false,
    this.isTwoPlayer = false,
    this.player1Name = 'Player 1',
    this.player2Name = 'Player 2',
    this.isCapitalMode = false,
    this.isMapMode = false,
    this.selectedOptionsCount = 4,
    this.totalQuestionsCount = 10,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> with TickerProviderStateMixin {
  late List<FlagItem> gamePool;
  int currentIndex = 0;
  int score = 0;
  int totalPoints = 0;

  // 🎮 2-PLAYER MODE STATE VARIABLES
  int player1Score = 0;
  int player2Score = 0;
  int player1Lives = 5;
  int player2Lives = 5;
  int currentPlayerTurn = 1;

  int currentStreak = 0;

  int lives = 6;
  int hintsRemaining = 2; // 💡 Set default free hints to 2

  // ⏱️ TIMER STATE VARIABLES
  Timer? _timer;
  int _timeLeft = 15;
  final int _maxTime = 15;

  late List<bool?> progressHistory;
  late FlagItem currentQuestion;
  late List<FlagItem> currentOptions;
  FlagItem? selectedAnswer;
  bool isAnswering = false;

  // 🎯 Multi-option elimination tracking list
  List<FlagItem> eliminatedOptions = [];

  String? overlayStatusMessage;
  Color overlayColor = Colors.green;
  bool isHighPowerCombo = false;

  late AnimationController _shakeController;
  late AnimationController _powerPulseController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _powerPulseController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.2, end: 1.20).animate(
      CurvedAnimation(parent: _powerPulseController, curve: Curves.elasticOut),
    );

    _restartQuiz();
  }

  void _restartQuiz() {
    setState(() {
      currentIndex = 0;
      score = 0;
      totalPoints = 0;
      player1Score = 0;
      player2Score = 0;
      player1Lives = 5;
      player2Lives = 5;
      currentPlayerTurn = 1;
      currentStreak = 0;
      lives = 6;
      hintsRemaining = 2; // 💡 Reset hints to 2 on restart
      selectedAnswer = null;
      isAnswering = false;
      eliminatedOptions.clear();
      overlayStatusMessage = null;
      isHighPowerCombo = false;
    });

    _initializeGamePool();
    _loadQuestion();
    AudioManager.startBgm();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _shakeController.dispose();
    _powerPulseController.dispose();
    AudioManager.stopBgm();
    NotificationService().scheduleInactivityReminders();
    super.dispose();
  }

  void _initializeGamePool() {
    List<FlagItem> all = List.from(FlagRepository.flags)..shuffle();
    List<FlagItem> filtered = [];

    if (widget.categoryTitle.contains('AFRICA')) {
      filtered = all.where((f) => f.category == 'Africa').toList();
    } else if (widget.categoryTitle.contains('EUROPE')) {
      filtered = all.where((f) => f.category == 'Europe').toList();
    } else if (widget.categoryTitle.contains('ASIA')) {
      filtered = all.where((f) => f.category == 'Asia').toList();
    } else if (widget.categoryTitle.contains('MUSLIM')) {
      filtered = all.where((f) => f.category == 'Muslim').toList();
    } else if (widget.categoryTitle.contains('UNITED KINGDOM') || widget.categoryTitle.contains('UK')) {
      filtered = all.where((f) => f.category == 'UK').toList();
    } else {
      filtered = List.from(all);
    }

    filtered.shuffle();

    if (!widget.isEndless) {
      int countToTake = min(widget.totalQuestionsCount, filtered.length);
      gamePool = filtered.sublist(0, countToTake);
    } else {
      gamePool = filtered;
    }

    progressHistory = List.filled(gamePool.length, null);
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() {
      _timeLeft = _maxTime;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft > 0) {
        setState(() {
          _timeLeft--;
        });
        if (_timeLeft <= 7) {
          AudioManager.playSfx('tick');
        }
      } else {
        _timer?.cancel();
        AudioManager.stopSfx();
        _handleTimeOut();
      }
    });
  }

  void _resetTimer() {
    _startTimer();
  }

  void _resumeTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft > 0) {
        setState(() {
          _timeLeft--;
        });
        if (_timeLeft <= 7) {
          AudioManager.playSfx('tick');
        }
      } else {
        _timer?.cancel();
        AudioManager.stopSfx();
        _handleTimeOut();
      }
    });
  }

  void _handleTimeOut() {
    if (!mounted || isAnswering) return;

    _timer?.cancel();
    AudioManager.stopSfx();

    if (widget.isTwoPlayer) {
      setState(() {
        isAnswering = true;
        currentStreak = 0;
        overlayStatusMessage = '⏳ TIME OUT!';
        overlayColor = Colors.redAccent;
        AudioManager.playSfx('wrong');

        if (currentPlayerTurn == 1) {
          player1Lives--;
          if (player1Lives <= 0) {
            _triggerGameOver(true, eliminatedPlayer: 1);
            return;
          }
        } else {
          player2Lives--;
          if (player2Lives <= 0) {
            _triggerGameOver(true, eliminatedPlayer: 2);
            return;
          }
        }
      });

      Future.delayed(const Duration(milliseconds: 1300), () {
        if (!mounted) return;
        setState(() {
          currentPlayerTurn = currentPlayerTurn == 1 ? 2 : 1;
          currentIndex++;
          _loadQuestion();
        });
      });
      return;
    }

    AudioManager.pauseBgm();
    final theme = ThemeColors.current;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: theme.cardBg,
        title: const Text('⏳ Time\'s Up!', style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
        content: Text('Watch a quick video to get 15 extra seconds and keep your streak going?', style: TextStyle(color: theme.text.withValues(alpha: 0.8))),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _triggerGameOver(true);
            },
            child: Text('End Game', style: TextStyle(color: theme.text.withValues(alpha: 0.6))),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              AdManager.showRewardedAd(
                context: context,
                onUserEarnedReward: () {
                  setState(() {
                    isAnswering = false;
                    _timeLeft = 15;
                    overlayStatusMessage = null;
                  });
                  _startTimer();
                  AudioManager.resumeBgm();
                },
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: const Text('Continue (Watch Ad)', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _loadQuestion() {
    if (currentIndex >= gamePool.length) {
      if (widget.isEndless) {
        gamePool.shuffle();
        currentIndex = 0;
        progressHistory = List.filled(gamePool.length, null);
      } else {
        _triggerGameOver(false);
        return;
      }
    }

    currentQuestion = gamePool[currentIndex];
    selectedAnswer = null;
    isAnswering = false;
    eliminatedOptions.clear();
    overlayStatusMessage = null;
    isHighPowerCombo = false;

    Set<FlagItem> options = {currentQuestion};
    List<FlagItem> shuffleList = List.from(FlagRepository.flags)..shuffle();

    for (var flag in shuffleList) {
      if (options.length >= widget.selectedOptionsCount) {
        break;
      }
      if (flag.country != currentQuestion.country) {
        options.add(flag);
      }
    }

    currentOptions = options.toList()..shuffle();
    _resetTimer();
    AudioManager.startBgm();
  }

  void _useHint() {
    if (isAnswering) return;

    if (widget.selectedOptionsCount == 3 && eliminatedOptions.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('⚠️ Only 1 hint allowed in 3-option mode!')),
      );
      return;
    }

    if (hintsRemaining <= 0) {
      _timer?.cancel();
      AudioManager.stopSfx();
      AudioManager.pauseBgm();
      final theme = ThemeColors.current;

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          backgroundColor: theme.cardBg,
          title: Text('💡 Out of Hints!', style: TextStyle(color: theme.text, fontWeight: FontWeight.bold)),
          content: Text('Watch a short video to earn 1 extra hint?', style: TextStyle(color: theme.text.withValues(alpha: 0.8))),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _resumeTimer();
                AudioManager.resumeBgm();
              },
              child: Text('Cancel', style: TextStyle(color: theme.text.withValues(alpha: 0.6))),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                AdManager.showRewardedAd(
                  context: context,
                  onUserEarnedReward: () {
                    setState(() {
                      hintsRemaining += 1;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('🎉 You earned 1 extra hint!')),
                    );
                    _resetTimer();
                    AudioManager.resumeBgm();
                  },
                  onAdDismissed: () {
                    _resumeTimer();
                    AudioManager.resumeBgm();
                  },
                );
              },
              child: const Text('Watch Ad 📺'),
            ),
          ],
        ),
      );
      return;
    }

    List<FlagItem> wrongOptions = currentOptions
        .where((opt) => opt.country != currentQuestion.country && !eliminatedOptions.contains(opt))
        .toList();

    if (wrongOptions.isEmpty) return;

    wrongOptions.shuffle();
    FlagItem toRemove = wrongOptions.first;

    setState(() {
      eliminatedOptions.add(toRemove);
      hintsRemaining--;
    });
  }

  // 📳 Helper function to trigger shake and check for system vibration settings
  void _triggerShakeAndHaptics() async {
    if (GameSettings.enableShake) {
      // 1. Visual shake always runs
      _shakeController.forward(from: 0.0);

      // 2. Perform safe system haptic call
      try {
        await HapticFeedback.vibrate();
      } catch (_) {
        // Safe catch if device doesn't support vibration hardware
      }

      // 3. Notify user if system vibration feedback is turned off globally
      if (mounted) {
        bool? isHapticEnabled = await SystemChannels.platform.invokeMethod<bool>('HapticFeedback.vibrate');
        if (isHapticEnabled == false) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('💡 Vibration is turned off in your phone settings.'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      }
    }
  }

  void _handleOptionSelect(FlagItem option) {
    if (isAnswering || eliminatedOptions.contains(option)) return;

    _timer?.cancel();

    bool isCorrect = (option.country == currentQuestion.country);

    setState(() {
      isAnswering = true;
      selectedAnswer = option;

      if (currentIndex < progressHistory.length) {
        progressHistory[currentIndex] = isCorrect;
      }

      if (isCorrect) {
        score++;
        currentStreak++;
        totalPoints += (100 * (currentStreak >= 2 ? currentStreak : 1));

        if (widget.isTwoPlayer) {
          if (currentPlayerTurn == 1) {
            player1Score++;
          } else {
            player2Score++;
          }
        }

        if (currentStreak >= 2) {
          isHighPowerCombo = true;
          overlayStatusMessage = '⚡ POWER ${currentStreak}x COMBO! ⚡';
          overlayColor = Colors.orangeAccent;
          AudioManager.playSfx('combo');
          _powerPulseController.forward(from: 0.0);
        } else {
          overlayStatusMessage = '🎉 GREAT JOB!';
          overlayColor = Colors.green;
          AudioManager.playSfx('correct');
          _powerPulseController.forward(from: 0.0);
        }
      } else {
        currentStreak = 0;
        overlayStatusMessage = '❌ OH NO!';
        overlayColor = Colors.redAccent;
        isHighPowerCombo = false;

        AudioManager.playSfx('wrong');

        // 📳 Executes screen shake and safe haptic check
        _triggerShakeAndHaptics();

        if (widget.isTwoPlayer) {
          if (currentPlayerTurn == 1) {
            player1Lives--;
            if (player1Lives <= 0) {
              _triggerGameOver(true, eliminatedPlayer: 1);
              return;
            }
          } else {
            player2Lives--;
            if (player2Lives <= 0) {
              _triggerGameOver(true, eliminatedPlayer: 2);
              return;
            }
          }
        } else if (widget.isEndless) {
          lives--;
          if (lives <= 0) {
            _triggerGameOver(true);
            return;
          }
        }
      }
    });

    Future.delayed(const Duration(milliseconds: 1300), () {
      if (!mounted) return;
      setState(() {
        if (widget.isTwoPlayer && !isCorrect) {
          currentPlayerTurn = currentPlayerTurn == 1 ? 2 : 1;
        }

        currentIndex++;
        _loadQuestion();
      });
    });
  }

  void _triggerGameOver(bool hasLost, {int? eliminatedPlayer}) {
    _timer?.cancel();
    AudioManager.stopSfx();
    AudioManager.pauseBgm();

    AdManager.showInterstitialAd(onAdClosed: () {
      if (!mounted) return;
      _showGameOverDialog(hasLost: hasLost, eliminatedPlayer: eliminatedPlayer);
    });
  }

  void _showGameOverDialog({required bool hasLost, int? eliminatedPlayer}) {
    UserStats.recordGame(
      mode: widget.categoryTitle,
      correct: score,
      total: widget.isEndless ? currentIndex + 1 : gamePool.length,
      streak: currentStreak,
      optionsCount: widget.selectedOptionsCount,
    );

    final theme = ThemeColors.current;

    int totalQ = widget.isEndless ? currentIndex + 1 : gamePool.length;
    double percentage = totalQ == 0 ? 0 : (score / totalQ) * 100;

    String performanceBadge = '💡 KEEP PRACTICING!';
    Color badgeColor = Colors.grey;

    if (percentage >= 90) {
      performanceBadge = '🔥 EXCELLENT!';
      badgeColor = Colors.amberAccent;
    } else if (percentage >= 70) {
      performanceBadge = '⭐ VERY GOOD!';
      badgeColor = Colors.greenAccent;
    } else if (percentage >= 50) {
      performanceBadge = '👍 GOOD EFFORT!';
      badgeColor = Colors.blueAccent;
    }

    String winnerText = 'Score: $score / $totalQ';
    if (widget.isTwoPlayer) {
      if (eliminatedPlayer == 1) {
        winnerText = '💥 ${widget.player1Name} Ran Out of Hearts!\n🏆 ${widget.player2Name} Wins!';
      } else if (eliminatedPlayer == 2) {
        winnerText = '💥 ${widget.player2Name} Ran Out of Hearts!\n🏆 ${widget.player1Name} Wins!';
      } else {
        if (player1Score > player2Score) {
          winnerText = '🏆 ${widget.player1Name} Wins!\n$player1Score vs $player2Score';
        } else if (player2Score > player1Score) {
          winnerText = '🏆 ${widget.player2Name} Wins!\n$player2Score vs $player1Score';
        } else {
          winnerText = '🤝 It\'s a Tie!\n$player1Score vs $player2Score';
        }
      }
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: theme.cardBg,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          widget.isTwoPlayer ? '🎮 Battle Finished!' : (hasLost ? '❌ Game Over' : '🏆 Quiz Results'),
          textAlign: TextAlign.center,
          style: TextStyle(color: theme.primary, fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: theme.primary.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                widget.categoryTitle.toUpperCase(),
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: theme.primary, letterSpacing: 1.1),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              winnerText,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: theme.text),
            ),
            const SizedBox(height: 10),
            Text('⭐ Total Points: $totalPoints pts', style: const TextStyle(color: Colors.amberAccent, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: badgeColor.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: badgeColor, width: 1.2),
              ),
              child: Text(
                performanceBadge,
                style: TextStyle(color: badgeColor, fontWeight: FontWeight.w900, fontSize: 13),
              ),
            ),
          ],
        ),
        actions: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (hasLost && !widget.isTwoPlayer) ...[
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      AdManager.showRewardedAd(
                        context: context,
                        onUserEarnedReward: () {
                          setState(() {
                            if (widget.isEndless) {
                              lives = 3;
                            } else {
                              if (currentIndex > 0) {
                                currentIndex = max(0, currentIndex - 1);
                              }
                            }
                            isAnswering = false;
                          });
                          _loadQuestion();
                          AudioManager.resumeBgm();
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber.shade800,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    icon: const Icon(Icons.play_circle_fill, size: 18),
                    label: const Text('Continue Quiz (Watch Ad 📺)', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(height: 6),
              ],
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: Text('Home', style: TextStyle(color: theme.text.withValues(alpha: 0.7), fontWeight: FontWeight.bold)),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      _restartQuiz();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    icon: Icon(hasLost ? Icons.replay : Icons.play_arrow_rounded, size: 16),
                    label: Text(hasLost ? 'Try Again' : 'Play Again', style: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ],
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
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          _timer?.cancel();
                          AudioManager.stopSfx();
                          AudioManager.stopBgm();
                          Navigator.pop(context);
                        },
                        child: Text('← Exit', style: TextStyle(color: theme.primary, fontWeight: FontWeight.bold, fontSize: 15)),
                      ),

                      if (widget.isEndless)
                        Row(
                          children: List.generate(6, (index) {
                            return Icon(
                              index < lives ? Icons.favorite : Icons.favorite_border,
                              color: Colors.redAccent,
                              size: 18,
                            );
                          }),
                        )
                      else
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(color: theme.cardBg, borderRadius: BorderRadius.circular(12)),
                          child: Row(
                            children: [
                              const Icon(Icons.stars, color: Colors.amber, size: 16),
                              const SizedBox(width: 4),
                              Text('$totalPoints pts', style: TextStyle(color: theme.text, fontWeight: FontWeight.bold, fontSize: 13)),
                            ],
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("⏱️ Time left", style: TextStyle(color: theme.text.withValues(alpha: 0.7), fontSize: 11, fontWeight: FontWeight.bold)),
                      Text(
                        "$_timeLeft s",
                        style: TextStyle(
                          color: _timeLeft <= 5 ? Colors.redAccent : theme.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),

                  LinearProgressIndicator(
                    value: _timeLeft / _maxTime,
                    backgroundColor: theme.border.withValues(alpha: 0.3),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      _timeLeft <= 5 ? Colors.redAccent : theme.primary,
                    ),
                  ),
                  const SizedBox(height: 8),

                  if (widget.isTwoPlayer) ...[
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(color: theme.cardBg, borderRadius: BorderRadius.circular(12)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                '${widget.player1Name}: $player1Score pts',
                                style: TextStyle(
                                  color: currentPlayerTurn == 1 ? Colors.greenAccent : theme.text.withValues(alpha: 0.5),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Row(
                                children: List.generate(5, (index) {
                                  return Icon(
                                    index < player1Lives ? Icons.favorite : Icons.favorite_border,
                                    color: Colors.redAccent,
                                    size: 14,
                                  );
                                }),
                              ),
                            ],
                          ),
                          const Text('VS', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.w900, fontSize: 14)),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                '${widget.player2Name}: $player2Score pts',
                                style: TextStyle(
                                  color: currentPlayerTurn == 2 ? Colors.greenAccent : theme.text.withValues(alpha: 0.5),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Row(
                                children: List.generate(5, (index) {
                                  return Icon(
                                    index < player2Lives ? Icons.favorite : Icons.favorite_border,
                                    color: Colors.redAccent,
                                    size: 14,
                                  );
                                }),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 6),
                  ],

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Q: ${currentIndex + 1}/${gamePool.length}', style: TextStyle(color: theme.text, fontWeight: FontWeight.bold)),
                      if (widget.isTwoPlayer)
                        Text(
                          'TURN: ${currentPlayerTurn == 1 ? widget.player1Name : widget.player2Name}',
                          style: const TextStyle(color: Colors.amberAccent, fontWeight: FontWeight.w900, fontSize: 13),
                        ),
                      Text('Score: $score', style: TextStyle(color: theme.primary, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 6),

                  SizedBox(
                    height: 8,
                    child: Row(
                      children: List.generate(progressHistory.length, (idx) {
                        bool? status = progressHistory[idx];
                        Color barCol = theme.border.withValues(alpha: 0.3);
                        if (status == true) barCol = Colors.greenAccent;
                        if (status == false) barCol = Colors.redAccent;

                        return Expanded(
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 1.5),
                            decoration: BoxDecoration(color: barCol, borderRadius: BorderRadius.circular(4)),
                          ),
                        );
                      }),
                    ),
                  ),
                  const SizedBox(height: 10),

                  AnimatedBuilder(
                    animation: _shakeController,
                    builder: (context, child) {
                      final double offset = sin(_shakeController.value * pi * 10) * 16;
                      return Transform.translate(offset: Offset(offset, 0), child: child);
                    },
                    child: Container(
                      width: double.infinity,
                      height: 180,
                      decoration: BoxDecoration(
                        color: theme.cardBg,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isHighPowerCombo ? Colors.orangeAccent : theme.border.withValues(alpha: 0.3),
                          width: isHighPowerCombo ? 2.5 : 1.0,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Center(
                          child: OfflineFlagImage(
                            imageUrl: widget.isMapMode ? currentQuestion.mapUrl : currentQuestion.flagUrl,
                            height: 130,
                            fit: BoxFit.contain,
                            cacheKey: currentQuestion.country,
                            countryName: currentQuestion.country,
                            placeholder: (context, url) => const Center(
                              child: SizedBox(
                                width: 28,
                                height: 28,
                                child: CircularProgressIndicator(strokeWidth: 2.5),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.isCapitalMode ? 'Select the CAPITAL of ${currentQuestion.country}:' : 'Which country does this flag belong to?',
                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: theme.text),
                        ),
                      ),
                      const SizedBox(width: 8),
                      SizedBox(
                        width: 95,
                        height: 42,
                        child: ElevatedButton(
                          onPressed: _useHint,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.cardBg,
                            foregroundColor: theme.text,
                            elevation: 2,
                            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: BorderSide(
                                color: hintsRemaining > 0 ? Colors.amberAccent : Colors.cyanAccent,
                                width: 1.2,
                              ),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    hintsRemaining > 0 ? Icons.lightbulb_rounded : Icons.ondemand_video_rounded,
                                    size: 14,
                                    color: hintsRemaining > 0 ? Colors.amberAccent : Colors.cyanAccent,
                                  ),
                                  const SizedBox(width: 3),
                                  Text(
                                    hintsRemaining > 0 ? 'Hint' : 'Watch Ad',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 11,
                                      color: hintsRemaining > 0 ? Colors.amberAccent : theme.text,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 1),
                              Text(
                                hintsRemaining > 0 ? '($hintsRemaining left)' : 'for +1 Hint',
                                style: TextStyle(
                                  fontSize: 9.5,
                                  color: hintsRemaining > 0 ? Colors.amber.shade300 : Colors.cyanAccent,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: currentOptions.length,
                      itemBuilder: (context, index) {
                        final option = currentOptions[index];
                        String titleStr = widget.isCapitalMode ? option.capital : option.country;
                        Color btnBg = theme.cardBg;

                        bool isEliminated = eliminatedOptions.contains(option);

                        if (selectedAnswer != null) {
                          if (option.country == currentQuestion.country) {
                            btnBg = Colors.green.shade800;
                          } else if (option == selectedAnswer) {
                            btnBg = Colors.red.shade800;
                          }
                        } else if (isEliminated) {
                          btnBg = theme.border.withValues(alpha: 0.2);
                        }

                        return GestureDetector(
                          onTap: isEliminated ? null : () => _handleOptionSelect(option),
                          child: Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(bottom: 8),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: btnBg,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: isEliminated ? Colors.transparent : theme.border.withValues(alpha: 0.3),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                titleStr,
                                style: TextStyle(
                                  color: isEliminated ? theme.text.withValues(alpha: 0.4) : theme.text,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  decoration: isEliminated ? TextDecoration.lineThrough : null,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          if (overlayStatusMessage != null)
            IgnorePointer(
              child: Center(
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 14),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: isHighPowerCombo
                            ? [Colors.deepOrange, Colors.amberAccent]
                            : overlayColor == Colors.redAccent
                            ? [Colors.red.shade900, Colors.redAccent]
                            : [Colors.green.shade900, Colors.greenAccent],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: overlayColor.withValues(alpha: 0.8),
                          blurRadius: 25,
                          spreadRadius: 4,
                        ),
                      ],
                    ),
                    child: Text(
                      overlayStatusMessage!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 22,
                        letterSpacing: 1.2,
                        shadows: [Shadow(color: Colors.black.withValues(alpha: 0.5), blurRadius: 8, offset: const Offset(2, 2))],
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
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