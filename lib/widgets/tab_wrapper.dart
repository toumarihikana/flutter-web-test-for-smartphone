import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_use/flutter_use.dart';
import 'package:flutter_web_test_for_smartphone/providers/count_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/tab_index_provider.dart';
import 'tab2_content.dart';

class TabWrapWidget extends HookConsumerWidget {
  TabWrapWidget({Key? key}) : super(key: key);
  final tabs = <Tab>[
    const Tab(text: 'myself', icon: Icon(Icons.person)),
    const Tab(text: 'opponent', icon: Icon(Icons.person_outline))
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTabController(initialLength: tabs.length);

    useEffectOnce(() {
      controller.addListener(() {
        changeTab(ref, controller.index);
      });
      return null;
    });

    return Column(
      children: <Widget>[
        Ink(
          color: Colors.blue,
          child: TabBar(
            controller: controller,
            tabs: tabs,
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: controller,
            children: [
              Column(
                children: <Widget>[
                  Center(
                    child: Text(
                      'This is the ${ref.watch(countProvider)} tab',
                      style: const TextStyle(fontSize: 36),
                    ),
                  ),
                  Center(
                    child: Text(
                      'This is the ${ref.watch(countProvider)} tab',
                      style: const TextStyle(fontSize: 36),
                    ),
                  ),
                ],
              ),
              const Center(
                child: Tab2Content(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void changeTab(WidgetRef ref, int index) {
    ref.read(tabIndexProvider.notifier).changeTabIndex(index);
  }
}
