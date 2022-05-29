import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_web_test_for_smartphone/providers/count_provider.dart';
import 'package:flutter_web_test_for_smartphone/widgets/increment_button.dart';
import 'package:flutter_web_test_for_smartphone/widgets/main_contets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'platform/export/url_strategy_export.dart';
import 'providers/flat_model_provider.dart';
import 'providers/str_list_provider.dart';
import 'providers/tab_index_provider.dart';
import 'widgets/bottom_app_bar.dart';
import 'widgets/dialogs/text_input.dart';

void main() {
  commonSetUrlStrategy();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        routes: {
          '/': (context) =>
              MyHomePage(title: 'Flutter Demo Home Page with named')
        },
        initialRoute: '/'
        // home: const MyHomePage(title: 'Flutter Demo Home Page'),
        );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

class MyHomePage extends HookConsumerWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;
  int c = 0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: const SafeArea(
        child: MainContents(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() => tapAction(context, ref)),
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
      c++;
      ref.read(strListProvider.notifier).add(str: c.toString());
    }
  }
}
