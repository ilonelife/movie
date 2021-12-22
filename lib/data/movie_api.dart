import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie/model/movie.dart';

class MovieApi {
  Future<List<Movie>> fetchMovies(String query) async {
    // 참고용. 0.5 초 기다림
    await Future<void>.delayed(const Duration(milliseconds: 500));

    String url =
        'https://api.themoviedb.org/3/movie/upcoming?api_key=a64533e7ece6c72731da47c9c8bc691f&language=ko-KR&page=1';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // List jsonList = jsonDecode(response.body)['results'];
      // return jsonList.map((e) => Movie.fromJson(e)).toList();
      return Movie.listToMovie(jsonDecode(response.body)['results']);
    } else {
      throw Exception('Failed to load album');
    }
  }
}
