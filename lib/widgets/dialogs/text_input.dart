import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TextEditDialog extends HookConsumerWidget {
  final String initStr;
  final BuildContext context1;
  const TextEditDialog(
      {required this.context1, required this.initStr, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final focusNode = useFocusNode();
    final textEditingController = useTextEditingController(text: initStr);
    return AlertDialog(
      content: TextFormField(
        autofocus: true,
        focusNode: focusNode,
        controller: textEditingController,
        onFieldSubmitted: (_) {
          Navigator.of(context).pop(textEditingController.text);
        },
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context, textEditingController.text);
          },
          child: const Text("決定"),
        )
      ],
    );
  }
}
