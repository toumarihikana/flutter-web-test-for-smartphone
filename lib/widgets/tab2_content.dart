import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/str_list_provider.dart';

class Tab2Content extends HookConsumerWidget {
  const Tab2Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strList = ref.watch(strListProvider);
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            for (int i = 0; i < strList.length; i++)
              Card(
                child: Text(
                  strList[i],
                  style: const TextStyle(fontSize: 36),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
