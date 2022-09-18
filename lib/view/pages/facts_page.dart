import 'package:cat_trivia/repository/fact/fact_repository.dart';
import 'package:cat_trivia/utils/convert_date.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/history/history_cubit.dart';
import '../../model/fact/fact_rest_client.dart';

class FactsPage extends StatelessWidget {
  const FactsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Facts History'),
      ),
      body: BlocProvider(
        create: (_) => HistoryCubit($factRepo),
        child: Container(
          color: Colors.blueGrey,
          padding: const EdgeInsets.only(bottom: 8),
          child: BlocBuilder<HistoryCubit, HistoryState>(
            builder: (context, state) {
              if (state is HistoryInitial) {
                context.read<HistoryCubit>().getCachedFacts();
              } else if (state is HistoryLoaded) {
                return ListView.builder(
                  itemCount: state.facts.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    Fact fact = state.facts[index];
                    return Card(
                      margin: const EdgeInsets.only(top: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ListTile(
                        title: Text(fact.fact),
                        subtitle: Text(getLocaleDate(fact.createdAt!)),
                      ),
                    );
                  },
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
