import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/fact/fact_rest_client.dart';
import '../../repository/fact/fact_repository.dart';

part 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit(this._factRepository) : super(HistoryInitial());

  final FactRepository _factRepository;

  void getCachedFacts() async {
    try {
      emit(HistoryLoading());
      await Future.delayed(Duration.zero);
      final facts = _factRepository.getCachedFacts();
      emit(HistoryLoaded(facts));
    } catch (e) {
      debugPrint('error => $e');
    }
  }
}
