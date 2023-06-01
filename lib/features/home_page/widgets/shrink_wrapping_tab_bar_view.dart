import 'package:flutter/material.dart';

class ShrinkWrappingTabBarView extends StatelessWidget {
  const ShrinkWrappingTabBarView({
    super.key,
    required this.tabController,
    required this.children,
  });

  final TabController tabController;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Opacity(
          opacity: 0.0,
          child: AnimatedSize(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOutExpo,
            child: SizedBox(
              width: double.infinity, // always fill horizontally
              child: CurrentTabControllerWidget(
                tabController: tabController,
                children: children,
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            controller: tabController,
            children: children
                .map(
                  (e) => OverflowBox(
                    alignment: Alignment.topCenter,
                    // avoid shrinkwrapping to animated height
                    minHeight: 0,
                    maxHeight: double.infinity,
                    child: e,
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}

class CurrentTabControllerWidget extends StatefulWidget {
  const CurrentTabControllerWidget({
    super.key,
    required this.tabController,
    required this.children,
  });

  final TabController tabController;
  final List<Widget> children;

  @override
  State<CurrentTabControllerWidget> createState() =>
      _CurrentTabControllerWidgetState();
}

class _CurrentTabControllerWidgetState
    extends State<CurrentTabControllerWidget> {
  @override
  void initState() {
    super.initState();
    widget.tabController.addListener(_tabUpdated);
    widget.tabController.animation?.addListener(_tabUpdated);
  }

  @override
  void dispose() {
    super.dispose();
    widget.tabController.removeListener(_tabUpdated);
    widget.tabController.animation?.removeListener(_tabUpdated);
  }

  @override
  void didUpdateWidget(covariant CurrentTabControllerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.tabController != widget.tabController) {
      oldWidget.tabController.removeListener(_tabUpdated);
      widget.tabController.addListener(_tabUpdated);
      oldWidget.tabController.animation?.removeListener(_tabUpdated);
      widget.tabController.animation?.addListener(_tabUpdated);
      setState(() {});
    }
  }

  void _tabUpdated() => setState(() {});

  @override
  Widget build(BuildContext context) =>
      widget.children[widget.tabController.animation?.value.round() ??
          widget.tabController.index];
}
