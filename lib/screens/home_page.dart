import 'package:flutter/material.dart';
import 'package:movie_time/providers/movie_provider.dart';
import 'package:movie_time/screens/search_page.dart';
import 'package:movie_time/widgets/category_section.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomePage(),
    const SearchPage(),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchMovieList();
    });
  }

  void _fetchMovieList() {
    Provider.of<MovieProvider>(context, listen: false).fetchMovieList();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'MovieTime',
          style: Theme.of(context)
              .textTheme
              .headlineLarge
              ?.copyWith(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchPage()),
              );
            },
          ),
        ],
      ),
      body: _selectedIndex == 0
          ? Consumer<MovieProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (provider.errorMessage != null) {
                  return Center(child: Text('Error: ${provider.errorMessage}'));
                } else if (provider.movieList.isNotEmpty) {
                  return ListView(
                    children: [
                      buildCategorySection(
                        context,
                        title: "Trending Now",
                        movies: provider.movieList,
                      ),
                      buildCategorySection(
                        context,
                        title: "Top Rated",
                        movies: provider.movieList.reversed.toList(),
                      ),
                      buildCategorySection(
                        context,
                        title: "New Releases",
                        movies: provider.movieList,
                      ),
                    ],
                  );
                } else {
                  return const Center(child: Text('No data available'));
                }
              },
            )
          : const SearchPage(),
      backgroundColor: Colors.black,
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
        ],
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
