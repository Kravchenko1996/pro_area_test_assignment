import 'package:cat_trivia/service/fact/fact_rest_client.dart';
import 'package:cat_trivia/service/image/image_rest_client.dart';
import 'package:dio/dio.dart';

final Dio _dio = Dio();
final $factClient = FactRestClient(_dio);
final $imageClient = ImageRestClient(_dio);