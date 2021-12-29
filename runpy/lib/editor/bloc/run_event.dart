part of 'run_bloc.dart';

@immutable
abstract class RunEvent {

}

class PressRunEvent extends RunEvent{
  final String code;

  PressRunEvent({required this.code});
}

class PressStopEvent extends RunEvent{
  PressStopEvent();
}

class CompiledEvent extends RunEvent{
  final String result;
  String get getResult => result;
  CompiledEvent({required this.result});
}
