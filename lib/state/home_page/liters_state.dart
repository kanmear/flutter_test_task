class LitersState {
  final int liters;
  final bool isLoading;
  final String? error;

  const LitersState({
    this.liters = 0,
    this.isLoading = false,
    this.error,
  });

  LitersState copyWith({
    int? liters,
    bool? isLoading,
    String? error,
  }) {
    return LitersState(
      liters: liters ?? this.liters,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}
