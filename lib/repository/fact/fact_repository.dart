import 'package:cat_trivia/api_clients.dart';
import 'package:hive/hive.dart';

import '../../model/fact/fact_rest_client.dart';

final $factRepo = FactRepository($factClient);

class FactRepository {
  FactRepository(this.client);

  final FactRestClient client;

  Future<Fact> fetchFact() async {
    Fact fact = await client.getFact();
    Hive.box<Fact>('facts').add(fact);
    return fact;
  }

  List<Fact> getCachedFacts() {
    return Hive.box<Fact>('facts').toMap().values.toList();
  }
}
