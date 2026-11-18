// ==========================================
// LEARNING SCREEN - Browse Flags & Country Details
// ==========================================
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'flag_data.dart';
import 'ad_helper.dart';

class LearningScreen extends StatefulWidget {
  const LearningScreen({super.key});

  @override
  State<LearningScreen> createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen> {
  String searchQuery = '';
  String selectedCategory = 'All';

  // 🔤 Sorting & Letter Filtering State
  bool isAscending = true; // true = A-Z, false = Z-A
  String? selectedLetter;  // e.g. 'U', 'A', null for all

  final List<String> categories = ['All', 'Africa', 'Europe', 'Asia', 'Muslim', 'UK'];
  final List<String> alphabet = List.generate(26, (i) => String.fromCharCode(65 + i));

  @override
  Widget build(BuildContext context) {
    final theme = ThemeColors.current;

    // Filter flags based on search query, category, and selected starting letter
    List<FlagItem> filteredFlags = FlagRepository.flags.where((flag) {
      final matchesSearch = flag.country.toLowerCase().contains(searchQuery.toLowerCase()) ||
          flag.capital.toLowerCase().contains(searchQuery.toLowerCase());

      if (!matchesSearch) return false;

      // Filter by starting letter if selected
      if (selectedLetter != null && !flag.country.toUpperCase().startsWith(selectedLetter!)) {
        return false;
      }

      if (selectedCategory == 'All') return true;
      if (flag.category == selectedCategory) return true;

      switch (selectedCategory) {
        case 'Africa':
          return flag.continent == 'Africa';
        case 'Europe':
          return flag.continent == 'Europe' || flag.continent.contains('Europe');
        case 'Asia':
          return flag.continent == 'Asia' || flag.continent.contains('Asia');
        case 'UK':
          return flag.category == 'UK' ||
              flag.country.contains('United Kingdom') ||
              flag.country.contains('England') ||
              flag.country.contains('Scotland') ||
              flag.country.contains('Wales') ||
              flag.country.contains('Northern Ireland') ||
              flag.country.contains('Isle of Man') ||
              flag.country.contains('Jersey') ||
              flag.country.contains('Guernsey') ||
              flag.country.contains('Gibraltar') ||
              flag.country.contains('Bermuda') ||
              flag.country.contains('Cayman') ||
              flag.country.contains('Falkland');
        case 'Muslim':
          return flag.category == 'Muslim' ||
              ['Algeria', 'Egypt', 'Indonesia', 'Iran', 'Iraq', 'Jordan', 'Kuwait', 'Lebanon', 'Malaysia', 'Maldives', 'Morocco', 'Oman', 'Pakistan', 'Palestine', 'Qatar', 'Saudi Arabia', 'Syria', 'Tunisia', 'Turkey', 'United Arab Emirates', 'Yemen', 'Afghanistan', 'Azerbaijan', 'Bahrain', 'Bangladesh', 'Brunei', 'Djibouti', 'Gambia', 'Guinea', 'Kazakhstan', 'Kyrgyzstan', 'Libya', 'Mali', 'Mauritania', 'Niger', 'Nigeria', 'Senegal', 'Sierra Leone', 'Somalia', 'Sudan', 'Tajikistan', 'Turkmenistan', 'Uzbekistan'].contains(flag.country);
        default:
          return false;
      }
    }).toList();

    // 🛡️ Remove duplicates based on country name so each country/flag appears only once!
    final seenCountries = <String>{};
    filteredFlags = filteredFlags.where((flag) => seenCountries.add(flag.country)).toList();

    // 🔀 Apply A-Z or Z-A Sorting
    filteredFlags.sort((a, b) {
      return isAscending
          ? a.country.compareTo(b.country)
          : b.country.compareTo(a.country);
    });

    return Scaffold(
      backgroundColor: theme.bgEnd,
      appBar: AppBar(
        backgroundColor: theme.cardBg,
        title: Text('Learning Hub', style: TextStyle(color: theme.text, fontWeight: FontWeight.bold)),
        iconTheme: IconThemeData(color: theme.primary),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Search, Sort & Alphabet Filter Header
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Search Bar with Sort Button
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        onChanged: (val) => setState(() => searchQuery = val),
                        style: TextStyle(color: theme.text),
                        decoration: InputDecoration(
                          hintText: 'Search country or capital...',
                          hintStyle: TextStyle(color: theme.text.withValues(alpha: 0.4)),
                          prefixIcon: Icon(Icons.search, color: theme.primary),
                          filled: true,
                          fillColor: theme.cardBg,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),

                    // 🔀 A-Z / Z-A Toggle Button
                    InkWell(
                      onTap: () => setState(() => isAscending = !isAscending),
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                        decoration: BoxDecoration(
                          color: theme.cardBg,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: theme.primary.withValues(alpha: 0.3)),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              isAscending ? Icons.sort_by_alpha : Icons.sort_by_alpha_outlined,
                              color: theme.primary,
                              size: 18,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              isAscending ? 'A-Z' : 'Z-A',
                              style: TextStyle(color: theme.primary, fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Category Filter Chips
                SizedBox(
                  height: 36,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final cat = categories[index];
                      final isSelected = selectedCategory == cat;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ChoiceChip(
                          label: Text(cat),
                          selected: isSelected,
                          onSelected: (selected) => setState(() => selectedCategory = cat),
                          selectedColor: theme.primary,
                          backgroundColor: theme.cardBg,
                          labelStyle: TextStyle(
                            color: isSelected ? Colors.white : theme.text,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 8),

                // 🔤 Alphabet A-Z Quick Filter Bar
                SizedBox(
                  height: 32,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      // Reset Letter Filter
                      Padding(
                        padding: const EdgeInsets.only(right: 6.0),
                        child: ChoiceChip(
                          label: const Text('ALL'),
                          selected: selectedLetter == null,
                          onSelected: (_) => setState(() => selectedLetter = null),
                          selectedColor: theme.primary.withValues(alpha: 0.8),
                          backgroundColor: theme.cardBg,
                          labelStyle: TextStyle(
                            color: selectedLetter == null ? Colors.white : theme.text.withValues(alpha: 0.7),
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                        ),
                      ),
                      // Letters A to Z
                      ...alphabet.map((letter) {
                        final isSelected = selectedLetter == letter;
                        return Padding(
                          padding: const EdgeInsets.only(right: 6.0),
                          child: ChoiceChip(
                            label: Text(letter),
                            selected: isSelected,
                            onSelected: (selected) {
                              setState(() {
                                selectedLetter = selected ? letter : null;
                              });
                            },
                            selectedColor: theme.primary,
                            backgroundColor: theme.cardBg,
                            labelStyle: TextStyle(
                              color: isSelected ? Colors.white : theme.text,
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Responsive Grid View
          Expanded(
            child: filteredFlags.isEmpty
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.search_off, size: 50, color: Colors.grey),
                  const SizedBox(height: 8),
                  Text('No countries found', style: TextStyle(color: theme.text, fontWeight: FontWeight.bold)),
                ],
              ),
            )
                : LayoutBuilder(
              builder: (context, constraints) {
                int crossAxisCount = constraints.maxWidth > 900 ? 6 : (constraints.maxWidth > 600 ? 4 : 3);

                return GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.82,
                  ),
                  itemCount: filteredFlags.length,
                  itemBuilder: (context, index) {
                    final flag = filteredFlags[index];
                    final tagText = flag.category == 'All'
                        ? (flag.continent.isEmpty ? 'Global' : flag.continent)
                        : flag.category;

                    return Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: theme.cardBg,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: theme.border.withValues(alpha: 0.3)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: Container(
                                  width: 72,
                                  height: 48,
                                  color: Colors.black12,
                                  child: CachedNetworkImage(
                                    imageUrl: flag.flagUrl,
                                    fit: BoxFit.cover,
                                    cacheKey: flag.country,
                                    placeholder: (context, url) => const Center(
                                      child: SizedBox(
                                        width: 14,
                                        height: 14,
                                        child: CircularProgressIndicator(strokeWidth: 2),
                                      ),
                                    ),
                                    errorWidget: (context, url, error) => const Icon(Icons.broken_image, size: 18, color: Colors.grey),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),

                          // Country Name
                          Text(
                            flag.country,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: theme.text, fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                          const SizedBox(height: 2),

                          // Capital Name
                          Text(
                            flag.capital,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: theme.primary, fontWeight: FontWeight.w600, fontSize: 10),
                          ),
                          const SizedBox(height: 6),

                          // Bottom Centered Region Badge
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            decoration: BoxDecoration(
                              color: theme.primary.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              tagText,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: theme.primary, fontSize: 9, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
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