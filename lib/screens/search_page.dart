import 'package:flutter/material.dart';
import 'package:movie_time/widgets/search_tile.dart';
import 'package:provider/provider.dart';
import 'package:movie_time/providers/movie_provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  void _searchMovies(String query) {
    if (query.isNotEmpty) {
      Provider.of<MovieProvider>(context, listen: false).searchMovies(query);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          onSubmitted: _searchMovies,
          decoration: const InputDecoration(
            hintText: 'Search movies...',
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.white54),
          ),
          style: const TextStyle(color: Colors.white),
          autofocus: true,
        ),
        backgroundColor: Colors.black,
      ),
      body: Consumer<MovieProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (provider.errorMessage != null) {
            return Center(child: Text('Error: ${provider.errorMessage}'));
          } else if (provider.movieList.isNotEmpty) {
            return ListView.builder(
              itemCount: provider.movieList.length,
              itemBuilder: (context, index) {
                final movie = provider.movieList[index];
                return SearchTile(movie: movie);
              },
            );
          } else {
            return const Center(child: Text('No results found'));
          }
        },
      ),
      backgroundColor: Colors.black,
    );
  }
}
