import 'package:flutter/material.dart';
import 'package:flutter_web_test_for_smartphone/providers/count_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class IncrementButton extends HookConsumerWidget {
  const IncrementButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton(
      onPressed: (() => ref.read(countProvider.notifier).increment()),
      tooltip: 'External Increment',
      child: const Icon(Icons.add),
    );
  }
}
