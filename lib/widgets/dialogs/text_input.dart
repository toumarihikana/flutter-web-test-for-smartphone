import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EditTextDialogBuilder {
  String title;
  String submit = "Submit";
  String cancel = "Cancel";
  String initialValue = "";

  EditTextDialogBuilder(this.title);

  TextEditDialog build() {
    return TextEditDialog._builder(this);
  }
}

class TextEditDialog extends HookConsumerWidget {
  // final String initStr;
  // final BuildContext context1;
  // const TextEditDialog(
  //     {required this.context1, required this.initStr, Key? key})
  //     : super(key: key);
  final String title;
  final String cancel;
  final String submit;
  final String initialValue;
  final TextEditingController _textEditingController;

  TextEditDialog._builder(EditTextDialogBuilder builder)
      : title = builder.title,
        submit = builder.submit,
        cancel = builder.cancel,
        initialValue = builder.initialValue,
        _textEditingController =
            TextEditingController(text: builder.initialValue);

  static EditTextDialogBuilder builder(String title) {
    return EditTextDialogBuilder(title);
  }

  Future<String?> show(BuildContext context) async {
    return showDialog<String>(
        context: context,
        builder: (context) {
          return this;
        });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final focusNode = useFocusNode();
    // final textEditingController = useTextEditingController(text: initStr);
    return AlertDialog(
      content: TextFormField(
        autofocus: true,
        focusNode: focusNode,
        controller: _textEditingController,
        onFieldSubmitted: (_) {
          Navigator.of(context).pop(_textEditingController.text);
        },
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(_textEditingController.text);
          },
          child: Text(submit),
        ),
        // TextButton(
        //   onPressed: () {
        //     Navigator.of(context).popUntil(ModalRoute.withName('/'));
        //   },
        //   child: const Text("決定2"),
        // )
      ],
    );
  }
}
