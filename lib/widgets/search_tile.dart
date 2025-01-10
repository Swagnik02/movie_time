import 'package:flutter/material.dart';
import 'package:movie_time/models/movie_model.dart';
import 'package:movie_time/screens/movie_data_page.dart';

class SearchTile extends StatelessWidget {
  const SearchTile({
    super.key,
    required this.movie,
  });

  final MovieData movie;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: movie.imageUrl != null
          ? Image.network(
              movie.imageUrl!,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            )
          : const Icon(
              Icons.movie,
              color: Colors.white,
              size: 50,
            ),
      title: Text(
        movie.title ?? 'Unknown',
        style: const TextStyle(color: Colors.white),
      ),
      subtitle: Text(
        movie.genres?.join(', ') ?? 'Unknown genres',
        style: const TextStyle(color: Colors.white70),
      ),
      trailing: Text(
        'Rating: ${movie.rating ?? 'N/A'}',
        style: const TextStyle(color: Colors.white),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => MovieDetailsScreen(movie: movie),
          ),
        );
      },
    );
  }
}
