import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/providerProduct.dart';

class AnimatedIconExample extends StatefulWidget {
  const AnimatedIconExample({super.key});

  @override
  State<AnimatedIconExample> createState() => _AnimatedIconExampleState();
}

class _AnimatedIconExampleState extends State<AnimatedIconExample>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    // _handleOnPressed();
  }

  void _handleOnPressed() {
    setState(() {
      final provider = Provider.of<ProductProvider>(context, listen: false);
      provider.toggleAnimation(animationController);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, provider, child) {
        return Center(
          child: GestureDetector(
            onTap: _handleOnPressed,
            child: AnimatedIcon(
              icon: AnimatedIcons.view_list,
              progress: animationController,
              size: 50.0,
              semanticLabel: 'Show menu',
            ),
          ),
        );
      },
    );
  }
}
