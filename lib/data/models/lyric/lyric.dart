class Lyric {
  Lyric({
    required this.line,
    this.isSelected = false,
    this.isNextLineSelected = false,
    this.isPreviousLineSelected = false,
  });

  final String line;
  final bool isSelected;
  final bool isNextLineSelected;
  final bool isPreviousLineSelected;

  Lyric copyWith({
    bool? isSelected,
    bool? isNextLineSelected,
    bool? isPreviousLineSelected,
  }) {
    return Lyric(
      line: line,
      isSelected: isSelected ?? this.isSelected,
      isNextLineSelected: isNextLineSelected ?? this.isNextLineSelected,
      isPreviousLineSelected: isPreviousLineSelected ?? this.isPreviousLineSelected,
    );
  }

  @override
  String toString() {
    return 'Lyric{line: $line, isSelected: $isSelected, isNextLineSelected: $isNextLineSelected, isPreviousLineSelected: $isPreviousLineSelected}';
  }
}
