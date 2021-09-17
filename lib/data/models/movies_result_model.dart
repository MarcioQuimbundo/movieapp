import 'dart:convert';

import 'movie_model.dart';

MoviesResultModel moviesResultModelFromJson(String str) =>
    MoviesResultModel.fromJson(json.decode(str));

String moviesResultModelToJson(MoviesResultModel data) =>
    json.encode(data.toJson());

class MoviesResultModel {
  MoviesResultModel({
    this.movies,
  });

  List<MovieModel> movies;

  factory MoviesResultModel.fromJson(Map<String, dynamic> json) =>
      MoviesResultModel(
        movies:
            List<MovieModel>.from(json["results"].map((x) => MovieModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(movies.map((x) => x.toJson())),
      };
}

