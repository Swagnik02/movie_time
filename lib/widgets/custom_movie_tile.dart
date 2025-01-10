import 'package:flutter/material.dart';
import 'package:movie_time/models/movie_model.dart';
import 'package:movie_time/screens/movie_data_page.dart';

class MovieTile extends StatelessWidget {
  const MovieTile({
    super.key,
    required this.movie,
  });

  final MovieData movie;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => MovieDetailsScreen(movie: movie),
          ),
        );
      },
      child: Container(
        width: 130, // Width of each movie tile
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                movie.imageUrl,
                height: 150,
                width: 130,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.broken_image, size: 150),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              movie.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
