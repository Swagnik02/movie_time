import 'package:html/parser.dart' show parse;

class MovieData {
  final double score;
  final String title;
  final List<String> genres;
  final String summary;
  final String imageUrl;
  final String altImageUrl;
  final double? rating;

  MovieData({
    required this.score,
    required this.title,
    required this.genres,
    required this.summary,
    required this.imageUrl,
    required this.altImageUrl,
    this.rating,
  });

  factory MovieData.fromJson(Map<String, dynamic> json) {
    final show = json['show'] ?? {};
    final image = show['image'] ?? {};

    final rawSummary = show['summary'] ?? '';
    final cleanSummary = parse(rawSummary).documentElement?.text ?? '';

    return MovieData(
      score: (json['score'] ?? 0.0).toDouble(),
      title: show['name'] ?? '',
      genres: List<String>.from(show['genres'] ?? []),
      summary: cleanSummary,
      imageUrl: image['medium'] ?? 'https://via.placeholder.com/50',
      altImageUrl: image['original'] ?? 'https://via.placeholder.com/100',
      rating: show['rating']?['average']?.toDouble() ?? 0.0,
    );
  }
}
