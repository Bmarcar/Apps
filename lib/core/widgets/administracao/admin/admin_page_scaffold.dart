import 'package:flutter/material.dart';

class AdminPageScaffold extends StatelessWidget {
  final String title;
  final Widget child;
  final Widget? floatingActionButton;
  final List<Widget>? actions;

  const AdminPageScaffold({
    super.key,
    required this.title,
    required this.child,
    this.floatingActionButton,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,

      appBar: AppBar(
        title: Text(title),
        centerTitle: false,
        actions: actions,
      ),

      floatingActionButton: floatingActionButton,

      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: child,
        ),
      ),
    );
  }
}