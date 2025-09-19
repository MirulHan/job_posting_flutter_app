import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrimaryLayout extends StatelessWidget {
  final Widget body;
  final String? title;
  final bool showAppBar;
  final List<Widget>? actions;
  final Widget? floatingActionButton;
  final Color? backgroundColor;
  final bool showBackButton;
  final Widget? leading;
  final PreferredSizeWidget? bottom;

  const PrimaryLayout({
    super.key,
    required this.body,
    this.title,
    this.showAppBar = true,
    this.actions,
    this.floatingActionButton,
    this.backgroundColor,
    this.showBackButton = true,
    this.leading,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
      appBar: showAppBar ? _buildAppBar(context) : null,
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }

  PreferredSizeWidget? _buildAppBar(BuildContext context) {
    return AppBar(
      title: title != null ? Text(title!) : null,
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
      leading: _buildLeading(context),
      actions: actions,
      bottom: bottom,
      automaticallyImplyLeading: false,
    );
  }

  Widget? _buildLeading(BuildContext context) {
    if (leading != null) {
      return leading;
    }
    if (showBackButton) {
      return IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: Get.back,
      );
    }

    return null;
  }
}

class PrimaryLayoutHelper {
  static PrimaryLayout withTitle({
    required Widget body,
    required String title,
    VoidCallback? onBackPressed,
    List<Widget>? actions,
    Widget? floatingActionButton,
    Color? backgroundColor,
    bool showBackButton = true,
    PreferredSizeWidget? bottom,
  }) {
    return PrimaryLayout(
      body: body,
      title: title,
      showAppBar: true,
      actions: actions,
      floatingActionButton: floatingActionButton,
      backgroundColor: backgroundColor,
      showBackButton: showBackButton,
      bottom: bottom,
    );
  }

  static PrimaryLayout withoutAppBar({
    required Widget body,
    Widget? floatingActionButton,
    Color? backgroundColor,
  }) {
    return PrimaryLayout(
      body: body,
      showAppBar: false,
      floatingActionButton: floatingActionButton,
      backgroundColor: backgroundColor,
    );
  }

  static PrimaryLayout withCustomLeading({
    required Widget body,
    String? title,
    required Widget leading,
    List<Widget>? actions,
    Widget? floatingActionButton,
    Color? backgroundColor,
    PreferredSizeWidget? bottom,
  }) {
    return PrimaryLayout(
      body: body,
      title: title,
      showAppBar: true,
      leading: leading,
      actions: actions,
      floatingActionButton: floatingActionButton,
      backgroundColor: backgroundColor,
      showBackButton: false,
      bottom: bottom,
    );
  }
}
