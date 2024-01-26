import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:ios_cupertino_store/account_tab.dart';

import 'product_list_tab.dart';
import 'search_tab.dart';
import 'shopping_cart_tab.dart';

class CupertinoStoreApp extends StatelessWidget{
  const CupertinoStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return const CupertinoApp(
      theme: CupertinoThemeData(brightness: Brightness.light),
      home: CupertinoStoreHomePage(),
    );
  }

}

class CupertinoStoreHomePage extends StatelessWidget {
  const CupertinoStoreHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Home'
            ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.search),
            label: 'Search'
            ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.shopping_cart),
            label: 'Cart'
            ),
            BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.profile_circled),
            label: 'Account'
            ),
        ]), 
      tabBuilder: (context, index) {
        return switch (index){
          0 => CupertinoTabView(
              builder: (context) => const CupertinoPageScaffold(
                child: ProductListTab(),
              ),
            ),
          1 => CupertinoTabView(
              builder: (context) => const CupertinoPageScaffold(
                child: SearchTab(),
              ),
            ),
          2 => CupertinoTabView(
              builder: (context) => const CupertinoPageScaffold(
                child: ShoppingCartTab(),
              ),
            ),
          3 => CupertinoTabView(
              builder: (context) => const CupertinoPageScaffold(
                child: ProfileTab(),
              ),
            ),
          _ => throw Exception('Invalid index $index'),
          };
        },
      );
  }
}