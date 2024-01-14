
class Movie {
  int id;
  String title;
  String original_title;
  String overview;
  String poster_path;
  String release_date;
  double vote_average;
  String backdrop_path;
  double vote_count;
  double popularity;

  Movie({
    required this.id,
    required this.title,
    required this.original_title,
    required this.overview,
    required this.poster_path,
    required this.release_date,
    required this.vote_average,
    required this.backdrop_path,
    required this.vote_count,
    required this.popularity,
  });

  factory Movie.fromJson(Map<String, dynamic> json){
    return Movie(
        id: json['id'] as int,
        title: json['title'] ,
        original_title: json['original_title'],
        overview: json['overview'],
        poster_path: json['poster_path'],
        release_date: json['release_date'],
        backdrop_path: json['backdrop_path'],
        vote_average: json["vote_average"].toDouble(),
        vote_count : json["vote_count"].toDouble(),
        popularity: json["popularity"].toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'overview': overview,
      'original_title' :original_title.length,
      'poster_path' : poster_path,
      'release_date' :release_date,
      'backdrop_path' : backdrop_path,
      'vote_average' : vote_average,
      'vote_count' : vote_count,
      'popularity' : popularity,
    };
  }

}

