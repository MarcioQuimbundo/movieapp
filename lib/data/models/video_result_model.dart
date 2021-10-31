// To parse this JSON data, do
//
//     final videoResultModel = videoResultModelFromJson(jsonString);

import 'dart:convert';

import 'package:movieapp/data/models/video_model.dart';

VideoResultModel videoResultModelFromJson(String str) => VideoResultModel.fromJson(json.decode(str));

String videoResultModelToJson(VideoResultModel data) => json.encode(data.toJson());

class VideoResultModel {
    VideoResultModel({
        this.id,
        this.videos,
    });

    final int id;
    final List<VideoModel> videos;

    factory VideoResultModel.fromJson(Map<String, dynamic> json) => VideoResultModel(
        id: json["id"],
        videos: List<VideoModel>.from(json["results"].map((x) => VideoModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "results": List<dynamic>.from(videos.map((x) => x.toJson())),
    };
}

