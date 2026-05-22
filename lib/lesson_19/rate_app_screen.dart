import 'package:flutter/material.dart';
import 'package:flutter_app/lesson_19/rate_app_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RateAppScreen extends StatefulWidget {
  const RateAppScreen({super.key});

  final Color _baseTextColor = const Color(0xFF1B3D70);

  @override
  State<RateAppScreen> createState() => _RateAppScreenState();
}

class _RateAppScreenState extends State<RateAppScreen> {
  final myController = TextEditingController();
  int? _animatedStarIndex;
  bool _isScaledUp = false;
  int _pulseToken = 0;
  bool _stateSendingRate = false;
  late int _currentRating;
  late String _currentComment;

  @override
  void initState() {
    super.initState();
    _currentRating = context.read<RateAppCubit>().state.rating;
    _currentComment = context.read<RateAppCubit>().state.isSendingRate
        ? context.read<RateAppCubit>().state.comment
        : 'Add a comment';
  }

  void _triggerStarPulse(int starIndex) {
    final currentToken = ++_pulseToken;

    setState(() {
      _animatedStarIndex = starIndex;
      _isScaledUp = true;
    });

    Future<void>.delayed(const Duration(milliseconds: 200), () {
      if (!mounted || currentToken != _pulseToken) {
        return;
      }

      setState(() {
        _isScaledUp = false;
      });
    });

    Future<void>.delayed(const Duration(milliseconds: 400), () {
      if (!mounted || currentToken != _pulseToken) {
        return;
      }

      setState(() {
        _animatedStarIndex = null;
      });
    });
  }

  void _submitRating() {
    setState(() {
      _stateSendingRate = true;
    });

    Future<void>.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;

      setState(() {
        _stateSendingRate = false;
        context.read<RateAppCubit>().rateApp(_currentRating, _currentComment);
        context.pop();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF9AD1EF),
      appBar: AppBar(
        title: const Text('Rate App'),
        centerTitle: true,
        backgroundColor: const Color(0xFF1B3D70),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        //padding: const EdgeInsets.only(top: 16.0),
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 130),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
              decoration: BoxDecoration(
                color: const Color(0xFF72C1FA),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: .2),
                    blurRadius: 4,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),
                  BlocBuilder<RateAppCubit, RateAppState>(
                    builder: (context, state) {
                      final isSended = state.isSendingRate;
                      return Column(
                        spacing: 24,
                        children: [
                          Text(
                            isSended
                                ? 'You rated the app'
                                : 'How would you rate the app?',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: widget._baseTextColor,
                            ),
                          ),
                          Row(
                            spacing: 20,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(5, (index) {
                              final starIndex = index + 1;
                              final isAnimating =
                                  _animatedStarIndex == starIndex;
                              return GestureDetector(
                                onTap: () {
                                  if (!isSended) {
                                    _triggerStarPulse(starIndex);
                                    setState(() {
                                      _currentRating = starIndex;
                                    });
                                  }
                                },
                                child: AnimatedScale(
                                  scale: isAnimating && _isScaledUp ? 1.5 : 1,
                                  duration: const Duration(milliseconds: 200),
                                  curve: Curves.easeOut,
                                  child: Image.asset(
                                    starIndex <= _currentRating
                                        ? 'assets/fillStar.png'
                                        : 'assets/star.png',
                                    width: 32,
                                    height: 32,
                                  ),
                                ),
                              );
                            }),
                          ),
                          TextField(
                            controller: myController,
                            enabled: !isSended,
                            style: TextStyle(
                              color: widget._baseTextColor,
                              fontWeight: FontWeight.w600,
                            ),
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              labelText: _currentComment,
                              labelStyle: TextStyle(
                                color: widget._baseTextColor,
                                fontWeight: FontWeight.w600,
                              ),
                              alignLabelWithHint: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            keyboardType: TextInputType.multiline,
                            maxLines: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            spacing: 8,
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (isSended) {
                                      context
                                          .read<RateAppCubit>()
                                          .resetRating();
                                      setState(() {
                                        _currentRating = 0;
                                        _currentComment = 'Add a comment';
                                      });
                                    } else {
                                      _currentComment =
                                          myController.text.isEmpty
                                          ? ''
                                          : myController.text;
                                      _submitRating();
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: widget._baseTextColor,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 30,
                                      vertical: 18,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: _stateSendingRate
                                      ? SizedBox(
                                          width: 20,
                                          height: 20,
                                          child:
                                              const CircularProgressIndicator(
                                                strokeWidth: 2,
                                                color: Colors.white,
                                              ),
                                        )
                                      : Text(
                                          isSended
                                              ? 'Rate Again'
                                              : 'Submit Rating',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                ),
                              ),
                              if (!isSended)
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        _currentRating = 0;
                                        _currentComment = 'Add a comment';
                                      });
                                      myController.clear();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xFF41A6F4),
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 30,
                                        vertical: 18,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: const Text(
                                      'Reset Rating',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Image.asset('assets/phone.png', width: 120)],
            ),
          ],
        ),
      ),
    );
  }
}
