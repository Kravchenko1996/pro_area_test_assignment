import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';

part 'fact_rest_client.g.dart';

@RestApi(baseUrl: "https://catfact.ninja")
abstract class FactRestClient {
  factory FactRestClient(Dio dio, {String baseUrl}) = _FactRestClient;

  @GET("/fact")
  Future<Fact> getFact();
}

@JsonSerializable()
class Fact {
  String fact;

  Fact({required this.fact});

  factory Fact.fromJson(Map<String, dynamic> json) => _$FactFromJson(json);

  Map<String, dynamic> toJson() => _$FactToJson(this);
}
