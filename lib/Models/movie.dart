
class Movie {
  String title;
  String original_title;
  String overview;
  String poster_path;
  String release_date;
  double vote_average;
  String backdrop_path;

  Movie({
    required this.title,
    required this.original_title,
    required this.overview,
    required this.poster_path,
    required this.release_date,
    required this.vote_average,
    required this.backdrop_path,
  });

  factory Movie.fromJson(Map<String, dynamic> json){
    return Movie(
        title: json['title'],
        original_title: json['original_title'],
        overview: json['overview'],
        poster_path: json['poster_path'],
        release_date: json['release_date'],

        backdrop_path: json['backdrop_path'],
        vote_average: json["vote_average"].toDouble(),
    );
  }

}

