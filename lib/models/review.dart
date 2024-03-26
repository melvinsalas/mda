class Review {
  final String restaurantAlias;
  final String restaurantName;
  final double score;

  Review({
    required this.restaurantAlias,
    required this.restaurantName,
    required this.score,
  });

  @override
  String toString() {
    return '$restaurantAlias,$restaurantName,$score';
  }

  factory Review.empty() {
    return Review(
      restaurantAlias: '',
      restaurantName: '',
      score: 0,
    );
  }
}
