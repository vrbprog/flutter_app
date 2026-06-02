import 'dart:math' as math;
import 'package:flutter/material.dart';

class ExplicitAnimationsScreen extends StatefulWidget {
  const ExplicitAnimationsScreen({super.key});

  @override
  State<ExplicitAnimationsScreen> createState() =>
      _ExplicitAnimationsScreenState();
}

class _ExplicitAnimationsScreenState extends State<ExplicitAnimationsScreen>
    with SingleTickerProviderStateMixin {
  static const Duration duration = Duration(seconds: 2);
  late final AnimationController _controller;
  late Animation<AlignmentGeometry> _activeAlignment;
  bool _isDownPhase = false;

  late final Animation<AlignmentGeometry> _animationAlignUp =
      Tween<AlignmentGeometry>(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      ).animate(
        CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn),
      );

  late final Animation<AlignmentGeometry> _animationAlignDown =
      Tween<AlignmentGeometry>(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).animate(CurvedAnimation(parent: _controller, curve: Curves.bounceOut));

  void _onAnimationStatusChanged(AnimationStatus status) {
    if (!mounted || status != AnimationStatus.completed) {
      return;
    }

    if (!_isDownPhase) {
      setState(() {
        _isDownPhase = true;
        _activeAlignment = _animationAlignDown;
      });
      _controller.forward(from: 0);
      return;
    }
  }

  void _restartAnimationIfIdle() {
    if (!mounted || _controller.isAnimating) {
      return;
    }

    setState(() {
      _isDownPhase = false;
      _activeAlignment = _animationAlignUp;
    });

    _controller
      ..reset()
      ..forward();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
    _activeAlignment = _animationAlignUp;
    _controller.addStatusListener(_onAnimationStatusChanged);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.removeStatusListener(_onAnimationStatusChanged);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Explicit Animations')),
      body: Container(
        constraints: const BoxConstraints.expand(), // Fill the entire screen
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/goal.png'),
            fit: BoxFit.cover, // Ensures the image fills the screen
          ),
        ),
        child: AlignTransition(
          alignment: _activeAlignment,
          child: AnimatedBuilder(
            animation: _controller,
            child: GestureDetector(
              onTap: _restartAnimationIfIdle,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Image(
                  image: AssetImage('assets/ball.png'),
                  width: 120,
                  height: 120,
                ),
              ),
            ),
            builder: (context, child) {
              final progress = _isDownPhase
                  ? 1 + _controller.value
                  : _controller.value;
              return Transform.rotate(
                angle: progress * (math.pi / 1),
                child: child,
              );
            },
          ),
        ),
      ),
    );
  }
}
