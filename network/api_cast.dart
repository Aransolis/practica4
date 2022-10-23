import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/cast_movie_model.dart';

class ApiMovieCast {
  Future<List<CastMovieModel>?> getMovieCast(int movieId) async {
    var URL = Uri.parse(
        'https://api.themoviedb.org/3/movie/$movieId/credits?api_key=18cac3ce0cd5ef9b23fcee3afa36bfc5&language=en-US');
    final response = await http.get(URL);
    if (response.statusCode == 200) {
      var movieCast = jsonDecode(response.body)['cast'] as List;
      List<CastMovieModel> castList =
          movieCast.map((movie) => CastMovieModel.fromMap(movie)).toList();
      return castList;
    } else {
      return null;
    }
  }
}
