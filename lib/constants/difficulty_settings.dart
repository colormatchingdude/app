enum DifficultyLevel {
  easy,
  medium,
  hard,
}

class DifficultySettings {
  final int minColors;
  final int maxColors;
  final int minWeights;
  final int maxWeights;
  final int visibleBaseColors;

  const DifficultySettings({
    required this.minColors,
    required this.maxColors,
    required this.minWeights,
    required this.maxWeights,
    required this.visibleBaseColors,
  });

  static const Map<DifficultyLevel, DifficultySettings> settings = {
    DifficultyLevel.easy: DifficultySettings(
      minColors: 2,
      maxColors: 3,
      minWeights: 1,
      maxWeights: 3,
      visibleBaseColors: 4,
    ),
    DifficultyLevel.medium: DifficultySettings(
      minColors: 2,
      maxColors: 4,
      minWeights: 1,
      maxWeights: 5,
      visibleBaseColors: 5,
    ),
    DifficultyLevel.hard: DifficultySettings(
      minColors: 3,
      maxColors: 5,
      minWeights: 1,
      maxWeights: 7,
      visibleBaseColors: 6,
    ),
  };

  static DifficultySettings getSettings(DifficultyLevel level) {
    return settings[level]!;
  }
}