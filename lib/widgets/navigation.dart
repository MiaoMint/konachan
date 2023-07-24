import 'package:flutter/material.dart';

class NavigationView extends StatelessWidget {
  const NavigationView({
    Key? key,
    required this.logo,
    required this.navigationButtons,
    required this.body,
  }) : super(key: key);

  final Widget logo;
  final List<Widget> navigationButtons;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MediaQuery.of(context).size.width < 600
          ? AppBar(
              title: logo,
              centerTitle: true,
            )
          : null,
      body: LayoutBuilder(builder: ((context, constraints) {
        if (constraints.maxWidth < 600) {
          return body;
        }
        return Row(
          children: [
            Container(
              width: 250,
              color: Theme.of(context).colorScheme.background,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [logo, ...navigationButtons],
              ),
            ),
            Expanded(child: body)
          ],
        );
      })),
      drawer: Drawer(
        child: Container(
          width: 250,
          color: Theme.of(context).colorScheme.background,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [logo, ...navigationButtons],
          ),
        ),
      ),
    );
  }
}

class NavigationButton extends StatelessWidget {
  const NavigationButton({
    Key? key,
    required this.child,
    required this.onPressed,
    required this.selected,
  }) : super(key: key);
  final Widget child;
  final VoidCallback onPressed;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        onPressed();
        if (MediaQuery.of(context).size.width < 600) {
          Navigator.of(context).pop();
        }
      },
      style: TextButton.styleFrom(
        foregroundColor: selected
            ? Colors.deepOrange
            : Theme.of(context).colorScheme.onBackground,
        backgroundColor: selected ? Colors.deepOrange.withOpacity(0.2) : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: child,
    );
  }
}
