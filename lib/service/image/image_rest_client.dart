import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';

part 'image_rest_client.g.dart';

@RestApi(baseUrl: "https://cataas.com")
abstract class ImageRestClient {
  factory ImageRestClient(Dio dio, {String baseUrl}) = _ImageRestClient;

  @GET("/cat")
  Future<Image> getImage();
}

@JsonSerializable()
class Image {
  String path;

  Image({required this.path});

  factory Image.fromJson(Map<String, dynamic> json) => _$ImageFromJson(json);

  Map<String, dynamic> toJson() => _$ImageToJson(this);
}
