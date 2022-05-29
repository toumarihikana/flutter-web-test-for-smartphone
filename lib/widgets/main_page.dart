import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/count_provider.dart';
import '../providers/flat_model_provider.dart';
import '../providers/str_list_provider.dart';
import '../providers/tab_index_provider.dart';
import 'bottom_app_bar.dart';
import 'dialogs/text_input.dart';
import 'main_contets.dart';

class MainPage extends HookConsumerWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('title'),
      ),
      body: const SafeArea(
        child: MainContents(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() async {
          var builder = EditTextDialog.builder("Add Board");
          builder.submit = "Create1";
          var boardName = await builder.build().show(context);
          if (boardName == null || boardName.isEmpty) {
            return;
          }
        }),
        tooltip: 'External Increment',
        child: const Icon(Icons.add),
      ),
      // IncrementButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
      bottomNavigationBar: BottomBar(
        stateCheckStr: ref.watch(countProvider).toString(),
      ),
    );
  }

  // Future<void> tapAction(BuildContext context, WidgetRef ref) async {
  //   // ダイアログの外をタップするとダイアログから文字が帰ってこないのでfailになる。
  //   // String? name = await showEditDialog(context, '初期値') ?? 'fail';
  //   var builder = EditTextDialog.builder("Add Board");
  //   builder.submit = "Create";
  //   var boardName = await builder.build().show(context);
  //   // ref.read(flatModelrovider.notifier).changeModel(boardName!);
  //   if (ref.read(tabIndexProvider) == 0) {
  //     ref.read(countProvider.notifier).increment();
  //   } else if (ref.read(tabIndexProvider) == 1) {
  //     //   c++;
  //     //   ref.read(strListProvider.notifier).add(str: c.toString());
  //   }
  // }
}
