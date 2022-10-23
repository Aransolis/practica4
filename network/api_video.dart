import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/video_model.dart';

class ApiVideoMovie {
  Future<VideoMovieModel?> getMovieTrailer(String id) async {
    var URL = Uri.parse(
        'https://api.themoviedb.org/3/movie/$id/videos?api_key=18cac3ce0cd5ef9b23fcee3afa36bfc5&language=es-US');
    final response = await http.get(URL);

    if (response.statusCode == 200) {
      var trailer = jsonDecode(response.body);
      print(trailer['results'][0]['key']);
      var test =
          trailer['results'].where((i) => i['type'] == 'Trailer').toList();
      print(test[0]);
      VideoMovieModel movieTrailer =
          VideoMovieModel.fromMap(test[0] ?? trailer['results'][0]);
      return movieTrailer;
    } else {
      return null;
    }
  }
}
