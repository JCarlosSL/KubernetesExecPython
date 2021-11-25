import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

part 'run_event.dart';
part 'run_state.dart';

class RunBloc extends Bloc<RunEvent, RunState> {
  RunBloc() : super(const RunInitial(response: '')) {
    on<RunEvent>((event, emit) {
      // TODO: implement event handler
      if (event is PressRunEvent) {
        onPressRun(event.code);
        emit(RunLoading(response: event.code));
      } else if (event is CompiledEvent) {
        emit(RunLoaded(response: event.result));
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
    var url = Uri.parse('http://127.0.0.1:8000/python');
    // var url = Uri.parse('https://simpsons-quotes-api.herokuapp.com/quotes');
    print("%%%%%%%%%%%mandandooo%%%%%%%");
    // var response = await http.post(url, );
    var response = await http.get(url, );
    print(response);
    add(CompiledEvent(result: response.body));
  }
}
