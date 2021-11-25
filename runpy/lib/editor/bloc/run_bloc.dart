import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:runpy/global.dart';

part 'run_event.dart';
part 'run_state.dart';

class RunBloc extends Bloc<RunEvent, RunState> {
  RunBloc() : super(const RunInitial(response: '')) {
    on<RunEvent>((event, emit) {
      if (event is PressRunEvent) {
        onPressRun(event.code);
        emit(RunLoading(response: event.code));
      } else if (event is CompiledEvent) {
        emit(RunLoaded(response: event.result));
      } else if (event is PressStopEvent){
        emit(const RunInitial(response: ''));
      }
      // switch (RunEvent) {
      //   case PressRunEvent:
      //     emit(RunLoading(response: event.code));
      //     break;
      //   case CompiledEvent:
      //     emit(RunLoaded(response: event.result));
      //     break;
      //   default:
      // }
    });
  }

  void onPressRun(String code) async {
    var url = Uri.parse(Global.url);
    var response = await http.post(url, body: {"code": code});
    var result = jsonDecode(response.body);
    add(CompiledEvent(result: result['response']));
  }
}
