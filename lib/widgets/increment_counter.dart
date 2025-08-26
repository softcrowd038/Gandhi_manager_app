import 'package:gandhi_tvs/common/app_imports.dart';

class IncrementCounterDemo extends StatefulWidget {
  const IncrementCounterDemo({super.key, required this.targetValue});

  final int targetValue;

  @override
  State<IncrementCounterDemo> createState() => _IncrementCounterDemoState();
}

class _IncrementCounterDemoState extends State<IncrementCounterDemo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _animation;

  @override
  void initState() {
    super.initState();

    int targetValue = widget.targetValue;

    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    _animation = IntTween(begin: 0, end: targetValue).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      '${_animation.value}',
      style: TextStyle(fontSize: AppFontSize.s22, fontWeight: FontWeight.bold),
    );
  }
}
