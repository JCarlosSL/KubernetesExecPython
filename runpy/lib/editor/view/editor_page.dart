import 'package:code_editor/code_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:rich_code_editor/rich_code_controller.dart';
import 'package:rich_code_editor/rich_code_field.dart';
import 'package:rich_code_editor/syntaxt_highlighter_base.dart';
import 'package:runpy/editor/bloc/run_bloc.dart';
import 'package:runpy/editor/view/dummy_syntax.dart';
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
    RichCodeEditingController? _rec;
    SyntaxHighlighterBase? _syntaxHighlighterBase;
    _syntaxHighlighterBase = DummySyntaxHighlighter();
    _rec = RichCodeEditingController(_syntaxHighlighterBase, text: '');

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
                    // SizedBox(height: 300, child: DemoCodeEditor()),
                    // Container(
                    //   height: 300.0,
                    //   margin: EdgeInsets.all(24.0),
                    //   padding: EdgeInsets.all(24.0),
                    //   decoration: BoxDecoration(
                    //     border: Border.all(color: Colors.grey),
                    //   ),
                    //   child: RichCodeField(
                    //     autofocus: true,
                    //     controller: _rec,
                    //     textCapitalization: TextCapitalization.none,
                    //     decoration: null,
                    //     syntaxHighlighter: _syntaxHighlighterBase,
                    //     maxLines: null,
                    //     onChanged: (String s) {},
                    //     onBackSpacePress: (TextEditingValue oldValue) {},
                    //     onEnterPress: (TextEditingValue oldValue) {
                    //       var result =
                    //           _syntaxHighlighterBase!.onEnterPress(oldValue);
                    //       if (result != null) {
                    //         _rec!.value = result;
                    //       }
                    //     },
                    //   ),
                    // ),
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

class DemoCodeEditor extends StatefulWidget {
  @override
  _DemoCodeEditorState createState() => _DemoCodeEditorState();
}

class _DemoCodeEditorState extends State<DemoCodeEditor> {
  RichCodeEditingController? _rec;
  SyntaxHighlighterBase? _syntaxHighlighterBase;

  @override
  void initState() {
    super.initState();
    _syntaxHighlighterBase = DummySyntaxHighlighter();
    _rec = RichCodeEditingController(_syntaxHighlighterBase, text: '');
  }

  @override
  void dispose() {
    //_richTextFieldState.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Dummy Editor"),
      ),
      body: Container(
          height: 300.0,
          margin: EdgeInsets.all(24.0),
          padding: EdgeInsets.all(24.0),
          decoration:
              new BoxDecoration(border: new Border.all(color: Colors.grey)),
          child: RichCodeField(
            autofocus: true,
            controller: _rec,
            textCapitalization: TextCapitalization.none,
            decoration: null,
            syntaxHighlighter: _syntaxHighlighterBase,
            maxLines: null,
            onChanged: (String s) {},
            onBackSpacePress: (TextEditingValue oldValue) {},
            onEnterPress: (TextEditingValue oldValue) {
              var result = _syntaxHighlighterBase!.onEnterPress(oldValue);
              if (result != null) {
                _rec!.value = result;
              }
            },
          )),
    );
  }
}
