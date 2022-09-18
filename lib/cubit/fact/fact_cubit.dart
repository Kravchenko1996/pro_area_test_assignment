import 'package:cat_trivia/model/fact/fact_rest_client.dart';
import 'package:cat_trivia/repository/fact/fact_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'fact_state.dart';

class FactCubit extends Cubit<FactState> {
  FactCubit(this._factRepository) : super(FactInitial());

  final FactRepository _factRepository;

  Future<void> getFact() async {
    try {
      emit(FactLoading());
      final fact = await _factRepository.fetchFact();
      emit(FactLoaded(fact));
    } catch (e) {
      debugPrint('error => $e');
    }
  }
}
