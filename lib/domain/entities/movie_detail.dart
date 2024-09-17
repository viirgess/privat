class MovieDetail {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final double? voteAverage;

  MovieDetail({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.voteAverage,
  });

  factory MovieDetail.fromJson(Map<String, dynamic> json) {
    return MovieDetail(
      id: json['id'],
      title: json['title'],
      overview: json['overview'],
      posterPath: json['poster_path'] ?? '',
      voteAverage: (json['vote_average'] as num?)?.toDouble(),
    );
  }
}
