import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:runpy/editor/bloc/run_bloc.dart';

class EditorPage extends StatelessWidget {
  EditorPage({Key? key}) : super(key: key);
  static String formName = 'code';

  final FormGroup formGroup = FormGroup({
    formName: FormControl<String?>(
      value: '',
      validators: [
        Validators.required,
      ],
    ),
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RunPy'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: <Widget>[
            ReactiveForm(
              formGroup: formGroup,
              child: Column(
                children: <Widget>[
                  ReactiveTextField(
                    formControlName: formName,
                    maxLines: 50,
                    minLines: 5,
                    decoration: const InputDecoration(
                      labelText: 'Write your code',
                    ),
                    validationMessages: (control) => {
                      'required': 'Code is required',
                    },
                  ),
                  BlocBuilder<RunBloc, RunState>(
                    builder: (context, state) {
                      if (state is RunLoading) {
                        return const CircularProgressIndicator();
                      }
                      return ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<RunBloc>(context).add(
                            PressRunEvent(
                              code: formGroup.control(formName).value,
                            ),
                          );
                        },
                        child: const Text('Run'),
                      );
                    },
                  ),
                  BlocBuilder<RunBloc, RunState>(
                    builder: (context, state) {
                      if (state is RunLoaded) {
                        return Text(state.response);
                      }
                      return const Text('Aun no compilo');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
