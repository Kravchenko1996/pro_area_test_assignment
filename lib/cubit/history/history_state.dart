part of 'history_cubit.dart';

@immutable
abstract class HistoryState {}

class HistoryInitial extends HistoryState {}

class HistoryLoading extends HistoryState {}

class HistoryLoaded extends HistoryState {
  final List<Fact> facts;

  HistoryLoaded(this.facts);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is HistoryLoaded && o.facts == facts;
  }

  @override
  int get hashCode => facts.hashCode;
}
