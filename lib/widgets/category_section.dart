import 'package:flutter/material.dart';
import 'package:movie_time/models/movie_model.dart';
import 'package:movie_time/widgets/custom_movie_tile.dart';

Widget buildCategorySection(BuildContext context,
    {required String title, required List<MovieData> movies}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      SizedBox(
        height: 200,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: movies.length,
          itemBuilder: (context, index) {
            return MovieTile(movie: movies[index]);
          },
        ),
      ),
    ],
  );
}
