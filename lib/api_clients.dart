import 'package:dio/dio.dart';

import 'model/fact/fact_rest_client.dart';

final Dio _dio = Dio();
final $factClient = FactRestClient(_dio);