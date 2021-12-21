import 'package:flutter/material.dart';
import 'package:movie/data/movie_api.dart';

class DetailScreen extends StatelessWidget {
  final String title;
  final String overView;
  final String posterPath;
  final String? backdropPath;
  final String releaseDate;
  final num voteAverage;
  final int voteCount;

  const DetailScreen({
    Key? key,
    required this.title,
    required this.overView,
    required this.posterPath,
    required this.backdropPath,
    required this.releaseDate,
    required this.voteAverage,
    required this.voteCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _api = MovieApi();

    return Scaffold(
        appBar: AppBar(
          title: Text(''),
        ),
        body: Column(
          children: [
            Text(''),
            Row(),
            Text(''),
          ],
        ));
  }
}
