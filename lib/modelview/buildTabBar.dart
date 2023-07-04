// ignore_for_file: file_names
import 'package:flutter/material.dart';
import '../views/semicircle.dart';
import 'buildChatCardList.dart';
import 'groupcard.dart';

class BuildTabBar extends StatefulWidget {
  const BuildTabBar({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BuildTabBarState createState() => _BuildTabBarState();
}

class _BuildTabBarState extends State<BuildTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xff161c16),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
            child: SemicircleWidget(),
          ),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xff2d322c),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Padding(
                padding: const EdgeInsets.all(1.50),
                child: TabBar(
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: const Color(0xff1f241e),
                  ),
                  controller: _tabController,
                  tabs: const [
                    Tab(
                      child: Text(
                        "Chats",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Groups",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                buildChatCardList(),
                const SingleChildScrollView(
        child: Column(
          children:[GroupCard()],
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
