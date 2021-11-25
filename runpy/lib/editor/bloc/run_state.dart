part of 'run_bloc.dart';

@immutable
abstract class RunState {
  final String response;
  final bool isLoading;

  const RunState({required this.response, required this.isLoading,});
}

class RunInitial extends RunState {
  const RunInitial({required String response}) : super(response: response, isLoading: false);
}

class RunLoading extends RunState {
  const RunLoading({required String response}) : super(response: response, isLoading: true);
}

class RunLoaded extends RunState {
  const RunLoaded({required String response}) : super(response: response, isLoading: false);
}

