import 'package:cat_trivia/utils/get_random_date.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
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
@HiveType(typeId: 0)
class Fact {
  @HiveField(0)
  String fact;

  @HiveField(1)
  DateTime? createdAt;

  Fact({required this.fact, this.createdAt}) {
    createdAt = getRandomDate();
  }

  factory Fact.fromJson(Map<String, dynamic> json) => _$FactFromJson(json);

  Map<String, dynamic> toJson() => _$FactToJson(this);
}
