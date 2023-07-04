import 'package:flutter/material.dart';
import '../modelview/appbar.dart';
import '../modelview/buildStorySection.dart';
import '../modelview/buildTabBar.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
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
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff183E36), Colors.black, Color(0xff183E36)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            transform: GradientRotation(80),
          ),
        ),
        child: SafeArea(
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(child: appbar()),
              SliverToBoxAdapter(child: buildStorySection()),
              const SliverToBoxAdapter(child: SizedBox(height: 10)),
              const SliverFillRemaining(child: BuildTabBar()),
            ],
          ),
        ),
      ),
    );
  }
}
