import 'package:flutter/material.dart';

import '../models/popular_model.dart';

class CardCardPopularView extends StatelessWidget {
  final PopularModel popular;
  final Function? onTap;
  const CardCardPopularView({Key? key, required this.popular, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 2.0, top: 2.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black54,
              spreadRadius: 2,
              offset: Offset(0.0, 2.0),
              blurRadius: 2.5,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Stack(alignment: Alignment.bottomCenter, children: [
            Container(
              child: Hero(
                tag: popular.id.toString(),
                child: FadeInImage(
                  placeholder: AssetImage('assets/loading_movie.gif'),
                  image: NetworkImage(
                      'https://image.tmdb.org/t/p/w500/${popular.backdropPath}'),
                  fadeInDuration: Duration(milliseconds: 200),
                ),
              ),
            ),
            Opacity(
              opacity: 0.5,
              child: Container(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                height: 40.0,
                color: Colors.black,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${popular.title}",
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    IconButton(
                      onPressed: () {
                        print({popular.id});
                        Navigator.pushNamed(context, '/detail', arguments: {
                          'backdrop_path': popular.backdropPath,
                          'id': popular.id,
                          'original_language': popular.originalLanguage,
                          'original_title': popular.originalTitle,
                          'overview': popular.overview,
                          'popularity': popular.popularity,
                          'poster_path': popular.posterPath,
                          'title': popular.title,
                          'vote_average': popular.voteAverage,
                          'vote_count': popular.voteCount,
                        });
                      },
                      icon: Icon(
                        Icons.chevron_right,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
