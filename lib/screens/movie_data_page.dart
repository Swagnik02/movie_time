import 'package:flutter/material.dart';
import 'package:movie_time/models/movie_model.dart';

class MovieDetailsScreen extends StatelessWidget {
  final MovieData movie;

  const MovieDetailsScreen({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white60,
          ),
        ),
      ),
      body: Stack(
        children: [
          // Full-page background image
          Positioned.fill(
            child: Image.network(
              movie.imageUrl,
              fit: BoxFit.cover,
              color: Colors.black.withOpacity(0.5),
              colorBlendMode: BlendMode.darken,
            ),
          ),
          // Content overlay
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 50),
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 50), // Space below AppBar
                        // Movie title
                        Text(
                          movie.title,
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge
                              ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        // Genres
                        Text(
                          movie.genres.join(", "),
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  color: Colors.white70,
                                  fontStyle: FontStyle.italic),
                        ),
                        const SizedBox(height: 16),
                        // Movie description
                        Text(
                          "Overview",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          movie.summary,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: Colors.white),
                        ),
                        const SizedBox(height: 24),
                        // Rating and score
                        Row(
                          children: [
                            Text(
                              "Rating: ${movie.rating?.toStringAsFixed(1) ?? 'N/A'}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: Colors.white),
                            ),
                            const SizedBox(width: 16),
                            Text(
                              "Score: ${movie.score.toStringAsFixed(1)}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                        const SizedBox(height: 100), // Space above button
                      ],
                    ),
                  ),
                  // Watch button
                  Positioned(
                    bottom: 16,
                    left: 0,
                    right: 0,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 16),
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        // Handle "Watch Now" action
                      },
                      child: const Text(
                        "Watch Now",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
