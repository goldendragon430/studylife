import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app.dart';
import '../Utilities/constants.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 1600,
      ),
    );

    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, WidgetRef ref, __) {
      final theme = ref.watch(themeModeProvider);

    return BottomSheet(
      animationController: _controller,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.9,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50.0),
          ),
          child: DefaultTabController(
            length: 5,
            child: Scaffold(
              appBar: AppBar(
                elevation: 0,
                automaticallyImplyLeading: false,
                bottom: TabBar(
                  indicatorColor: theme == ThemeMode.light ? Constants.blueButtonBackgroundColor : Constants.darkThemePrimaryColor,
                  isScrollable: true,
                  tabs: [
                    Tab(
                      child: Text("Class", style: theme == ThemeMode.light ? Constants.lightThemeTabBarTextStyle : Constants.darkThemeTabBarTextStyle,),
                    ),
                    Tab(child: Text("Exam", style: theme == ThemeMode.light ? Constants.lightThemeTabBarTextStyle : Constants.darkThemeTabBarTextStyle,)),
                    Tab(child: Text("Task", style: theme == ThemeMode.light ? Constants.lightThemeTabBarTextStyle : Constants.darkThemeTabBarTextStyle,)),
                    Tab(child: Text("Holiday", style: theme == ThemeMode.light ? Constants.lightThemeTabBarTextStyle : Constants.darkThemeTabBarTextStyle,)),
                    Tab(child: Text("Extra", style: theme == ThemeMode.light ? Constants.lightThemeTabBarTextStyle : Constants.darkThemeTabBarTextStyle,)),
                  ],
                ),
                title: const Text('New'),
              ),
              body: const TabBarView(
                children: [
                  Icon(Icons.directions_car),
                  Icon(Icons.directions_transit),
                  Icon(Icons.directions_bike),
                  Icon(Icons.directions_transit),
                  Icon(Icons.directions_bike),
                ],
              ),
              // child: Container(
              //   //to control height of bottom sheet
              //   height: MediaQuery.of(context).size.height * 0.9,
              //   decoration: BoxDecoration(
              //     color: Colors.white,
              //     borderRadius: BorderRadius.circular(50.0),
              //   ),
              // ),
            ),
          ),
        );
      },
      onClosing: () {
        Navigator.pop(context);
        print("ASDDADSASD");
      },
    );
    });
  }
}
