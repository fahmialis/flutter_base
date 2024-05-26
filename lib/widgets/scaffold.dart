import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainWrapper extends StatefulWidget {
  final Widget child;
  const MainWrapper({super.key, required this.child});

  @override
  MainWrapperState createState() => MainWrapperState();
}

class MainWrapperState extends State<MainWrapper> {
  @override
  void initState() {
    super.initState();
  }

  int currentActiveIndex() {
    String pathName = ModalRoute.of(context)?.settings.name ?? '';

    switch (pathName) {
      case '/':
        return 0;
      case '/second':
        return 1;
      case '/third':
        return 2;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentActiveIndex(),
          showUnselectedLabels: true,
          showSelectedLabels: true,
          onTap: (value) {
            if (value == 0) {
              GoRouter.of(context).go('/');
            } else if (value == 1) {
              GoRouter.of(context).go('/second');
            } else if (value == 2) {
              GoRouter.of(context).go('/third');
            }
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.payment),
              label: 'Expenses',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.two_k),
              label: 'second',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.three_k),
              label: 'third',
            ),
          ],
        ),
        body: widget.child,
      ),
    );
  }
}
