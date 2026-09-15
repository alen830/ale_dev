import 'package:flutter/material.dart';

class BottomNav2 extends StatefulWidget {
  const BottomNav2({super.key});

  @override
  State<BottomNav2> createState() => _BottomNav2State();
}

class _BottomNav2State extends State<BottomNav2> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.amber,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Badge(child: Icon(Icons.notifications_sharp)),
            label: 'Notifications',
          ),
          NavigationDestination(
            icon: Badge(label: Text('2'), child: Icon(Icons.messenger_sharp)),
            label: 'Messages',
          ),
        ],
      ),
      body: <Widget>[
        /// Home page
        Card(
          shadowColor: Colors.transparent,
          margin: const .all(8.0),
          child: SizedBox.expand(
            child: Center(
              child: Text('Home page', style: theme.textTheme.titleLarge),
            ),
          ),
        ),

        /// Notifications page
        const Padding(
          padding: .all(8.0),
          child: Column(
            children: <Widget>[
              Card(
                child: ListTile(
                  leading: Icon(Icons.notifications_sharp),
                  title: Text('Notification 1'),
                  subtitle: Text('This is a notification'),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.notifications_sharp),
                  title: Text('Notification 2'),
                  subtitle: Text('This is a notification'),
                ),
              ),
            ],
          ),
        ),

        /// Messages page
        ListView.builder(
          reverse: true,
          itemCount: 2,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Align(
                alignment: .centerRight,
                child: Container(
                  margin: const .all(8.0),
                  padding: const .all(8.0),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    borderRadius: .circular(8.0),
                  ),
                  child: Text(
                    'Hello',
                    style: theme.textTheme.bodyLarge!.copyWith(
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                ),
              );
            }
            return Align(
              alignment: .centerLeft,
              child: Container(
                margin: const .all(8.0),
                padding: const .all(8.0),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: .circular(8.0),
                ),
                child: Text(
                  'Hi!',
                  style: theme.textTheme.bodyLarge!.copyWith(
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
              ),
            );
          },
        ),
      ][currentPageIndex],
    );
  }
}
