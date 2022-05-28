import 'package:flutter/material.dart';
import 'package:flutter_web_test_for_smartphone/providers/count_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TabWrapWidget extends HookConsumerWidget {
  TabWrapWidget({Key? key}) : super(key: key);
  final tabs = <Tab>[
    const Tab(text: 'myself', icon: Icon(Icons.person)),
    const Tab(text: 'opponent', icon: Icon(Icons.person_outline))
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: tabs.length,
      child: Column(
        children: <Widget>[
          Ink(
            color: Colors.blue,
            child: TabBar(tabs: tabs),
          ),
          Expanded(
            child: TabBarView(
              children: [
                Center(
                  child: Text(
                    'This is the ${ref.watch(countProvider)} tab',
                    style: const TextStyle(fontSize: 36),
                  ),
                ),
                const Center(
                  child: Text(
                    'This is the  tab',
                    style: TextStyle(fontSize: 36),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
