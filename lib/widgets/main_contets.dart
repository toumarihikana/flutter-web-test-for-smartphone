import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/count_provider.dart';
import 'tab_wrapper.dart';

class MainContents extends HookConsumerWidget {
  const MainContents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // build メソッド内でフックを使用できます。
    final state = useState(0);

    // `ref` オブジェクトを使ってプロバイダを監視することもできます。
    final counter = ref.watch(countProvider);
    return TabWrapWidget();
    // Center(
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: <Widget>[
    //       const Text(
    //         'You have pushed the button this many times:',
    //       ),
    //       const Text(
    //         '別ファイル:',
    //       ),
    //       Text(
    //         counter.toString(),
    //         style: Theme.of(context).textTheme.headline4,
    //       ),
    //     ],
    //   ),
    // );
  }
}
