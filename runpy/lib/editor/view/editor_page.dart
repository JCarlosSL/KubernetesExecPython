import 'package:code_editor/code_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:runpy/editor/bloc/run_bloc.dart';
import 'package:runpy/global.dart';

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
  final myController = TextEditingController(text: "print('Hello world!')");
  List<FileEditor> files = [
    FileEditor(
      name: "test.py",
      language: "python",
      code: "print('Hello world!')",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    EditorModel model = EditorModel(
      files: files,
      styleOptions: EditorModelStyleOptions(
        fontSize: 13,
        editorColor: Global.primary,
        toolbarOptions: const ToolbarOptions(),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('RunPy'),
      ),
      backgroundColor: Global.primary,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ReactiveForm(
                formGroup: formGroup,
                child: Column(
                  children: <Widget>[
                    // ReactiveTextField(
                    //   formControlName: formName,
                    //   maxLines: 50,
                    //   minLines: 5,
                    //   decoration: const InputDecoration(
                    //     labelText: 'Write your code',
                    //   ),
                    //   validationMessages: (control) => {
                    //     'required': 'Code is required',
                    //   },
                    // ),
                    SizedBox(
                      // height: 300,
                      child: CodeEditor(
                        model: model,
                        edit: true,
                        disableNavigationbar: false,
                        onSubmit: (_, code) {
                          print('#############');
                          print(code);
                          BlocProvider.of<RunBloc>(context).add(
                            PressRunEvent(
                              code: code ?? "print('hello')",
                            ),
                          );
                        },
                        textEditingController: myController,
                      ),
                    ),
                    BlocBuilder<RunBloc, RunState>(
                      builder: (context, state) {
                        if (state is RunLoading) {
                          return Column(
                            children: [
                              const CircularProgressIndicator(),
                              const SizedBox(height: 5),
                              ElevatedButton(
                                onPressed: () {
                                  BlocProvider.of<RunBloc>(context).add(
                                    PressStopEvent(),
                                  );
                                },
                                child: const Text('Stop'),
                              ),
                            ],
                          );
                        }
                        return const SizedBox();
                        // ElevatedButton(
                        //   onPressed: () {
                        //     print(myController.text);
                        //     // BlocProvider.of<RunBloc>(context).add(
                        //     //   PressRunEvent(
                        //     //     // code: formGroup.control(formName).value,
                        //     //     // code: myController.text,
                        //     //   ),
                        //     // );
                        //   },
                        //   child: const Text('Run'),
                        // );
                      },
                    ),
                    const SizedBox(height: 10),
                    BlocBuilder<RunBloc, RunState>(
                      builder: (context, state) {
                        if (state is RunLoaded) {
                          return Text(state.response);
                        }
                        return const Text('You haven\'t yet run any code');
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
