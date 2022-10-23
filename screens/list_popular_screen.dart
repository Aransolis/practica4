import 'package:flutter/material.dart';

import '../database/movie_database_helper.dart';
import '../models/popular_model.dart';
import '../network/popular_movies_api.dart';
import '../screens/card_popular.dart';

class ListPopularScreen extends StatefulWidget {
  const ListPopularScreen({Key? key}) : super(key: key);

  @override
  State<ListPopularScreen> createState() => _ListPopularScreenState();
}

class _ListPopularScreenState extends State<ListPopularScreen> {
  late Movie_Database_Helper _databaseHelper;
  PopularMoviesAPI popularAPI = PopularMoviesAPI();
  var tabIndex = 0;

  @override
  void initState() {
    super.initState();
    popularAPI = PopularMoviesAPI();
    _databaseHelper = Movie_Database_Helper();
  }

  @override
  Widget build(BuildContext context) {
    void _upDate() {
      setState(() {});
    }

    final _tabScreens = <Widget>[
      _buildPopularMovies(),
      _buildFavoriteMovies(_upDate),
    ];

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            tabIndex = index;
          });
        },
        currentIndex: tabIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.movie_filter_rounded),
            label: 'Popular',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_rounded),
            label: 'Favorites',
          ),
        ],
      ),
      appBar: AppBar(title: Text('Movies from API')),
      body: _tabScreens[tabIndex],
    );
  }

  Widget _buildFavoriteMovies(Function _upDate) {
    return FutureBuilder(
      future: _databaseHelper.getFavoritesMovies(),
      builder:
          (BuildContext context, AsyncSnapshot<List<PopularModel>?> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          if (snapshot.connectionState == ConnectionState.done) {
            return snapshot.data!.length != 0
                ? _listPopularMovies(snapshot.data, _upDate)
                : Center(
                    child: Text('No favorites movies'),
                  );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }
      },
    );
  }

  Widget _buildPopularMovies() {
    return FutureBuilder(
        future: popularAPI.getAllPopular(),
        builder: (BuildContext context,
            AsyncSnapshot<List<PopularModel>?> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error'),
            );
          } else {
            if (snapshot.connectionState == ConnectionState.done) {
              return _listPopularMovies(snapshot.data, null);
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }
        });
  }

  Widget _listPopularMovies(List<PopularModel>? data, Function? _upDate) {
    return ListView.separated(
      itemBuilder: (context, index) {
        PopularModel popularMoviesList = data![index];
        return CardCardPopularView(popular: popularMoviesList, onTap: _upDate);
      },
      separatorBuilder: (_, __) => Divider(
        height: 10,
      ),
      itemCount: data!.length,
    );
  }
}
