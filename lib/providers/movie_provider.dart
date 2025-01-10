import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_time/models/movie_model.dart';

const restfulApi = 'https://api.tvmaze.com/';

class MovieProvider with ChangeNotifier {
  List<MovieData> _movieList = [];
  List<MovieData> get movieList => _movieList;
  MovieData? _selectedMovie;
  MovieData? get selectedMovie => _selectedMovie;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  // Fetch a list of movies
  Future<void> fetchMovieList() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Fetch movies from API
      final response =
          await http.get(Uri.parse('${restfulApi}search/shows?q=all'));
      if (response.statusCode == 200) {
        final rawData = jsonDecode(response.body);
        List<MovieData> fetchedMovieList = (rawData as List)
            .map((movieJson) => MovieData.fromJson(movieJson))
            .toList();

        _movieList = fetchedMovieList;
        notifyListeners();
      } else {
        throw Exception('Failed to load movie list');
      }
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Search for movies by term
  Future<void> searchMovies(String searchTerm) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response =
          await http.get(Uri.parse('${restfulApi}search/shows?q=$searchTerm'));
      if (response.statusCode == 200) {
        final rawData = jsonDecode(response.body);
        List<MovieData> searchedMovies = (rawData as List)
            .map((movieJson) => MovieData.fromJson(movieJson))
            .toList();

        _movieList = searchedMovies;
        notifyListeners();
      } else {
        throw Exception('Failed to load search results');
      }
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
