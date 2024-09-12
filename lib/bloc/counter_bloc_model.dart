class CounterBlocModel {
  CounterBlocModel({
    this.count,
    this.isLoading = false,
  });
  final int? count;
  final bool? isLoading;

  CounterBlocModel copyWith({
    int? count,
    bool? isLoading,
  }) {
    return CounterBlocModel(
      count: count ?? this.count,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
