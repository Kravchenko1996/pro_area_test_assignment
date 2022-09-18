part of 'fact_cubit.dart';

@immutable
abstract class FactState {}

class FactInitial extends FactState {}

class FactLoading extends FactState {}

class FactLoaded extends FactState {
  final Fact fact;

  FactLoaded(this.fact);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is FactLoaded && o.fact == fact;
  }

  @override
  int get hashCode => fact.hashCode;
}
