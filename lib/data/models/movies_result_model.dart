import 'dart:convert';

import 'movie_model.dart';

MoviesResultModel moviesResultModelFromJson(String str) =>
    MoviesResultModel.fromJson(json.decode(str));

String moviesResultModelToJson(MoviesResultModel data) =>
    json.encode(data.toJson());

class MoviesResultModel {
  MoviesResultModel({
    this.results,
  });

  List<MovieModel> results;

  factory MoviesResultModel.fromJson(Map<String, dynamic> json) =>
      MoviesResultModel(
        results:
            List<MovieModel>.from(json["results"].map((x) => MovieModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

