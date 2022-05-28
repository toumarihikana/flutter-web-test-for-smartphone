import 'package:flutter/material.dart';
import 'package:flutter_web_test_for_smartphone/providers/tab_index_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BottomBar extends HookConsumerWidget {
  const BottomBar({Key? key, required this.stateCheckStr}) : super(key: key);
  final String stateCheckStr;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      color: Colors.blue,
      child: IconTheme(
        data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
        child: Row(
          children: <Widget>[
            IconButton(
              tooltip: 'Open navigation menu',
              icon: const Icon(Icons.menu),
              onPressed: () {},
            ),
            IconButton(
              tooltip: 'Search',
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
            IconButton(
              tooltip: 'Favorite',
              icon: const Icon(Icons.favorite),
              onPressed: () {},
            ),
            Text.rich(TextSpan(text: stateCheckStr)),
            const Icon(Icons.work_history),
            Text.rich(TextSpan(text: ref.watch(tabIndexProvider).toString())),
          ],
        ),
      ),
    );
  }
}
