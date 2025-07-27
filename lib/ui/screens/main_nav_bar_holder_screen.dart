import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/new_task_list_screen.dart';
import 'package:task_manager/ui/screens/progress_task_screen.dart';

import '../widgets/tm_app_bar.dart';
import 'cancle_task_screen.dart';
import 'completed_task_screen.dart';

class MainNavBarHolderScreen extends StatefulWidget {
  static const String name = '/main-nav-bar-holder';

  const MainNavBarHolderScreen({super.key});

  @override
  State<MainNavBarHolderScreen> createState() => _MainNavBarHolderScreenState();
}

class _MainNavBarHolderScreenState extends State<MainNavBarHolderScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    NewTaskListScreen(),
    ProgressTaskScreen(),
    CompletedTaskScreen(),
    CancleTaskScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          _selectedIndex = index;
          setState(() {});
        },
        destinations: [
          NavigationDestination(icon: Icon(Icons.add_task), label: 'New Task'),
          NavigationDestination(
            icon: Icon(Icons.running_with_errors),
            label: 'Progress',
          ),
          NavigationDestination(icon: Icon(Icons.done), label: 'Completed'),
          NavigationDestination(icon: Icon(Icons.cancel), label: 'Canceled'),
        ],
      ),
    );
  }
}
