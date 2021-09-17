import 'package:movieapp/domain/entities/movie_entity.dart';

class MovieModel extends MovieEntity {
  MovieModel({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.originalLanguage,
    this.originalTitle,
    this.posterPath,
    this.id,
    this.video,
    this.voteAverage,
    this.voteCount,
    this.releaseDate,
    this.title,
    this.overview,
    this.popularity,
    this.mediaType,
  }) : super(id: id, title: title, backdropPath: backdropPath, posterPath: posterPath, releaseDate: releaseDate, voteAverage: voteAverage, overview: overview);

  final bool adult;
  final String backdropPath;
  final List<int> genreIds;
  final OriginalLanguage originalLanguage;
  final String originalTitle;
  final String posterPath;
  final int id;
  final bool video;
  final double voteAverage;
  final int voteCount;
  final DateTime releaseDate;
  final String title;
  final String overview;
  final double popularity;
  final MediaType mediaType;

  factory MovieModel.fromJson(Map<String, dynamic> json) => MovieModel(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        originalLanguage: originalLanguageValues.map[json["original_language"]],
        originalTitle: json["original_title"],
        posterPath: json["poster_path"],
        id: json["id"],
        video: json["video"],
        voteAverage: json["vote_average"]?.toDouble() ?? 0.0,
        voteCount: json["vote_count"],
        releaseDate: DateTime.parse(json["release_date"]),
        title: json["title"],
        overview: json["overview"],
        popularity: json["popularity"]?.toDouble() ?? 0.0,
        mediaType: mediaTypeValues.map[json["media_type"]],
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "original_language": originalLanguageValues.reverse[originalLanguage],
        "original_title": originalTitle,
        "poster_path": posterPath,
        "id": id,
        "video": video,
        "vote_average": voteAverage,
        "vote_count": voteCount,
        "release_date":
            "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
        "title": title,
        "overview": overview,
        "popularity": popularity,
        "media_type": mediaTypeValues.reverse[mediaType],
      };
}

enum MediaType { MOVIE }

final mediaTypeValues = EnumValues({"movie": MediaType.MOVIE});

enum OriginalLanguage { EN }

final originalLanguageValues = EnumValues({"en": OriginalLanguage.EN});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
