import 'package:flutter/material.dart';

enum GameDifficulty { easy, medium, hard, progressive }
enum AppThemeMode { ice, fire, cyber, cream }

// ==========================================
// GAME SETTINGS DATA
// ==========================================
class GameSettings {
  static bool soundEffects = true;
  static bool bgmEnabled = true;
  static bool enableShake = true;
  static String selectedTheme = 'Dark';

  static double bgmVolume = 0.25; // Default 25%
  static double sfxVolume = 0.80; // Default 80%
// 👤 Player Profile Name
  static String playerName = 'Player 1';
}

class ThemeColors {
  static String activeTheme = 'Dark';

  final Color bgStart;
  final Color bgEnd;
  final Color cardBg;
  final Color primary;
  final Color text;
  final Color border;

  ThemeColors({
    required this.bgStart,
    required this.bgEnd,
    required this.cardBg,
    required this.primary,
    required this.text,
    required this.border,
  });

  static ThemeColors get current {
    switch (activeTheme) {
      case 'Light':
        return ThemeColors(
          bgStart: const Color(0xFFF1F5F9),
          bgEnd: const Color(0xFFE2E8F0),
          cardBg: const Color(0xFFFFFFFF),
          primary: const Color(0xFF2563EB),
          text: const Color(0xFF0F172A),
          border: const Color(0xFFCBD5E1),
        );
      case 'Neon Cyber':
        return ThemeColors(
          bgStart: const Color(0xFF0D0221),
          bgEnd: const Color(0xFF0F0826),
          cardBg: const Color(0xFF190E38),
          primary: const Color(0xFFFF007F),
          text: const Color(0xFF00F5FF),
          border: const Color(0xFFFF007F),
        );
      case 'Sunset':
        return ThemeColors(
          bgStart: const Color(0xFF2D0B32),
          bgEnd: const Color(0xFF19061C),
          cardBg: const Color(0xFF4A154B),
          primary: const Color(0xFFFF6B6B),
          text: const Color(0xFFFFD166),
          border: const Color(0xFFFF6B6B),
        );
      case 'Dark':
      default:
        return ThemeColors(
          bgStart: const Color(0xFF0F172A),
          bgEnd: const Color(0xFF020617),
          cardBg: const Color(0xFF1E293B),
          primary: const Color(0xFF38BDF8),
          text: const Color(0xFFF8FAFC),
          border: const Color(0xFF334155),
        );
    }
  }
}

class FlagItem {
  final String country;
  final String capital;
  final String flagUrl;
  final String mapUrl;
  final String category;
  final GameDifficulty difficulty;

  // Extended Country Facts
  final String officialName;
  final String continent;
  final String population;
  final String totalArea;
  final String isoCode;
  final String dialCode;
  final String fact;

  const FlagItem({
    required this.country,
    required this.capital,
    required this.flagUrl,
    required this.mapUrl,
    required this.category,
    this.difficulty = GameDifficulty.easy,
    this.officialName = '',
    this.continent = 'Global',
    this.population = 'N/A',
    this.totalArea = 'N/A',
    this.isoCode = '',
    this.dialCode = '',
    this.fact = '',
  });
}

