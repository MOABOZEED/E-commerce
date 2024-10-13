import 'package:flutter/material.dart';

class ShimmerBox extends StatelessWidget {
  const ShimmerBox({super.key, required this.flex, required this.widthFactor});

  final int flex;
  final double widthFactor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: FractionallySizedBox(
        widthFactor: widthFactor,
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.black.withOpacity(0.5),
          ),
        ),
      ),
    );
  }
}

class ShimmerView extends StatefulWidget {
  const ShimmerView({super.key});

  @override
  State<ShimmerView> createState() => _ShimmerViewState();
}

class _ShimmerViewState extends State<ShimmerView>with SingleTickerProviderStateMixin {
  late AnimationController _shimmerController;

  @override
  void initState() {
    super.initState();

    _shimmerController = AnimationController.unbounded(vsync: this)
      ..repeat(min: -0.5, max: 1.5, period: const Duration(milliseconds: 1000));
  }

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          ShimmerBox(

            flex: 6,
            widthFactor: 1,
          ),
          SizedBox(
            height: 10,
          ),
          ShimmerBox(
            flex: 1,
            widthFactor: 0.75,
          ),
          SizedBox(
            height: 10,
          ),
          ShimmerBox(
            flex: 6,
            widthFactor: 1,
          ),
          SizedBox(
            height: 10,
          ),
          ShimmerBox(
            flex: 1,
            widthFactor: 1,
          ),
          SizedBox(
            height: 10,
          ),
          ShimmerBox(
            flex: 1,
            widthFactor: 0.75,
          ),
          SizedBox(
            height: 10,
          ),
          ShimmerBox(
            flex: 6,
            widthFactor: 1,
          ),
          SizedBox(
            height: 10,
          ),
          ShimmerBox(
            flex: 1,
            widthFactor: 1,
          ),
          SizedBox(
            height: 10.0,
          ),
          ShimmerBox(
            flex: 1,
            widthFactor: 0.75,
          ),
          SizedBox(
            height: 20.0,
          ),
          SizedBox(
            height: 20.0,
          ),
          ShimmerBox(
            flex: 6,
            widthFactor: 1,
          ),
          SizedBox(
            height: 10.0,
          ),
          ShimmerBox(
            flex: 1,
            widthFactor: 1,
          ),
          SizedBox(
            height: 10.0,
          ),
          ShimmerBox(
            flex: 1,
            widthFactor: 0.75,
          ),
          SizedBox(
            height: 20.0,
          ),
        ],
      ),
    );
  }
}

class ShimmerLoading extends StatelessWidget {
  const ShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ShimmerView(),
    );
  }
}
