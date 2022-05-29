import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

class EditTextDialogBuilder {
  String title;
  String submit = "Submit";
  String cancel = "Cancel";
  String initialValue = "";

  EditTextDialogBuilder(this.title);

  EditTextDialog build() {
    return EditTextDialog._builder(this);
  }
}

class EditTextDialog extends HookConsumerWidget {
  final String title;
  final String cancel;
  final String submit;
  final String initialValue;
  final TextEditingController _textEditingController;

  EditTextDialog._builder(EditTextDialogBuilder builder)
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
    return AlertDialog(
      title: Text(title + 'autofocus'),
      content: TextFormField(
        controller: _textEditingController,
        // autofocus: true,
        focusNode: focusNode,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (v) {
          if (v == null || v.isEmpty) {
            return "Empty!";
          }
          return null;
        },
        onFieldSubmitted: (_) {
          Navigator.of(context).pop(_textEditingController.text);
        },
      ),
      actions: [
        OutlinedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(cancel),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(_textEditingController.text);
          },
          child: Text(submit),
        ),
      ],
    );
  }
}
