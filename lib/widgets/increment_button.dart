import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_web_test_for_smartphone/providers/count_provider.dart';
import 'package:flutter_web_test_for_smartphone/providers/flat_model_provider.dart';
import 'package:flutter_web_test_for_smartphone/providers/tab_index_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/str_list_provider.dart';
import 'dialogs/text_input.dart';

class IncrementButton extends HookConsumerWidget {
  IncrementButton({Key? key}) : super(key: key);

  final c = useState(0);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton(
      onPressed: (() => tapAction(context, ref)),
      tooltip: 'External Increment',
      child: const Icon(Icons.add),
    );
  }

  Future<void> tapAction(BuildContext context, WidgetRef ref) async {
    // ダイアログの外をタップするとダイアログから文字が帰ってこないのでfailになる。
    // String? name = await showEditDialog(context, '初期値') ?? 'fail';
    var builder = TextEditDialog.builder("Add Board");
    builder.submit = "Create";
    var boardName = await builder.build().show(context);
    ref.read(flatModelrovider.notifier).changeModel(boardName!);
    if (ref.read(tabIndexProvider) == 0) {
      ref.read(countProvider.notifier).increment();
    } else if (ref.read(tabIndexProvider) == 1) {
      c.value++;
      ref.read(strListProvider.notifier).add(str: c.value.toString());
    }
  }
}
