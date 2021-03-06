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
import 'widgets/main_page.dart';

void main() {
  commonSetUrlStrategy();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

final FutureProvider initialProvider = FutureProvider((ref) async {
  // await Dao().initialize();
  // final packageInfo = ref.read(ConfigProvider.packageInfoProvider).value;
  // var config = await Dao().config();
  // if (config != null) {
  //   ref.read(ConfigProvider.configProvider.notifier).state = config;
  // }
});

class MyApp extends HookConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var initial = ref.watch(initialProvider);
    return initial.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) {
        return Center(child: Text("$err \n Chrome plz!"));
      },
      data: (config) {
        // var themeModeValue = ref.watch(
        //     ConfigProvider.configProvider.select((value) => value.themeMode));
        var themeData = ThemeData(
          // textTheme: kIsWeb
          //     ? GoogleFonts.sawarabiGothicTextTheme(Theme.of(context).textTheme)
          //     : null,
          primarySwatch: Colors.orange,
        );
        return MaterialApp(
          title: "kanban memo",
          theme: themeData,
          darkTheme: ThemeData.dark(),
          // themeMode: themeModeValue,
          debugShowCheckedModeBanner: false,
          home: const MainPage(),
        );
      },
    );
  }
}


// class MyApp extends HookConsumerWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return MaterialApp(
//       title: 'Flutter Demoo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       // routes: {
//       //   '/': (context) =>
//       //       MyHomePage(title: 'Flutter Demo Home Page with named')
//       // },
//       // initialRoute: '/'
//       home: const MainPage(),
//     );
//   }
// }

// class MyHomePage extends HookConsumerWidget {
//   MyHomePage({Key? key, required this.title}) : super(key: key);

//   final String title;
//   int c = 0;

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(title),
//       ),
//       body: const SafeArea(
//         child: MainContents(),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: (() => tapAction(context, ref)),
//         tooltip: 'External Increment',
//         child: const Icon(Icons.add),
//       ),
//       // IncrementButton(),
//       floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
//       bottomNavigationBar: BottomBar(
//         stateCheckStr: ref.watch(countProvider).toString(),
//       ),
//     );
//   }

//   Future<void> tapAction(BuildContext context, WidgetRef ref) async {
//     // ????????????????????????????????????????????????????????????????????????????????????????????????fail????????????
//     // String? name = await showEditDialog(context, '?????????') ?? 'fail';
//     var builder = TextEditDialog.builder("Add Board");
//     builder.submit = "Create";
//     var boardName = await builder.build().show(context);
//     // ref.read(flatModelrovider.notifier).changeModel(boardName!);
//     if (ref.read(tabIndexProvider) == 0) {
//       ref.read(countProvider.notifier).increment();
//     } else if (ref.read(tabIndexProvider) == 1) {
//       c++;
//       ref.read(strListProvider.notifier).add(str: c.toString());
//     }
//   }
// }