class FlagRepository {
  static const List<FlagItem> flags = [
    // --- A ---
    FlagItem(
        country: 'Afghanistan', capital: 'Kabul',
        flagUrl: 'https://flagcdn.com/w320/af.png', mapUrl: 'https://flagcdn.com/w320/af.png',
        category: 'All', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Albania', capital: 'Tirana',
        flagUrl: 'https://flagcdn.com/w320/al.png', mapUrl: 'https://flagcdn.com/w320/al.png',
        category: 'All', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Algeria', capital: 'Algiers',
        flagUrl: 'https://flagcdn.com/w320/dz.png', mapUrl: 'https://flagcdn.com/w320/dz.png',
        category: 'All', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Andorra', capital: 'Andorra la Vella',
        flagUrl: 'https://flagcdn.com/w320/ad.png', mapUrl: 'https://flagcdn.com/w320/ad.png',
        category: 'All', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Angola', capital: 'Luanda',
        flagUrl: 'https://flagcdn.com/w320/ao.png', mapUrl: 'https://flagcdn.com/w320/ao.png',
        category: 'All', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Argentina', capital: 'Buenos Aires',
        flagUrl: 'https://flagcdn.com/w320/ar.png', mapUrl: 'https://flagcdn.com/w320/ar.png',
        category: 'All', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Armenia', capital: 'Yerevan',
        flagUrl: 'https://flagcdn.com/w320/am.png', mapUrl: 'https://flagcdn.com/w320/am.png',
        category: 'All', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Australia', capital: 'Canberra',
        flagUrl: 'https://flagcdn.com/w320/au.png', mapUrl: 'https://flagcdn.com/w320/au.png',
        category: 'All', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Austria', capital: 'Vienna',
        flagUrl: 'https://flagcdn.com/w320/at.png', mapUrl: 'https://flagcdn.com/w320/at.png',
        category: 'All', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Azerbaijan', capital: 'Baku',
        flagUrl: 'https://flagcdn.com/w320/az.png', mapUrl: 'https://flagcdn.com/w320/az.png',
        category: 'All', difficulty: GameDifficulty.medium
    ),

    // --- B ---
    FlagItem(
        country: 'Bahrain', capital: 'Manama',
        flagUrl: 'https://flagcdn.com/w320/bh.png', mapUrl: 'https://flagcdn.com/w320/bh.png',
        category: 'All', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Bangladesh', capital: 'Dhaka',
        flagUrl: 'https://flagcdn.com/w320/bd.png', mapUrl: 'https://flagcdn.com/w320/bd.png',
        category: 'All', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Belarus', capital: 'Minsk',
        flagUrl: 'https://flagcdn.com/w320/by.png', mapUrl: 'https://flagcdn.com/w320/by.png',
        category: 'All', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Belgium', capital: 'Brussels',
        flagUrl: 'https://flagcdn.com/w320/be.png', mapUrl: 'https://flagcdn.com/w320/be.png',
        category: 'All', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Benin', capital: 'Porto-Novo',
        flagUrl: 'https://flagcdn.com/w320/bj.png', mapUrl: 'https://flagcdn.com/w320/bj.png',
        category: 'All', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Bermuda', capital: 'Hamilton',
        flagUrl: 'https://flagcdn.com/w320/bm.png', mapUrl: 'https://flagcdn.com/w320/bm.png',
        category: 'All', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Bhutan', capital: 'Thimphu',
        flagUrl: 'https://flagcdn.com/w320/bt.png', mapUrl: 'https://flagcdn.com/w320/bt.png',
        category: 'All', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Bosnia and Herzegovina', capital: 'Sarajevo',
        flagUrl: 'https://flagcdn.com/w320/ba.png', mapUrl: 'https://flagcdn.com/w320/ba.png',
        category: 'All', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Botswana', capital: 'Gaborone',
        flagUrl: 'https://flagcdn.com/w320/bw.png', mapUrl: 'https://flagcdn.com/w320/bw.png',
        category: 'All', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Brazil', capital: 'Brasília',
        flagUrl: 'https://flagcdn.com/w320/br.png', mapUrl: 'https://flagcdn.com/w320/br.png',
        category: 'All', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Brunei', capital: 'Bandar Seri Begawan',
        flagUrl: 'https://flagcdn.com/w320/bn.png', mapUrl: 'https://flagcdn.com/w320/bn.png',
        category: 'All', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Bulgaria', capital: 'Sofia',
        flagUrl: 'https://flagcdn.com/w320/bg.png', mapUrl: 'https://flagcdn.com/w320/bg.png',
        category: 'All', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Burkina Faso', capital: 'Ouagadougou',
        flagUrl: 'https://flagcdn.com/w320/bf.png', mapUrl: 'https://flagcdn.com/w320/bf.png',
        category: 'All', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Burundi', capital: 'Gitega',
        flagUrl: 'https://flagcdn.com/w320/bi.png', mapUrl: 'https://flagcdn.com/w320/bi.png',
        category: 'All', difficulty: GameDifficulty.hard
    ),

    // --- C ---
    FlagItem(
        country: 'Cambodia', capital: 'Phnom Penh',
        flagUrl: 'https://flagcdn.com/w320/kh.png', mapUrl: 'https://flagcdn.com/w320/kh.png',
        category: 'All', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Cameroon', capital: 'Yaoundé',
        flagUrl: 'https://flagcdn.com/w320/cm.png', mapUrl: 'https://flagcdn.com/w320/cm.png',
        category: 'All', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Canada', capital: 'Ottawa',
        flagUrl: 'https://flagcdn.com/w320/ca.png', mapUrl: 'https://flagcdn.com/w320/ca.png',
        category: 'All', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Cape Verde', capital: 'Praia',
        flagUrl: 'https://flagcdn.com/w320/cv.png', mapUrl: 'https://flagcdn.com/w320/cv.png',
        category: 'All', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Cayman Islands', capital: 'George Town',
        flagUrl: 'https://flagcdn.com/w320/ky.png', mapUrl: 'https://flagcdn.com/w320/ky.png',
        category: 'All', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Central African Republic', capital: 'Bangui',
        flagUrl: 'https://flagcdn.com/w320/cf.png', mapUrl: 'https://flagcdn.com/w320/cf.png',
        category: 'All', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Chad', capital: 'N\'Djamena',
        flagUrl: 'https://flagcdn.com/w320/td.png', mapUrl: 'https://flagcdn.com/w320/td.png',
        category: 'All', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Chile', capital: 'Santiago',
        flagUrl: 'https://flagcdn.com/w320/cl.png', mapUrl: 'https://flagcdn.com/w320/cl.png',
        category: 'All', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'China', capital: 'Beijing',
        flagUrl: 'https://flagcdn.com/w320/cn.png', mapUrl: 'https://flagcdn.com/w320/cn.png',
        category: 'All', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Colombia', capital: 'Bogotá',
        flagUrl: 'https://flagcdn.com/w320/co.png', mapUrl: 'https://flagcdn.com/w320/co.png',
        category: 'All', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Comoros', capital: 'Moroni',
        flagUrl: 'https://flagcdn.com/w320/km.png', mapUrl: 'https://flagcdn.com/w320/km.png',
        category: 'All', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Costa Rica', capital: 'San José',
        flagUrl: 'https://flagcdn.com/w320/cr.png', mapUrl: 'https://flagcdn.com/w320/cr.png',
        category: 'All', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Croatia', capital: 'Zagreb',
        flagUrl: 'https://flagcdn.com/w320/hr.png', mapUrl: 'https://flagcdn.com/w320/hr.png',
        category: 'All', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Cuba', capital: 'Havana',
        flagUrl: 'https://flagcdn.com/w320/cu.png', mapUrl: 'https://flagcdn.com/w320/cu.png',
        category: 'All', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Cyprus', capital: 'Nicosia',
        flagUrl: 'https://flagcdn.com/w320/cy.png', mapUrl: 'https://flagcdn.com/w320/cy.png',
        category: 'All', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Czech Republic', capital: 'Prague',
        flagUrl: 'https://flagcdn.com/w320/cz.png', mapUrl: 'https://flagcdn.com/w320/cz.png',
        category: 'All', difficulty: GameDifficulty.medium
    ),

    // --- D ---
    FlagItem(
        country: 'Democratic Republic of the Congo', capital: 'Kinshasa',
        flagUrl: 'https://flagcdn.com/w320/cd.png', mapUrl: 'https://flagcdn.com/w320/cd.png',
        category: 'All', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Denmark', capital: 'Copenhagen',
        flagUrl: 'https://flagcdn.com/w320/dk.png', mapUrl: 'https://flagcdn.com/w320/dk.png',
        category: 'All', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Djibouti', capital: 'Djibouti',
        flagUrl: 'https://flagcdn.com/w320/dj.png', mapUrl: 'https://flagcdn.com/w320/dj.png',
        category: 'All', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Dominica', capital: 'Roseau',
        flagUrl: 'https://flagcdn.com/w320/dm.png', mapUrl: 'https://flagcdn.com/w320/dm.png',
        category: 'All', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Dominican Republic', capital: 'Santo Domingo',
        flagUrl: 'https://flagcdn.com/w320/do.png', mapUrl: 'https://flagcdn.com/w320/do.png',
        category: 'All', difficulty: GameDifficulty.medium
    ),

    // --- E ---
    FlagItem(
        country: 'Ecuador', capital: 'Quito',
        flagUrl: 'https://flagcdn.com/w320/ec.png', mapUrl: 'https://flagcdn.com/w320/ec.png',
        category: 'All', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Egypt', capital: 'Cairo',
        flagUrl: 'https://flagcdn.com/w320/eg.png', mapUrl: 'https://flagcdn.com/w320/eg.png',
        category: 'All', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'El Salvador', capital: 'San Salvador',
        flagUrl: 'https://flagcdn.com/w320/sv.png', mapUrl: 'https://flagcdn.com/w320/sv.png',
        category: 'All', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'England', capital: 'London',
        flagUrl: 'https://flagcdn.com/w320/gb-eng.png', mapUrl: 'https://flagcdn.com/w320/gb-eng.png',
        category: 'All', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Equatorial Guinea', capital: 'Malabo',
        flagUrl: 'https://flagcdn.com/w320/gq.png', mapUrl: 'https://flagcdn.com/w320/gq.png',
        category: 'All', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Eritrea', capital: 'Asmara',
        flagUrl: 'https://flagcdn.com/w320/er.png', mapUrl: 'https://flagcdn.com/w320/er.png',
        category: 'All', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Estonia', capital: 'Tallinn',
        flagUrl: 'https://flagcdn.com/w320/ee.png', mapUrl: 'https://flagcdn.com/w320/ee.png',
        category: 'All', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Eswatini', capital: 'Mbabane',
        flagUrl: 'https://flagcdn.com/w320/sz.png', mapUrl: 'https://flagcdn.com/w320/sz.png',
        category: 'All', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Ethiopia', capital: 'Addis Ababa',
        flagUrl: 'https://flagcdn.com/w320/et.png', mapUrl: 'https://flagcdn.com/w320/et.png',
        category: 'All', difficulty: GameDifficulty.easy
    ),

    // --- F ---
    FlagItem(
        country: 'Falkland Islands', capital: 'Stanley',
        flagUrl: 'https://flagcdn.com/w320/fk.png', mapUrl: 'https://flagcdn.com/w320/fk.png',
        category: 'All', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Fiji', capital: 'Suva',
        flagUrl: 'https://flagcdn.com/w320/fj.png', mapUrl: 'https://flagcdn.com/w320/fj.png',
        category: 'All', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Finland', capital: 'Helsinki',
        flagUrl: 'https://flagcdn.com/w320/fi.png', mapUrl: 'https://flagcdn.com/w320/fi.png',
        category: 'All', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'France', capital: 'Paris',
        flagUrl: 'https://flagcdn.com/w320/fr.png', mapUrl: 'https://flagcdn.com/w320/fr.png',
        category: 'All', difficulty: GameDifficulty.easy
    ),

    // --- G ---
    FlagItem(
        country: 'Gabon', capital: 'Libreville',
        flagUrl: 'https://flagcdn.com/w320/ga.png', mapUrl: 'https://flagcdn.com/w320/ga.png',
        category: 'All', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Gambia', capital: 'Banjul',
        flagUrl: 'https://flagcdn.com/w320/gm.png', mapUrl: 'https://flagcdn.com/w320/gm.png',
        category: 'All', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Georgia', capital: 'Tbilisi',
        flagUrl: 'https://flagcdn.com/w320/ge.png', mapUrl: 'https://flagcdn.com/w320/ge.png',
        category: 'All', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Germany', capital: 'Berlin',
        flagUrl: 'https://flagcdn.com/w320/de.png', mapUrl: 'https://flagcdn.com/w320/de.png',
        category: 'All', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Ghana', capital: 'Accra',
        flagUrl: 'https://flagcdn.com/w320/gh.png', mapUrl: 'https://flagcdn.com/w320/gh.png',
        category: 'All', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Gibraltar', capital: 'Gibraltar',
        flagUrl: 'https://flagcdn.com/w320/gi.png', mapUrl: 'https://flagcdn.com/w320/gi.png',
        category: 'All', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Greece', capital: 'Athens',
        flagUrl: 'https://flagcdn.com/w320/gr.png', mapUrl: 'https://flagcdn.com/w320/gr.png',
        category: 'All', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Guatemala', capital: 'Guatemala City',
        flagUrl: 'https://flagcdn.com/w320/gt.png', mapUrl: 'https://flagcdn.com/w320/gt.png',
        category: 'All', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Guernsey', capital: 'Saint Peter Port',
        flagUrl: 'https://flagcdn.com/w320/gg.png', mapUrl: 'https://flagcdn.com/w320/gg.png',
        category: 'All', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Guinea', capital: 'Conakry',
        flagUrl: 'https://flagcdn.com/w320/gn.png', mapUrl: 'https://flagcdn.com/w320/gn.png',
        category: 'All', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Guinea-Bissau', capital: 'Bissau',
        flagUrl: 'https://flagcdn.com/w320/gw.png', mapUrl: 'https://flagcdn.com/w320/gw.png',
        category: 'All', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Guyana', capital: 'Georgetown',
        flagUrl: 'https://flagcdn.com/w320/gy.png', mapUrl: 'https://flagcdn.com/w320/gy.png',
        category: 'All', difficulty: GameDifficulty.medium
    ),

    // --- H ---
    FlagItem(
        country: 'Haiti', capital: 'Port-au-Prince',
        flagUrl: 'https://flagcdn.com/w320/ht.png', mapUrl: 'https://flagcdn.com/w320/ht.png',
        category: 'All', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Honduras', capital: 'Tegucigalpa',
        flagUrl: 'https://flagcdn.com/w320/hn.png', mapUrl: 'https://flagcdn.com/w320/hn.png',
        category: 'All', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Hungary', capital: 'Budapest',
        flagUrl: 'https://flagcdn.com/w320/hu.png', mapUrl: 'https://flagcdn.com/w320/hu.png',
        category: 'All', difficulty: GameDifficulty.medium
    ),

    // --- I ---
    FlagItem(
        country: 'Iceland', capital: 'Reykjavik',
        flagUrl: 'https://flagcdn.com/w320/is.png', mapUrl: 'https://flagcdn.com/w320/is.png',
        category: 'All', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'India', capital: 'New Delhi',
        flagUrl: 'https://flagcdn.com/w320/in.png', mapUrl: 'https://flagcdn.com/w320/in.png',
        category: 'All', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Indonesia', capital: 'Jakarta',
        flagUrl: 'https://flagcdn.com/w320/id.png', mapUrl: 'https://flagcdn.com/w320/id.png',
        category: 'All', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Iran', capital: 'Tehran',
        flagUrl: 'https://flagcdn.com/w320/ir.png', mapUrl: 'https://flagcdn.com/w320/ir.png',
        category: 'All', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Iraq', capital: 'Baghdad',
        flagUrl: 'https://flagcdn.com/w320/iq.png', mapUrl: 'https://flagcdn.com/w320/iq.png',
        category: 'All', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Ireland', capital: 'Dublin',
        flagUrl: 'https://flagcdn.com/w320/ie.png', mapUrl: 'https://flagcdn.com/w320/ie.png',
        category: 'All', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Isle of Man', capital: 'Douglas',
        flagUrl: 'https://flagcdn.com/w320/im.png', mapUrl: 'https://flagcdn.com/w320/im.png',
        category: 'All', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Israel', capital: 'Jerusalem',
        flagUrl: 'https://flagcdn.com/w320/il.png', mapUrl: 'https://flagcdn.com/w320/il.png',
        category: 'All', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Italy', capital: 'Rome',
        flagUrl: 'https://flagcdn.com/w320/it.png', mapUrl: 'https://flagcdn.com/w320/it.png',
        category: 'All', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Ivory Coast', capital: 'Yamoussoukro',
        flagUrl: 'https://flagcdn.com/w320/ci.png', mapUrl: 'https://flagcdn.com/w320/ci.png',
        category: 'All', difficulty: GameDifficulty.medium
    ),

    // --- J ---
    FlagItem(
        country: 'Jamaica', capital: 'Kingston',
        flagUrl: 'https://flagcdn.com/w320/jm.png', mapUrl: 'https://flagcdn.com/w320/jm.png',
        category: 'All', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Japan', capital: 'Tokyo',
        flagUrl: 'https://flagcdn.com/w320/jp.png', mapUrl: 'https://flagcdn.com/w320/jp.png',
        category: 'All', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Jersey', capital: 'Saint Helier',
        flagUrl: 'https://flagcdn.com/w320/je.png', mapUrl: 'https://flagcdn.com/w320/je.png',
        category: 'All', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Jordan', capital: 'Amman',
        flagUrl: 'https://flagcdn.com/w320/jo.png', mapUrl: 'https://flagcdn.com/w320/jo.png',
        category: 'All', difficulty: GameDifficulty.medium
    ),

    // --- K ---
    FlagItem(
        country: 'Kazakhstan', capital: 'Astana',
        flagUrl: 'https://flagcdn.com/w320/kz.png', mapUrl: 'https://flagcdn.com/w320/kz.png',
        category: 'All', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Kenya', capital: 'Nairobi',
        flagUrl: 'https://flagcdn.com/w320/ke.png', mapUrl: 'https://flagcdn.com/w320/ke.png',
        category: 'All', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Kiribati', capital: 'Tarawa Atoll',
        flagUrl: 'https://flagcdn.com/w320/ki.png', mapUrl: 'https://flagcdn.com/w320/ki.png',
        category: 'All', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Kosovo', capital: 'Pristina',
        flagUrl: 'https://flagcdn.com/w320/xk.png', mapUrl: 'https://flagcdn.com/w320/xk.png',
        category: 'All', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Kuwait', capital: 'Kuwait City',
        flagUrl: 'https://flagcdn.com/w320/kw.png', mapUrl: 'https://flagcdn.com/w320/kw.png',
        category: 'All', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Kyrgyzstan', capital: 'Bishkek',
        flagUrl: 'https://flagcdn.com/w320/kg.png', mapUrl: 'https://flagcdn.com/w320/kg.png',
        category: 'All', difficulty: GameDifficulty.hard
    ),

    // --- L ---
    FlagItem(
        country: 'Laos', capital: 'Vientiane',
        flagUrl: 'https://flagcdn.com/w320/la.png', mapUrl: 'https://flagcdn.com/w320/la.png',
        category: 'All', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Latvia', capital: 'Riga',
        flagUrl: 'https://flagcdn.com/w320/lv.png', mapUrl: 'https://flagcdn.com/w320/lv.png',
        category: 'All', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Lebanon', capital: 'Beirut',
        flagUrl: 'https://flagcdn.com/w320/lb.png', mapUrl: 'https://flagcdn.com/w320/lb.png',
        category: 'All', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Lesotho', capital: 'Maseru',
        flagUrl: 'https://flagcdn.com/w320/ls.png', mapUrl: 'https://flagcdn.com/w320/ls.png',
        category: 'All', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Liberia', capital: 'Monrovia',
        flagUrl: 'https://flagcdn.com/w320/lr.png', mapUrl: 'https://flagcdn.com/w320/lr.png',
        category: 'All', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Libya', capital: 'Tripoli',
        flagUrl: 'https://flagcdn.com/w320/ly.png', mapUrl: 'https://flagcdn.com/w320/ly.png',
        category: 'All', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Liechtenstein', capital: 'Vaduz',
        flagUrl: 'https://flagcdn.com/w320/li.png', mapUrl: 'https://flagcdn.com/w320/li.png',
        category: 'All', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Lithuania', capital: 'Vilnius',
        flagUrl: 'https://flagcdn.com/w320/lt.png', mapUrl: 'https://flagcdn.com/w320/lt.png',
        category: 'All', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Luxembourg', capital: 'Luxembourg',
        flagUrl: 'https://flagcdn.com/w320/lu.png', mapUrl: 'https://flagcdn.com/w320/lu.png',
        category: 'All', difficulty: GameDifficulty.medium
    ),

    // --- M ---
    FlagItem(
        country: 'Madagascar', capital: 'Antananarivo',
        flagUrl: 'https://flagcdn.com/w320/mg.png', mapUrl: 'https://flagcdn.com/w320/mg.png',
        category: 'All', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Malawi', capital: 'Lilongwe',
        flagUrl: 'https://flagcdn.com/w320/mw.png', mapUrl: 'https://flagcdn.com/w320/mw.png',
        category: 'All', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Malaysia', capital: 'Kuala Lumpur',
        flagUrl: 'https://flagcdn.com/w320/my.png', mapUrl: 'https://flagcdn.com/w320/my.png',
        category: 'All', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Maldives', capital: 'Malé',
        flagUrl: 'https://flagcdn.com/w320/mv.png', mapUrl: 'https://flagcdn.com/w320/mv.png',
        category: 'All', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Mali', capital: 'Bamako',
        flagUrl: 'https://flagcdn.com/w320/ml.png', mapUrl: 'https://flagcdn.com/w320/ml.png',
        category: 'All', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Malta', capital: 'Valletta',
        flagUrl: 'https://flagcdn.com/w320/mt.png', mapUrl: 'https://flagcdn.com/w320/mt.png',
        category: 'All', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Marshall Islands', capital: 'Majuro',
        flagUrl: 'https://flagcdn.com/w320/mh.png', mapUrl: 'https://flagcdn.com/w320/mh.png',
        category: 'All', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Mauritania', capital: 'Nouakchott',
        flagUrl: 'https://flagcdn.com/w320/mr.png', mapUrl: 'https://flagcdn.com/w320/mr.png',
        category: 'All', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Mauritius', capital: 'Port Louis',
        flagUrl: 'https://flagcdn.com/w320/mu.png', mapUrl: 'https://flagcdn.com/w320/mu.png',
        category: 'All', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Mexico', capital: 'Mexico City',
        flagUrl: 'https://flagcdn.com/w320/mx.png', mapUrl: 'https://flagcdn.com/w320/mx.png',
        category: 'All', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Micronesia', capital: 'Palikir',
        flagUrl: 'https://flagcdn.com/w320/fm.png', mapUrl: 'https://flagcdn.com/w320/fm.png',
        category: 'All', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Moldova', capital: 'Chisinau',
        flagUrl: 'https://flagcdn.com/w320/md.png', mapUrl: 'https://flagcdn.com/w320/md.png',
        category: 'All', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Monaco', capital: 'Monaco',
        flagUrl: 'https://flagcdn.com/w320/mc.png', mapUrl: 'https://flagcdn.com/w320/mc.png',
        category: 'All', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Mongolia', capital: 'Ulaanbaatar',
        flagUrl: 'https://flagcdn.com/w320/mn.png', mapUrl: 'https://flagcdn.com/w320/mn.png',
        category: 'All', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Montenegro', capital: 'Podgorica',
        flagUrl: 'https://flagcdn.com/w320/me.png', mapUrl: 'https://flagcdn.com/w320/me.png',
        category: 'All', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Morocco', capital: 'Rabat',
        flagUrl: 'https://flagcdn.com/w320/ma.png', mapUrl: 'https://flagcdn.com/w320/ma.png',
        category: 'All', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Mozambique', capital: 'Maputo',
        flagUrl: 'https://flagcdn.com/w320/mz.png', mapUrl: 'https://flagcdn.com/w320/mz.png',
        category: 'All', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Myanmar', capital: 'Naypyidaw',
        flagUrl: 'https://flagcdn.com/w320/mm.png', mapUrl: 'https://flagcdn.com/w320/mm.png',
        category: 'All', difficulty: GameDifficulty.medium
    ),

    // --- N ---
    FlagItem(
        country: 'Namibia', capital: 'Windhoek',
        flagUrl: 'https://flagcdn.com/w320/na.png', mapUrl: 'https://flagcdn.com/w320/na.png',
        category: 'All', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Nauru', capital: 'Yaren District',
        flagUrl: 'https://flagcdn.com/w320/nr.png', mapUrl: 'https://flagcdn.com/w320/nr.png',
        category: 'All', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Nepal', capital: 'Kathmandu',
        flagUrl: 'https://flagcdn.com/w320/np.png', mapUrl: 'https://flagcdn.com/w320/np.png',
        category: 'All', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Netherlands', capital: 'Amsterdam',
        flagUrl: 'https://flagcdn.com/w320/nl.png', mapUrl: 'https://flagcdn.com/w320/nl.png',
        category: 'All', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'New Zealand', capital: 'Wellington',
        flagUrl: 'https://flagcdn.com/w320/nz.png', mapUrl: 'https://flagcdn.com/w320/nz.png',
        category: 'All', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Nicaragua', capital: 'Managua',
        flagUrl: 'https://flagcdn.com/w320/ni.png', mapUrl: 'https://flagcdn.com/w320/ni.png',
        category: 'All', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Niger', capital: 'Niamey',
        flagUrl: 'https://flagcdn.com/w320/ne.png', mapUrl: 'https://flagcdn.com/w320/ne.png',
        category: 'All', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Nigeria', capital: 'Abuja',
        flagUrl: 'https://flagcdn.com/w320/ng.png', mapUrl: 'https://flagcdn.com/w320/ng.png',
        category: 'All', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'North Korea', capital: 'Pyongyang',
        flagUrl: 'https://flagcdn.com/w320/kp.png', mapUrl: 'https://flagcdn.com/w320/kp.png',
        category: 'All', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'North Macedonia', capital: 'Skopje',
        flagUrl: 'https://flagcdn.com/w320/mk.png', mapUrl: 'https://flagcdn.com/w320/mk.png',
        category: 'All', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Northern Ireland', capital: 'Belfast',
        flagUrl: 'https://flagcdn.com/w320/gb-nir.png', mapUrl: 'https://flagcdn.com/w320/gb-nir.png',
        category: 'All', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Norway', capital: 'Oslo',
        flagUrl: 'https://flagcdn.com/w320/no.png', mapUrl: 'https://flagcdn.com/w320/no.png',
        category: 'All', difficulty: GameDifficulty.easy
    ),

    // --- O ---
    FlagItem(
        country: 'Oman', capital: 'Muscat',
        flagUrl: 'https://flagcdn.com/w320/om.png', mapUrl: 'https://flagcdn.com/w320/om.png',
        category: 'All', difficulty: GameDifficulty.medium
    ),

    // --- P ---
    FlagItem(
        country: 'Pakistan', capital: 'Islamabad',
        flagUrl: 'https://flagcdn.com/w320/pk.png', mapUrl: 'https://flagcdn.com/w320/pk.png',
        category: 'All', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Palau', capital: 'Ngerulmud',
        flagUrl: 'https://flagcdn.com/w320/pw.png', mapUrl: 'https://flagcdn.com/w320/pw.png',
        category: 'All', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Palestine', capital: 'Jerusalem',
        flagUrl: 'https://flagcdn.com/w320/ps.png', mapUrl: 'https://flagcdn.com/w320/ps.png',
        category: 'All', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Panama', capital: 'Panama City',
        flagUrl: 'https://flagcdn.com/w320/pa.png', mapUrl: 'https://flagcdn.com/w320/pa.png',
        category: 'All', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Papua New Guinea', capital: 'Port Moresby',
        flagUrl: 'https://flagcdn.com/w320/pg.png', mapUrl: 'https://flagcdn.com/w320/pg.png',
        category: 'All', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Paraguay', capital: 'Asunción',
        flagUrl: 'https://flagcdn.com/w320/py.png', mapUrl: 'https://flagcdn.com/w320/py.png',
        category: 'All', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Peru', capital: 'Lima',
        flagUrl: 'https://flagcdn.com/w320/pe.png', mapUrl: 'https://flagcdn.com/w320/pe.png',
        category: 'All', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Philippines', capital: 'Manila',
        flagUrl: 'https://flagcdn.com/w320/ph.png', mapUrl: 'https://flagcdn.com/w320/ph.png',
        category: 'All', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Poland', capital: 'Warsaw',
        flagUrl: 'https://flagcdn.com/w320/pl.png', mapUrl: 'https://flagcdn.com/w320/pl.png',
        category: 'All', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Portugal', capital: 'Lisbon',
        flagUrl: 'https://flagcdn.com/w320/pt.png', mapUrl: 'https://flagcdn.com/w320/pt.png',
        category: 'All', difficulty: GameDifficulty.easy
    ),

    // --- Q ---
    FlagItem(
        country: 'Qatar', capital: 'Doha',
        flagUrl: 'https://flagcdn.com/w320/qa.png', mapUrl: 'https://flagcdn.com/w320/qa.png',
        category: 'All', difficulty: GameDifficulty.easy
    ),

    // --- R ---
    FlagItem(
        country: 'Romania', capital: 'Bucharest',
        flagUrl: 'https://flagcdn.com/w320/ro.png', mapUrl: 'https://flagcdn.com/w320/ro.png',
        category: 'All', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Russia', capital: 'Moscow',
        flagUrl: 'https://flagcdn.com/w320/ru.png', mapUrl: 'https://flagcdn.com/w320/ru.png',
        category: 'All', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Rwanda', capital: 'Kigali',
        flagUrl: 'https://flagcdn.com/w320/rw.png', mapUrl: 'https://flagcdn.com/w320/rw.png',
        category: 'All', difficulty: GameDifficulty.hard
    ),

    // --- S ---
    FlagItem(
        country: 'Saint Kitts and Nevis', capital: 'Basseterre',
        flagUrl: 'https://flagcdn.com/w320/kn.png', mapUrl: 'https://flagcdn.com/w320/kn.png',
        category: 'All', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Saint Lucia', capital: 'Castries',
        flagUrl: 'https://flagcdn.com/w320/lc.png', mapUrl: 'https://flagcdn.com/w320/lc.png',
        category: 'All', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Saint Vincent and the Grenadines', capital: 'Kingstown',
        flagUrl: 'https://flagcdn.com/w320/vc.png', mapUrl: 'https://flagcdn.com/w320/vc.png',
        category: 'All', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Samoa', capital: 'Apia',
        flagUrl: 'https://flagcdn.com/w320/ws.png', mapUrl: 'https://flagcdn.com/w320/ws.png',
        category: 'All', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'San Marino', capital: 'San Marino',
        flagUrl: 'https://flagcdn.com/w320/sm.png', mapUrl: 'https://flagcdn.com/w320/sm.png',
        category: 'All', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'São Tomé and Príncipe', capital: 'São Tomé',
        flagUrl: 'https://flagcdn.com/w320/st.png', mapUrl: 'https://flagcdn.com/w320/st.png',
        category: 'All', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Saudi Arabia', capital: 'Riyadh',
        flagUrl: 'https://flagcdn.com/w320/sa.png', mapUrl: 'https://flagcdn.com/w320/sa.png',
        category: 'All', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Scotland', capital: 'Edinburgh',
        flagUrl: 'https://flagcdn.com/w320/gb-sct.png', mapUrl: 'https://flagcdn.com/w320/gb-sct.png',
        category: 'All', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Senegal', capital: 'Dakar',
        flagUrl: 'https://flagcdn.com/w320/sn.png', mapUrl: 'https://flagcdn.com/w320/sn.png',
        category: 'All', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Serbia', capital: 'Belgrade',
        flagUrl: 'https://flagcdn.com/w320/rs.png', mapUrl: 'https://flagcdn.com/w320/rs.png',
        category: 'All', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Seychelles', capital: 'Victoria',
        flagUrl: 'https://flagcdn.com/w320/sc.png', mapUrl: 'https://flagcdn.com/w320/sc.png',
        category: 'All', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Sierra Leone', capital: 'Freetown',
        flagUrl: 'https://flagcdn.com/w320/sl.png', mapUrl: 'https://flagcdn.com/w320/sl.png',
        category: 'All', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Singapore', capital: 'Singapore',
        flagUrl: 'https://flagcdn.com/w320/sg.png', mapUrl: 'https://flagcdn.com/w320/sg.png',
        category: 'All', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Slovakia', capital: 'Bratislava',
        flagUrl: 'https://flagcdn.com/w320/sk.png', mapUrl: 'https://flagcdn.com/w320/sk.png',
        category: 'All', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Slovenia', capital: 'Ljubljana',
        flagUrl: 'https://flagcdn.com/w320/si.png', mapUrl: 'https://flagcdn.com/w320/si.png',
        category: 'All', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Solomon Islands', capital: 'Honiara',
        flagUrl: 'https://flagcdn.com/w320/sb.png', mapUrl: 'https://flagcdn.com/w320/sb.png',
        category: 'All', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Somalia', capital: 'Mogadishu',
        flagUrl: 'https://flagcdn.com/w320/so.png', mapUrl: 'https://flagcdn.com/w320/so.png',
        category: 'All', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'South Africa', capital: 'Pretoria',
        flagUrl: 'https://flagcdn.com/w320/za.png', mapUrl: 'https://flagcdn.com/w320/za.png',
        category: 'All', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'South Korea', capital: 'Seoul',
        flagUrl: 'https://flagcdn.com/w320/kr.png', mapUrl: 'https://flagcdn.com/w320/kr.png',
        category: 'All', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'South Sudan', capital: 'Juba',
        flagUrl: 'https://flagcdn.com/w320/ss.png', mapUrl: 'https://flagcdn.com/w320/ss.png',
        category: 'All', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Spain', capital: 'Madrid',
        flagUrl: 'https://flagcdn.com/w320/es.png', mapUrl: 'https://flagcdn.com/w320/es.png',
        category: 'All', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Sri Lanka', capital: 'Sri Jayawardenepura Kotte',
        flagUrl: 'https://flagcdn.com/w320/lk.png', mapUrl: 'https://flagcdn.com/w320/lk.png',
        category: 'All', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Sudan', capital: 'Khartoum',
        flagUrl: 'https://flagcdn.com/w320/sd.png', mapUrl: 'https://flagcdn.com/w320/sd.png',
        category: 'All', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Suriname', capital: 'Paramaribo',
        flagUrl: 'https://flagcdn.com/w320/sr.png', mapUrl: 'https://flagcdn.com/w320/sr.png',
        category: 'All', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Sweden', capital: 'Stockholm',
        flagUrl: 'https://flagcdn.com/w320/se.png', mapUrl: 'https://flagcdn.com/w320/se.png',
        category: 'All', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Switzerland', capital: 'Bern',
        flagUrl: 'https://flagcdn.com/w320/ch.png', mapUrl: 'https://flagcdn.com/w320/ch.png',
        category: 'All', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Syria', capital: 'Damascus',
        flagUrl: 'https://flagcdn.com/w320/sy.png', mapUrl: 'https://flagcdn.com/w320/sy.png',
        category: 'All', difficulty: GameDifficulty.easy
    ),

    // --- T ---
    FlagItem(
        country: 'Taiwan', capital: 'Taipei',
        flagUrl: 'https://flagcdn.com/w320/tw.png', mapUrl: 'https://flagcdn.com/w320/tw.png',
        category: 'All', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Tajikistan', capital: 'Dushanbe',
        flagUrl: 'https://flagcdn.com/w320/tj.png', mapUrl: 'https://flagcdn.com/w320/tj.png',
        category: 'All', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Tanzania', capital: 'Dodoma',
        flagUrl: 'https://flagcdn.com/w320/tz.png', mapUrl: 'https://flagcdn.com/w320/tz.png',
        category: 'All', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Thailand', capital: 'Bangkok',
        flagUrl: 'https://flagcdn.com/w320/th.png', mapUrl: 'https://flagcdn.com/w320/th.png',
        category: 'All', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Timor-Leste', capital: 'Dili',
        flagUrl: 'https://flagcdn.com/w320/tl.png', mapUrl: 'https://flagcdn.com/w320/tl.png',
        category: 'All', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Togo', capital: 'Lomé',
        flagUrl: 'https://flagcdn.com/w320/tg.png', mapUrl: 'https://flagcdn.com/w320/tg.png',
        category: 'All', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Tonga', capital: 'Nukuʻalofa',
        flagUrl: 'https://flagcdn.com/w320/to.png', mapUrl: 'https://flagcdn.com/w320/to.png',
        category: 'All', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Trinidad and Tobago', capital: 'Port of Spain',
        flagUrl: 'https://flagcdn.com/w320/tt.png', mapUrl: 'https://flagcdn.com/w320/tt.png',
        category: 'All', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Tunisia', capital: 'Tunis',
        flagUrl: 'https://flagcdn.com/w320/tn.png', mapUrl: 'https://flagcdn.com/w320/tn.png',
        category: 'All', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Turkey', capital: 'Ankara',
        flagUrl: 'https://flagcdn.com/w320/tr.png', mapUrl: 'https://flagcdn.com/w320/tr.png',
        category: 'All', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Turkmenistan', capital: 'Ashgabat',
        flagUrl: 'https://flagcdn.com/w320/tm.png', mapUrl: 'https://flagcdn.com/w320/tm.png',
        category: 'All', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Tuvalu', capital: 'Funafuti',
        flagUrl: 'https://flagcdn.com/w320/tv.png', mapUrl: 'https://flagcdn.com/w320/tv.png',
        category: 'All', difficulty: GameDifficulty.hard
    ),

    // --- U ---
    FlagItem(
        country: 'Uganda', capital: 'Kampala',
        flagUrl: 'https://flagcdn.com/w320/ug.png', mapUrl: 'https://flagcdn.com/w320/ug.png',
        category: 'All', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Ukraine', capital: 'Kyiv',
        flagUrl: 'https://flagcdn.com/w320/ua.png', mapUrl: 'https://flagcdn.com/w320/ua.png',
        category: 'All', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'United Arab Emirates', capital: 'Abu Dhabi',
        flagUrl: 'https://flagcdn.com/w320/ae.png', mapUrl: 'https://flagcdn.com/w320/ae.png',
        category: 'All', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'United Kingdom', capital: 'London',
        flagUrl: 'https://flagcdn.com/w320/gb.png', mapUrl: 'https://flagcdn.com/w320/gb.png',
        category: 'All', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'United States', capital: 'Washington, D.C.',
        flagUrl: 'https://flagcdn.com/w320/us.png', mapUrl: 'https://flagcdn.com/w320/us.png',
        category: 'All', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Uruguay', capital: 'Montevideo',
        flagUrl: 'https://flagcdn.com/w320/uy.png', mapUrl: 'https://flagcdn.com/w320/uy.png',
        category: 'All', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Uzbekistan', capital: 'Tashkent',
        flagUrl: 'https://flagcdn.com/w320/uz.png', mapUrl: 'https://flagcdn.com/w320/uz.png',
        category: 'All', difficulty: GameDifficulty.medium
    ),

    // --- V ---
    FlagItem(
        country: 'Vanuatu', capital: 'Port Vila',
        flagUrl: 'https://flagcdn.com/w320/vu.png', mapUrl: 'https://flagcdn.com/w320/vu.png',
        category: 'All', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Vatican City', capital: 'Vatican City',
        flagUrl: 'https://flagcdn.com/w320/va.png', mapUrl: 'https://flagcdn.com/w320/va.png',
        category: 'All', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Venezuela', capital: 'Caracas',
        flagUrl: 'https://flagcdn.com/w320/ve.png', mapUrl: 'https://flagcdn.com/w320/ve.png',
        category: 'All', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Vietnam', capital: 'Hanoi',
        flagUrl: 'https://flagcdn.com/w320/vn.png', mapUrl: 'https://flagcdn.com/w320/vn.png',
        category: 'All', difficulty: GameDifficulty.easy
    ),

    // --- W ---
    FlagItem(
        country: 'Wales', capital: 'Cardiff',
        flagUrl: 'https://flagcdn.com/w320/gb-wls.png', mapUrl: 'https://flagcdn.com/w320/gb-wls.png',
        category: 'All', difficulty: GameDifficulty.easy
    ),

    // --- Y ---
    FlagItem(
        country: 'Yemen', capital: 'Sana\'a',
        flagUrl: 'https://flagcdn.com/w320/ye.png', mapUrl: 'https://flagcdn.com/w320/ye.png',
        category: 'All', difficulty: GameDifficulty.medium
    ),

    // --- Z ---
    FlagItem(
        country: 'Zambia', capital: 'Lusaka',
        flagUrl: 'https://flagcdn.com/w320/zm.png', mapUrl: 'https://flagcdn.com/w320/zm.png',
        category: 'All', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Zimbabwe', capital: 'Harare',
        flagUrl: 'https://flagcdn.com/w320/zw.png', mapUrl: 'https://flagcdn.com/w320/zw.png',
        category: 'All', difficulty: GameDifficulty.medium
    ),
    // ==========================================
    // --- UNITED KINGDOM & TERRITORIES ---------
    // ==========================================
    FlagItem(
        country: 'United Kingdom', capital: 'London',
        flagUrl: 'https://flagcdn.com/w320/gb.png',
        mapUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/22/United_Kingdom_on_the_globe_%28Europe_centered%29.svg/320px-United_Kingdom_on_the_globe_%28Europe_centered%29.svg.png',
        category: 'UK', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'England', capital: 'London',
        flagUrl: 'https://flagcdn.com/w320/gb-eng.png',
        mapUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/22/United_Kingdom_on_the_globe_%28Europe_centered%29.svg/320px-United_Kingdom_on_the_globe_%28Europe_centered%29.svg.png',
        category: 'UK', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Scotland', capital: 'Edinburgh',
        flagUrl: 'https://flagcdn.com/w320/gb-sct.png',
        mapUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/22/United_Kingdom_on_the_globe_%28Europe_centered%29.svg/320px-United_Kingdom_on_the_globe_%28Europe_centered%29.svg.png',
        category: 'UK', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Wales', capital: 'Cardiff',
        flagUrl: 'https://flagcdn.com/w320/gb-wls.png',
        mapUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/22/United_Kingdom_on_the_globe_%28Europe_centered%29.svg/320px-United_Kingdom_on_the_globe_%28Europe_centered%29.svg.png',
        category: 'UK', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Northern Ireland', capital: 'Belfast',
        flagUrl: 'https://flagcdn.com/w320/gb-nir.png',
        mapUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/22/United_Kingdom_on_the_globe_%28Europe_centered%29.svg/320px-United_Kingdom_on_the_globe_%28Europe_centered%29.svg.png',
        category: 'UK', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Isle of Man', capital: 'Douglas',
        flagUrl: 'https://flagcdn.com/w320/im.png',
        mapUrl: 'https://flagcdn.com/w320/im.png',
        category: 'UK', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Jersey', capital: 'Saint Helier',
        flagUrl: 'https://flagcdn.com/w320/je.png',
        mapUrl: 'https://flagcdn.com/w320/je.png',
        category: 'UK', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Guernsey', capital: 'Saint Peter Port',
        flagUrl: 'https://flagcdn.com/w320/gg.png',
        mapUrl: 'https://flagcdn.com/w320/gg.png',
        category: 'UK', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Gibraltar', capital: 'Gibraltar',
        flagUrl: 'https://flagcdn.com/w320/gi.png',
        mapUrl: 'https://flagcdn.com/w320/gi.png',
        category: 'UK', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Bermuda', capital: 'Hamilton',
        flagUrl: 'https://flagcdn.com/w320/bm.png',
        mapUrl: 'https://flagcdn.com/w320/bm.png',
        category: 'UK', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Cayman Islands', capital: 'George Town',
        flagUrl: 'https://flagcdn.com/w320/ky.png',
        mapUrl: 'https://flagcdn.com/w320/ky.png',
        category: 'UK', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Falkland Islands', capital: 'Stanley',
        flagUrl: 'https://flagcdn.com/w320/fk.png',
        mapUrl: 'https://flagcdn.com/w320/fk.png',
        category: 'UK', difficulty: GameDifficulty.hard
    ),

    // ==========================================
    // --- AFRICA (54 UN MEMBERS) ---------------
    // ==========================================
    FlagItem(
        country: 'Algeria', capital: 'Algiers',
        flagUrl: 'https://flagcdn.com/w320/dz.png', mapUrl: 'https://flagcdn.com/w320/dz.png',
        category: 'Muslim', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Angola', capital: 'Luanda',
        flagUrl: 'https://flagcdn.com/w320/ao.png', mapUrl: 'https://flagcdn.com/w320/ao.png',
        category: 'Africa', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Benin', capital: 'Porto-Novo',
        flagUrl: 'https://flagcdn.com/w320/bj.png', mapUrl: 'https://flagcdn.com/w320/bj.png',
        category: 'Africa', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Botswana', capital: 'Gaborone',
        flagUrl: 'https://flagcdn.com/w320/bw.png', mapUrl: 'https://flagcdn.com/w320/bw.png',
        category: 'Africa', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Burkina Faso', capital: 'Ouagadougou',
        flagUrl: 'https://flagcdn.com/w320/bf.png', mapUrl: 'https://flagcdn.com/w320/bf.png',
        category: 'Muslim', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Burundi', capital: 'Gitega',
        flagUrl: 'https://flagcdn.com/w320/bi.png', mapUrl: 'https://flagcdn.com/w320/bi.png',
        category: 'Africa', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Cape Verde', capital: 'Praia',
        flagUrl: 'https://flagcdn.com/w320/cv.png', mapUrl: 'https://flagcdn.com/w320/cv.png',
        category: 'Africa', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Cameroon', capital: 'Yaoundé',
        flagUrl: 'https://flagcdn.com/w320/cm.png', mapUrl: 'https://flagcdn.com/w320/cm.png',
        category: 'Muslim', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Central African Republic', capital: 'Bangui',
        flagUrl: 'https://flagcdn.com/w320/cf.png', mapUrl: 'https://flagcdn.com/w320/cf.png',
        category: 'Africa', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Chad', capital: 'N\'Djamena',
        flagUrl: 'https://flagcdn.com/w320/td.png', mapUrl: 'https://flagcdn.com/w320/td.png',
        category: 'Muslim', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Comoros', capital: 'Moroni',
        flagUrl: 'https://flagcdn.com/w320/km.png', mapUrl: 'https://flagcdn.com/w320/km.png',
        category: 'Muslim', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Democratic Republic of the Congo', capital: 'Kinshasa',
        flagUrl: 'https://flagcdn.com/w320/cd.png', mapUrl: 'https://flagcdn.com/w320/cd.png',
        category: 'Africa', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Republic of the Congo', capital: 'Brazzaville',
        flagUrl: 'https://flagcdn.com/w320/cg.png', mapUrl: 'https://flagcdn.com/w320/cg.png',
        category: 'Africa', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Djibouti', capital: 'Djibouti',
        flagUrl: 'https://flagcdn.com/w320/dj.png', mapUrl: 'https://flagcdn.com/w320/dj.png',
        category: 'Muslim', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Egypt', capital: 'Cairo',
        flagUrl: 'https://flagcdn.com/w320/eg.png', mapUrl: 'https://flagcdn.com/w320/eg.png',
        category: 'Muslim', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Equatorial Guinea', capital: 'Malabo',
        flagUrl: 'https://flagcdn.com/w320/gq.png', mapUrl: 'https://flagcdn.com/w320/gq.png',
        category: 'Africa', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Eritrea', capital: 'Asmara',
        flagUrl: 'https://flagcdn.com/w320/er.png', mapUrl: 'https://flagcdn.com/w320/er.png',
        category: 'Africa', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Eswatini', capital: 'Mbabane',
        flagUrl: 'https://flagcdn.com/w320/sz.png', mapUrl: 'https://flagcdn.com/w320/sz.png',
        category: 'Africa', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Ethiopia', capital: 'Addis Ababa',
        flagUrl: 'https://flagcdn.com/w320/et.png', mapUrl: 'https://flagcdn.com/w320/et.png',
        category: 'Africa', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Gabon', capital: 'Libreville',
        flagUrl: 'https://flagcdn.com/w320/ga.png', mapUrl: 'https://flagcdn.com/w320/ga.png',
        category: 'Africa', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Gambia', capital: 'Banjul',
        flagUrl: 'https://flagcdn.com/w320/gm.png', mapUrl: 'https://flagcdn.com/w320/gm.png',
        category: 'Muslim', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Ghana', capital: 'Accra',
        flagUrl: 'https://flagcdn.com/w320/gh.png', mapUrl: 'https://flagcdn.com/w320/gh.png',
        category: 'Africa', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Guinea', capital: 'Conakry',
        flagUrl: 'https://flagcdn.com/w320/gn.png', mapUrl: 'https://flagcdn.com/w320/gn.png',
        category: 'Muslim', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Guinea-Bissau', capital: 'Bissau',
        flagUrl: 'https://flagcdn.com/w320/gw.png', mapUrl: 'https://flagcdn.com/w320/gw.png',
        category: 'Muslim', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Ivory Coast', capital: 'Yamoussoukro',
        flagUrl: 'https://flagcdn.com/w320/ci.png', mapUrl: 'https://flagcdn.com/w320/ci.png',
        category: 'Africa', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Kenya', capital: 'Nairobi',
        flagUrl: 'https://flagcdn.com/w320/ke.png', mapUrl: 'https://flagcdn.com/w320/ke.png',
        category: 'Africa', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Lesotho', capital: 'Maseru',
        flagUrl: 'https://flagcdn.com/w320/ls.png', mapUrl: 'https://flagcdn.com/w320/ls.png',
        category: 'Africa', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Liberia', capital: 'Monrovia',
        flagUrl: 'https://flagcdn.com/w320/lr.png', mapUrl: 'https://flagcdn.com/w320/lr.png',
        category: 'Africa', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Libya', capital: 'Tripoli',
        flagUrl: 'https://flagcdn.com/w320/ly.png', mapUrl: 'https://flagcdn.com/w320/ly.png',
        category: 'Muslim', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Madagascar', capital: 'Antananarivo',
        flagUrl: 'https://flagcdn.com/w320/mg.png', mapUrl: 'https://flagcdn.com/w320/mg.png',
        category: 'Africa', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Malawi', capital: 'Lilongwe',
        flagUrl: 'https://flagcdn.com/w320/mw.png', mapUrl: 'https://flagcdn.com/w320/mw.png',
        category: 'Africa', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Mali', capital: 'Bamako',
        flagUrl: 'https://flagcdn.com/w320/ml.png', mapUrl: 'https://flagcdn.com/w320/ml.png',
        category: 'Muslim', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Mauritania', capital: 'Nouakchott',
        flagUrl: 'https://flagcdn.com/w320/mr.png', mapUrl: 'https://flagcdn.com/w320/mr.png',
        category: 'Muslim', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Mauritius', capital: 'Port Louis',
        flagUrl: 'https://flagcdn.com/w320/mu.png', mapUrl: 'https://flagcdn.com/w320/mu.png',
        category: 'Africa', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Morocco', capital: 'Rabat',
        flagUrl: 'https://flagcdn.com/w320/ma.png', mapUrl: 'https://flagcdn.com/w320/ma.png',
        category: 'Muslim', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Mozambique', capital: 'Maputo',
        flagUrl: 'https://flagcdn.com/w320/mz.png', mapUrl: 'https://flagcdn.com/w320/mz.png',
        category: 'Africa', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Namibia', capital: 'Windhoek',
        flagUrl: 'https://flagcdn.com/w320/na.png', mapUrl: 'https://flagcdn.com/w320/na.png',
        category: 'Africa', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Niger', capital: 'Niamey',
        flagUrl: 'https://flagcdn.com/w320/ne.png', mapUrl: 'https://flagcdn.com/w320/ne.png',
        category: 'Muslim', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Nigeria', capital: 'Abuja',
        flagUrl: 'https://flagcdn.com/w320/ng.png', mapUrl: 'https://flagcdn.com/w320/ng.png',
        category: 'Muslim', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Rwanda', capital: 'Kigali',
        flagUrl: 'https://flagcdn.com/w320/rw.png', mapUrl: 'https://flagcdn.com/w320/rw.png',
        category: 'Africa', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'São Tomé and Príncipe', capital: 'São Tomé',
        flagUrl: 'https://flagcdn.com/w320/st.png', mapUrl: 'https://flagcdn.com/w320/st.png',
        category: 'Africa', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Senegal', capital: 'Dakar',
        flagUrl: 'https://flagcdn.com/w320/sn.png', mapUrl: 'https://flagcdn.com/w320/sn.png',
        category: 'Muslim', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Seychelles', capital: 'Victoria',
        flagUrl: 'https://flagcdn.com/w320/sc.png', mapUrl: 'https://flagcdn.com/w320/sc.png',
        category: 'Africa', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Sierra Leone', capital: 'Freetown',
        flagUrl: 'https://flagcdn.com/w320/sl.png', mapUrl: 'https://flagcdn.com/w320/sl.png',
        category: 'Muslim', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Somalia', capital: 'Mogadishu',
        flagUrl: 'https://flagcdn.com/w320/so.png', mapUrl: 'https://flagcdn.com/w320/so.png',
        category: 'Muslim', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'South Africa', capital: 'Pretoria',
        flagUrl: 'https://flagcdn.com/w320/za.png',
        mapUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/6/6e/South_Africa_%28orthographic_projection%29.svg/320px-South_Africa_%28orthographic_projection%29.svg.png',
        category: 'Africa', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'South Sudan', capital: 'Juba',
        flagUrl: 'https://flagcdn.com/w320/ss.png', mapUrl: 'https://flagcdn.com/w320/ss.png',
        category: 'Africa', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Sudan', capital: 'Khartoum',
        flagUrl: 'https://flagcdn.com/w320/sd.png', mapUrl: 'https://flagcdn.com/w320/sd.png',
        category: 'Muslim', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Tanzania', capital: 'Dodoma',
        flagUrl: 'https://flagcdn.com/w320/tz.png', mapUrl: 'https://flagcdn.com/w320/tz.png',
        category: 'Africa', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Togo', capital: 'Lomé',
        flagUrl: 'https://flagcdn.com/w320/tg.png', mapUrl: 'https://flagcdn.com/w320/tg.png',
        category: 'Africa', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Tunisia', capital: 'Tunis',
        flagUrl: 'https://flagcdn.com/w320/tn.png', mapUrl: 'https://flagcdn.com/w320/tn.png',
        category: 'Muslim', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Uganda', capital: 'Kampala',
        flagUrl: 'https://flagcdn.com/w320/ug.png', mapUrl: 'https://flagcdn.com/w320/ug.png',
        category: 'Africa', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Zambia', capital: 'Lusaka',
        flagUrl: 'https://flagcdn.com/w320/zm.png', mapUrl: 'https://flagcdn.com/w320/zm.png',
        category: 'Africa', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Zimbabwe', capital: 'Harare',
        flagUrl: 'https://flagcdn.com/w320/zw.png', mapUrl: 'https://flagcdn.com/w320/zw.png',
        category: 'Africa', difficulty: GameDifficulty.medium
    ),

    // ==========================================
    // --- EUROPE (ALL EUROPEAN NATIONS) --------
    // ==========================================
    FlagItem(
        country: 'Albania', capital: 'Tirana',
        flagUrl: 'https://flagcdn.com/w320/al.png', mapUrl: 'https://flagcdn.com/w320/al.png',
        category: 'Europe', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Andorra', capital: 'Andorra la Vella',
        flagUrl: 'https://flagcdn.com/w320/ad.png', mapUrl: 'https://flagcdn.com/w320/ad.png',
        category: 'Europe', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Austria', capital: 'Vienna',
        flagUrl: 'https://flagcdn.com/w320/at.png', mapUrl: 'https://flagcdn.com/w320/at.png',
        category: 'Europe', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Belarus', capital: 'Minsk',
        flagUrl: 'https://flagcdn.com/w320/by.png', mapUrl: 'https://flagcdn.com/w320/by.png',
        category: 'Europe', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Belgium', capital: 'Brussels',
        flagUrl: 'https://flagcdn.com/w320/be.png', mapUrl: 'https://flagcdn.com/w320/be.png',
        category: 'Europe', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Bosnia and Herzegovina', capital: 'Sarajevo',
        flagUrl: 'https://flagcdn.com/w320/ba.png', mapUrl: 'https://flagcdn.com/w320/ba.png',
        category: 'Europe', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Bulgaria', capital: 'Sofia',
        flagUrl: 'https://flagcdn.com/w320/bg.png', mapUrl: 'https://flagcdn.com/w320/bg.png',
        category: 'Europe', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Croatia', capital: 'Zagreb',
        flagUrl: 'https://flagcdn.com/w320/hr.png', mapUrl: 'https://flagcdn.com/w320/hr.png',
        category: 'Europe', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Cyprus', capital: 'Nicosia',
        flagUrl: 'https://flagcdn.com/w320/cy.png', mapUrl: 'https://flagcdn.com/w320/cy.png',
        category: 'Europe', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Czech Republic', capital: 'Prague',
        flagUrl: 'https://flagcdn.com/w320/cz.png', mapUrl: 'https://flagcdn.com/w320/cz.png',
        category: 'Europe', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Denmark', capital: 'Copenhagen',
        flagUrl: 'https://flagcdn.com/w320/dk.png', mapUrl: 'https://flagcdn.com/w320/dk.png',
        category: 'Europe', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Estonia', capital: 'Tallinn',
        flagUrl: 'https://flagcdn.com/w320/ee.png', mapUrl: 'https://flagcdn.com/w320/ee.png',
        category: 'Europe', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Finland', capital: 'Helsinki',
        flagUrl: 'https://flagcdn.com/w320/fi.png', mapUrl: 'https://flagcdn.com/w320/fi.png',
        category: 'Europe', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'France', capital: 'Paris',
        flagUrl: 'https://flagcdn.com/w320/fr.png',
        mapUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a3/France_%28orthographic_projection%29.svg/320px-France_%28orthographic_projection%29.svg.png',
        category: 'Europe', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Germany', capital: 'Berlin',
        flagUrl: 'https://flagcdn.com/w320/de.png',
        mapUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a6/Germany_%28orthographic_projection%29.svg/320px-Germany_%28orthographic_projection%29.svg.png',
        category: 'Europe', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Greece', capital: 'Athens',
        flagUrl: 'https://flagcdn.com/w320/gr.png', mapUrl: 'https://flagcdn.com/w320/gr.png',
        category: 'Europe', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Hungary', capital: 'Budapest',
        flagUrl: 'https://flagcdn.com/w320/hu.png', mapUrl: 'https://flagcdn.com/w320/hu.png',
        category: 'Europe', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Iceland', capital: 'Reykjavik',
        flagUrl: 'https://flagcdn.com/w320/is.png', mapUrl: 'https://flagcdn.com/w320/is.png',
        category: 'Europe', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Ireland', capital: 'Dublin',
        flagUrl: 'https://flagcdn.com/w320/ie.png', mapUrl: 'https://flagcdn.com/w320/ie.png',
        category: 'Europe', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Italy', capital: 'Rome',
        flagUrl: 'https://flagcdn.com/w320/it.png',
        mapUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/03/Italy_%28orthographic_projection%29.svg/320px-Italy_%28orthographic_projection%29.svg.png',
        category: 'Europe', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Kosovo', capital: 'Pristina',
        flagUrl: 'https://flagcdn.com/w320/xk.png', mapUrl: 'https://flagcdn.com/w320/xk.png',
        category: 'Europe', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Latvia', capital: 'Riga',
        flagUrl: 'https://flagcdn.com/w320/lv.png', mapUrl: 'https://flagcdn.com/w320/lv.png',
        category: 'Europe', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Liechtenstein', capital: 'Vaduz',
        flagUrl: 'https://flagcdn.com/w320/li.png', mapUrl: 'https://flagcdn.com/w320/li.png',
        category: 'Europe', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Lithuania', capital: 'Vilnius',
        flagUrl: 'https://flagcdn.com/w320/lt.png', mapUrl: 'https://flagcdn.com/w320/lt.png',
        category: 'Europe', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Luxembourg', capital: 'Luxembourg',
        flagUrl: 'https://flagcdn.com/w320/lu.png', mapUrl: 'https://flagcdn.com/w320/lu.png',
        category: 'Europe', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Malta', capital: 'Valletta',
        flagUrl: 'https://flagcdn.com/w320/mt.png', mapUrl: 'https://flagcdn.com/w320/mt.png',
        category: 'Europe', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Moldova', capital: 'Chisinau',
        flagUrl: 'https://flagcdn.com/w320/md.png', mapUrl: 'https://flagcdn.com/w320/md.png',
        category: 'Europe', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Monaco', capital: 'Monaco',
        flagUrl: 'https://flagcdn.com/w320/mc.png', mapUrl: 'https://flagcdn.com/w320/mc.png',
        category: 'Europe', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Montenegro', capital: 'Podgorica',
        flagUrl: 'https://flagcdn.com/w320/me.png', mapUrl: 'https://flagcdn.com/w320/me.png',
        category: 'Europe', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Netherlands', capital: 'Amsterdam',
        flagUrl: 'https://flagcdn.com/w320/nl.png', mapUrl: 'https://flagcdn.com/w320/nl.png',
        category: 'Europe', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'North Macedonia', capital: 'Skopje',
        flagUrl: 'https://flagcdn.com/w320/mk.png', mapUrl: 'https://flagcdn.com/w320/mk.png',
        category: 'Europe', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Norway', capital: 'Oslo',
        flagUrl: 'https://flagcdn.com/w320/no.png', mapUrl: 'https://flagcdn.com/w320/no.png',
        category: 'Europe', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Poland', capital: 'Warsaw',
        flagUrl: 'https://flagcdn.com/w320/pl.png', mapUrl: 'https://flagcdn.com/w320/pl.png',
        category: 'Europe', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Portugal', capital: 'Lisbon',
        flagUrl: 'https://flagcdn.com/w320/pt.png', mapUrl: 'https://flagcdn.com/w320/pt.png',
        category: 'Europe', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Romania', capital: 'Bucharest',
        flagUrl: 'https://flagcdn.com/w320/ro.png', mapUrl: 'https://flagcdn.com/w320/ro.png',
        category: 'Europe', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Russia', capital: 'Moscow',
        flagUrl: 'https://flagcdn.com/w320/ru.png', mapUrl: 'https://flagcdn.com/w320/ru.png',
        category: 'Europe', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'San Marino', capital: 'San Marino',
        flagUrl: 'https://flagcdn.com/w320/sm.png', mapUrl: 'https://flagcdn.com/w320/sm.png',
        category: 'Europe', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Serbia', capital: 'Belgrade',
        flagUrl: 'https://flagcdn.com/w320/rs.png', mapUrl: 'https://flagcdn.com/w320/rs.png',
        category: 'Europe', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Slovakia', capital: 'Bratislava',
        flagUrl: 'https://flagcdn.com/w320/sk.png', mapUrl: 'https://flagcdn.com/w320/sk.png',
        category: 'Europe', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Slovenia', capital: 'Ljubljana',
        flagUrl: 'https://flagcdn.com/w320/si.png', mapUrl: 'https://flagcdn.com/w320/si.png',
        category: 'Europe', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Spain', capital: 'Madrid',
        flagUrl: 'https://flagcdn.com/w320/es.png',
        mapUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/9/9c/Spain_%28orthographic_projection%29.svg/320px-Spain_%28orthographic_projection%29.svg.png',
        category: 'Europe', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Sweden', capital: 'Stockholm',
        flagUrl: 'https://flagcdn.com/w320/se.png', mapUrl: 'https://flagcdn.com/w320/se.png',
        category: 'Europe', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Switzerland', capital: 'Bern',
        flagUrl: 'https://flagcdn.com/w320/ch.png', mapUrl: 'https://flagcdn.com/w320/ch.png',
        category: 'Europe', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Ukraine', capital: 'Kyiv',
        flagUrl: 'https://flagcdn.com/w320/ua.png', mapUrl: 'https://flagcdn.com/w320/ua.png',
        category: 'Europe', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Vatican City', capital: 'Vatican City',
        flagUrl: 'https://flagcdn.com/w320/va.png', mapUrl: 'https://flagcdn.com/w320/va.png',
        category: 'Europe', difficulty: GameDifficulty.medium
    ),

    // ==========================================
    // --- ASIA (ALL ASIAN NATIONS) -------------
    // ==========================================
    FlagItem(
        country: 'Afghanistan', capital: 'Kabul',
        flagUrl: 'https://flagcdn.com/w320/af.png', mapUrl: 'https://flagcdn.com/w320/af.png',
        category: 'Muslim', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Armenia', capital: 'Yerevan',
        flagUrl: 'https://flagcdn.com/w320/am.png', mapUrl: 'https://flagcdn.com/w320/am.png',
        category: 'Asia', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Azerbaijan', capital: 'Baku',
        flagUrl: 'https://flagcdn.com/w320/az.png', mapUrl: 'https://flagcdn.com/w320/az.png',
        category: 'Muslim', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Bahrain', capital: 'Manama',
        flagUrl: 'https://flagcdn.com/w320/bh.png', mapUrl: 'https://flagcdn.com/w320/bh.png',
        category: 'Muslim', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Bangladesh', capital: 'Dhaka',
        flagUrl: 'https://flagcdn.com/w320/bd.png', mapUrl: 'https://flagcdn.com/w320/bd.png',
        category: 'Muslim', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Bhutan', capital: 'Thimphu',
        flagUrl: 'https://flagcdn.com/w320/bt.png', mapUrl: 'https://flagcdn.com/w320/bt.png',
        category: 'Asia', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Brunei', capital: 'Bandar Seri Begawan',
        flagUrl: 'https://flagcdn.com/w320/bn.png', mapUrl: 'https://flagcdn.com/w320/bn.png',
        category: 'Muslim', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Cambodia', capital: 'Phnom Penh',
        flagUrl: 'https://flagcdn.com/w320/kh.png', mapUrl: 'https://flagcdn.com/w320/kh.png',
        category: 'Asia', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'China', capital: 'Beijing',
        flagUrl: 'https://flagcdn.com/w320/cn.png', mapUrl: 'https://flagcdn.com/w320/cn.png',
        category: 'Asia', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Georgia', capital: 'Tbilisi',
        flagUrl: 'https://flagcdn.com/w320/ge.png', mapUrl: 'https://flagcdn.com/w320/ge.png',
        category: 'Asia', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'India', capital: 'New Delhi',
        flagUrl: 'https://flagcdn.com/w320/in.png', mapUrl: 'https://flagcdn.com/w320/in.png',
        category: 'Asia', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Indonesia', capital: 'Jakarta',
        flagUrl: 'https://flagcdn.com/w320/id.png', mapUrl: 'https://flagcdn.com/w320/id.png',
        category: 'Muslim', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Iran', capital: 'Tehran',
        flagUrl: 'https://flagcdn.com/w320/ir.png', mapUrl: 'https://flagcdn.com/w320/ir.png',
        category: 'Muslim', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Iraq', capital: 'Baghdad',
        flagUrl: 'https://flagcdn.com/w320/iq.png', mapUrl: 'https://flagcdn.com/w320/iq.png',
        category: 'Muslim', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Japan', capital: 'Tokyo',
        flagUrl: 'https://flagcdn.com/w320/jp.png',
        mapUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/6/62/Japan_%28orthographic_projection%29.svg/320px-Japan_%28orthographic_projection%29.svg.png',
        category: 'Asia', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Jordan', capital: 'Amman',
        flagUrl: 'https://flagcdn.com/w320/jo.png', mapUrl: 'https://flagcdn.com/w320/jo.png',
        category: 'Muslim', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Kazakhstan', capital: 'Astana',
        flagUrl: 'https://flagcdn.com/w320/kz.png', mapUrl: 'https://flagcdn.com/w320/kz.png',
        category: 'Muslim', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Kuwait', capital: 'Kuwait City',
        flagUrl: 'https://flagcdn.com/w320/kw.png', mapUrl: 'https://flagcdn.com/w320/kw.png',
        category: 'Muslim', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Kyrgyzstan', capital: 'Bishkek',
        flagUrl: 'https://flagcdn.com/w320/kg.png', mapUrl: 'https://flagcdn.com/w320/kg.png',
        category: 'Muslim', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Laos', capital: 'Vientiane',
        flagUrl: 'https://flagcdn.com/w320/la.png', mapUrl: 'https://flagcdn.com/w320/la.png',
        category: 'Asia', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Lebanon', capital: 'Beirut',
        flagUrl: 'https://flagcdn.com/w320/lb.png', mapUrl: 'https://flagcdn.com/w320/lb.png',
        category: 'Muslim', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Malaysia', capital: 'Kuala Lumpur',
        flagUrl: 'https://flagcdn.com/w320/my.png', mapUrl: 'https://flagcdn.com/w320/my.png',
        category: 'Muslim', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Maldives', capital: 'Malé',
        flagUrl: 'https://flagcdn.com/w320/mv.png', mapUrl: 'https://flagcdn.com/w320/mv.png',
        category: 'Muslim', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Mongolia', capital: 'Ulaanbaatar',
        flagUrl: 'https://flagcdn.com/w320/mn.png', mapUrl: 'https://flagcdn.com/w320/mn.png',
        category: 'Asia', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Myanmar', capital: 'Naypyidaw',
        flagUrl: 'https://flagcdn.com/w320/mm.png', mapUrl: 'https://flagcdn.com/w320/mm.png',
        category: 'Asia', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Nepal', capital: 'Kathmandu',
        flagUrl: 'https://flagcdn.com/w320/np.png', mapUrl: 'https://flagcdn.com/w320/np.png',
        category: 'Asia', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'North Korea', capital: 'Pyongyang',
        flagUrl: 'https://flagcdn.com/w320/kp.png', mapUrl: 'https://flagcdn.com/w320/kp.png',
        category: 'Asia', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Oman', capital: 'Muscat',
        flagUrl: 'https://flagcdn.com/w320/om.png', mapUrl: 'https://flagcdn.com/w320/om.png',
        category: 'Muslim', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Pakistan', capital: 'Islamabad',
        flagUrl: 'https://flagcdn.com/w320/pk.png',
        mapUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Pakistan_%28orthographic_projection%29.svg/320px-Pakistan_%28orthographic_projection%29.svg.png',
        category: 'Muslim', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Palestine', capital: 'Jerusalem',
        flagUrl: 'https://flagcdn.com/w320/ps.png', mapUrl: 'https://flagcdn.com/w320/ps.png',
        category: 'Muslim', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Philippines', capital: 'Manila',
        flagUrl: 'https://flagcdn.com/w320/ph.png', mapUrl: 'https://flagcdn.com/w320/ph.png',
        category: 'Asia', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Qatar', capital: 'Doha',
        flagUrl: 'https://flagcdn.com/w320/qa.png', mapUrl: 'https://flagcdn.com/w320/qa.png',
        category: 'Muslim', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Saudi Arabia', capital: 'Riyadh',
        flagUrl: 'https://flagcdn.com/w320/sa.png', mapUrl: 'https://flagcdn.com/w320/sa.png',
        category: 'Muslim', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Singapore', capital: 'Singapore',
        flagUrl: 'https://flagcdn.com/w320/sg.png', mapUrl: 'https://flagcdn.com/w320/sg.png',
        category: 'Asia', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'South Korea', capital: 'Seoul',
        flagUrl: 'https://flagcdn.com/w320/kr.png', mapUrl: 'https://flagcdn.com/w320/kr.png',
        category: 'Asia', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Sri Lanka', capital: 'Sri Jayawardenepura Kotte',
        flagUrl: 'https://flagcdn.com/w320/lk.png', mapUrl: 'https://flagcdn.com/w320/lk.png',
        category: 'Asia', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Syria', capital: 'Damascus',
        flagUrl: 'https://flagcdn.com/w320/sy.png', mapUrl: 'https://flagcdn.com/w320/sy.png',
        category: 'Muslim', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Taiwan', capital: 'Taipei',
        flagUrl: 'https://flagcdn.com/w320/tw.png', mapUrl: 'https://flagcdn.com/w320/tw.png',
        category: 'Asia', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Tajikistan', capital: 'Dushanbe',
        flagUrl: 'https://flagcdn.com/w320/tj.png', mapUrl: 'https://flagcdn.com/w320/tj.png',
        category: 'Muslim', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Thailand', capital: 'Bangkok',
        flagUrl: 'https://flagcdn.com/w320/th.png', mapUrl: 'https://flagcdn.com/w320/th.png',
        category: 'Asia', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Timor-Leste', capital: 'Dili',
        flagUrl: 'https://flagcdn.com/w320/tl.png', mapUrl: 'https://flagcdn.com/w320/tl.png',
        category: 'Asia', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'Turkey', capital: 'Ankara',
        flagUrl: 'https://flagcdn.com/w320/tr.png',
        mapUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/d/dd/Turkey_%28orthographic_projection%29.svg/320px-Turkey_%28orthographic_projection%29.svg.png',
        category: 'Muslim', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Turkmenistan', capital: 'Ashgabat',
        flagUrl: 'https://flagcdn.com/w320/tm.png', mapUrl: 'https://flagcdn.com/w320/tm.png',
        category: 'Muslim', difficulty: GameDifficulty.hard
    ),
    FlagItem(
        country: 'United Arab Emirates', capital: 'Abu Dhabi',
        flagUrl: 'https://flagcdn.com/w320/ae.png', mapUrl: 'https://flagcdn.com/w320/ae.png',
        category: 'Muslim', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Uzbekistan', capital: 'Tashkent',
        flagUrl: 'https://flagcdn.com/w320/uz.png', mapUrl: 'https://flagcdn.com/w320/uz.png',
        category: 'Muslim', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Vietnam', capital: 'Hanoi',
        flagUrl: 'https://flagcdn.com/w320/vn.png', mapUrl: 'https://flagcdn.com/w320/vn.png',
        category: 'Asia', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Yemen', capital: 'Sana\'a',
        flagUrl: 'https://flagcdn.com/w320/ye.png', mapUrl: 'https://flagcdn.com/w320/ye.png',
        category: 'Muslim', difficulty: GameDifficulty.medium
    ),

    // ==========================================
    // --- AMERICAS & OCEANIA (CLASSIC ARCADE) --
    // ==========================================
    FlagItem(
        country: 'United States', capital: 'Washington, D.C.',
        flagUrl: 'https://flagcdn.com/w320/us.png', mapUrl: 'https://flagcdn.com/w320/us.png',
        category: 'Arcade', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Canada', capital: 'Ottawa',
        flagUrl: 'https://flagcdn.com/w320/ca.png',
        mapUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/03/Canada_%28orthographic_projection%29.svg/320px-Canada_%28orthographic_projection%29.svg.png',
        category: 'Arcade', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Brazil', capital: 'Brasília',
        flagUrl: 'https://flagcdn.com/w320/br.png',
        mapUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/b/bc/Brazil_%28orthographic_projection%29.svg/320px-Brazil_%28orthographic_projection%29.svg.png',
        category: 'Arcade', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Argentina', capital: 'Buenos Aires',
        flagUrl: 'https://flagcdn.com/w320/ar.png', mapUrl: 'https://flagcdn.com/w320/ar.png',
        category: 'Arcade', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Mexico', capital: 'Mexico City',
        flagUrl: 'https://flagcdn.com/w320/mx.png', mapUrl: 'https://flagcdn.com/w320/mx.png',
        category: 'Arcade', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Australia', capital: 'Canberra',
        flagUrl: 'https://flagcdn.com/w320/au.png', mapUrl: 'https://flagcdn.com/w320/au.png',
        category: 'Arcade', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'New Zealand', capital: 'Wellington',
        flagUrl: 'https://flagcdn.com/w320/nz.png', mapUrl: 'https://flagcdn.com/w320/nz.png',
        category: 'Arcade', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Colombia', capital: 'Bogotá',
        flagUrl: 'https://flagcdn.com/w320/co.png', mapUrl: 'https://flagcdn.com/w320/co.png',
        category: 'Arcade', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Peru', capital: 'Lima',
        flagUrl: 'https://flagcdn.com/w320/pe.png', mapUrl: 'https://flagcdn.com/w320/pe.png',
        category: 'Arcade', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Chile', capital: 'Santiago',
        flagUrl: 'https://flagcdn.com/w320/cl.png', mapUrl: 'https://flagcdn.com/w320/cl.png',
        category: 'Arcade', difficulty: GameDifficulty.medium
    ),
    FlagItem(
        country: 'Jamaica', capital: 'Kingston',
        flagUrl: 'https://flagcdn.com/w320/jm.png', mapUrl: 'https://flagcdn.com/w320/jm.png',
        category: 'Arcade', difficulty: GameDifficulty.easy
    ),
    FlagItem(
        country: 'Cuba', capital: 'Havana',
        flagUrl: 'https://flagcdn.com/w320/cu.png', mapUrl: 'https://flagcdn.com/w320/cu.png',
        category: 'Arcade', difficulty: GameDifficulty.medium
    ),
  ];
}

