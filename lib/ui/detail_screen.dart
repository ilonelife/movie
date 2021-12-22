import 'package:flutter/material.dart';

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
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 210,
                        height: 280,
                        child: Image.network(
                          'https://image.tmdb.org/t/p/original' +
                              backdropPath.toString(),
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '개봉일 ' + releaseDate,
                              style: const TextStyle(fontSize: 12),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 65,
                                  child: TextButton.icon(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.check,
                                      size: 12.0,
                                      color: Colors.white,
                                    ),
                                    label: Text(
                                      voteCount.toString(),
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    style: TextButton.styleFrom(
                                        backgroundColor: Colors.blue),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                SizedBox(
                                  width: 65,
                                  child: TextButton.icon(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.star,
                                      size: 12.0,
                                      color: Colors.white,
                                    ),
                                    label: Text(
                                      voteAverage.toString(),
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    style: TextButton.styleFrom(
                                        backgroundColor: Colors.blue),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  overView,
                  maxLines: 7,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ));
  }
}
