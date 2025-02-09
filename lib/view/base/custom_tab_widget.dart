import 'package:flutter/material.dart';
import 'package:home_health_app/utils/app_colors.dart';

class CustomTabWidget extends StatefulWidget {
  final List<String> tabs;
  final List<Widget> tabContents;
  final Function(int)? onTabChanged;

  const CustomTabWidget({
    Key? key,
    required this.tabs,
    required this.tabContents,
    this.onTabChanged,
  }) : assert(tabs.length == tabContents.length,
  'The number of tabs must match the number of contents.'),
        super(key: key);

  @override
  State<CustomTabWidget> createState() => _CustomTabWidgetState();
}

class _CustomTabWidgetState extends State<CustomTabWidget> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.tabs.length, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      widget.onTabChanged?.call(_tabController.index);
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          tabs: widget.tabs.map((tab) => Tab(text: tab)).toList(),
          labelColor: AppColors.primaryColor,
          unselectedLabelColor: Colors.grey,
          indicatorColor: AppColors.primaryColor,
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: widget.tabContents,
          ),
        ),
      ],
    );
  }
}