class HistoryRecord {
  final String date;
  final String mode;
  final int score;
  final int total;
  final int optionsCount;

  HistoryRecord({
    required this.date,
    required this.mode,
    required this.score,
    required this.total,
    required this.optionsCount,
  });
}

class QuizResult {
  final String mode;
  final int correct;
  final int total;
  final int streak;
  final DateTime date;

  QuizResult({
    required this.mode,
    required this.correct,
    required this.total,
    required this.streak,
    required this.date,
  });
}

class UserStats {
  static int totalGames = 0;
  static int totalQuestionsPlayed = 0;
  static int totalCorrectAnswers = 0;
  static int highestStreak = 0;
  static List<QuizResult> history = [];

  static double get accuracyRate {
    if (totalQuestionsPlayed == 0) return 0.0;
    return (totalCorrectAnswers / totalQuestionsPlayed) * 100;
  }

  static void recordGame({
    required String mode,
    required int correct,
    required int total,
    required int streak,
    required int optionsCount,
  }) {
    totalGames++;
    totalQuestionsPlayed += total;
    totalCorrectAnswers += correct;
    if (streak > highestStreak) {
      highestStreak = streak;
    }

    history.insert(
      0,
      QuizResult(
        mode: mode,
        correct: correct,
        total: total,
        streak: streak,
        date: DateTime.now(),
      ),
    );
  }
}
