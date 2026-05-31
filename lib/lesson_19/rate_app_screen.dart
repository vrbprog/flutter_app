import 'package:flutter/material.dart';
import 'package:flutter_app/lesson_19/rate_app_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RateAppScreen extends StatefulWidget {
  const RateAppScreen({super.key});

  @override
  State<RateAppScreen> createState() => _RateAppScreenState();
}

class _RateAppScreenState extends State<RateAppScreen> {
  static const Color _baseTextColor = Color(0xFF1B3D70);
  late final RateAppCubit _rateAppCubit;
  late final TextEditingController _commentController;

  @override
  void initState() {
    super.initState();
    _rateAppCubit = context.read<RateAppCubit>();
    final initialComment = _rateAppCubit.state.comment;
    _commentController = TextEditingController(text: initialComment);
  }

  @override
  void dispose() {
    final isSubmitted = _rateAppCubit.state.state == RateAppActionState.success;
    if (!isSubmitted) {
      _rateAppCubit.resetRating();
    }
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<RateAppCubit, RateAppState>(
          listenWhen: (previous, current) {
            return previous.state == RateAppActionState.loading &&
                current.state == RateAppActionState.success;
          },
          listener: (context, state) {
            context.pop();
            ScaffoldMessenger.of(context).showSnackBar(
              _createSnackBar(
                context,
                'Rating submitted successfully ${state.rating} stars',
              ),
            );
          },
        ),
        BlocListener<RateAppCubit, RateAppState>(
          listenWhen: (previous, current) {
            return previous.comment != current.comment;
          },
          listener: (context, state) {
            _commentController.value = TextEditingValue(text: state.comment);
          },
        ),
      ],
      child: BlocBuilder<RateAppCubit, RateAppState>(
        builder: (context, state) {
          final isSended = state.state == RateAppActionState.success;
          return Scaffold(
            backgroundColor: const Color(0xFF9AD1EF),
            appBar: AppBar(
              title: const Text('Rate App'),
              centerTitle: true,
              backgroundColor: const Color(0xFF1B3D70),
              foregroundColor: Colors.white,
            ),
            body: SingleChildScrollView(
              child: Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 130),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 32,
                    ),
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
                        Column(
                          spacing: 24,
                          children: [
                            Text(
                              isSended
                                  ? 'You rated the app'
                                  : 'How would you rate the app?',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: _baseTextColor,
                              ),
                            ),
                            Row(
                              spacing: 20,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(5, (index) {
                                final starIndex = index + 1;
                                final isAnimating =
                                    state.animatedStarIndex == starIndex;

                                return GestureDetector(
                                  onTap: isSended
                                      ? null
                                      : () {
                                          context
                                              .read<RateAppCubit>()
                                              .onStarTapped(starIndex);
                                        },
                                  child: AnimatedScale(
                                    scale: isAnimating && state.isScaledUp
                                        ? 1.5
                                        : 1,
                                    duration: const Duration(milliseconds: 200),
                                    curve: Curves.easeOut,
                                    child: Image.asset(
                                      starIndex <= state.rating
                                          ? 'assets/fillStar.png'
                                          : 'assets/star.png',
                                      width: 32,
                                      height: 32,
                                    ),
                                  ),
                                );
                              }),
                            ),
                            TextFormField(
                              controller: _commentController,
                              enabled: !isSended,
                              onChanged: context
                                  .read<RateAppCubit>()
                                  .updateComment,
                              style: const TextStyle(
                                color: _baseTextColor,
                                fontWeight: FontWeight.w600,
                              ),
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                labelText: 'Add a comment',
                                labelStyle: const TextStyle(
                                  color: _baseTextColor,
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
                                if (isSended)
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: context
                                          .read<RateAppCubit>()
                                          .resetRating,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: _baseTextColor,
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 30,
                                          vertical: 18,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        'Rate Again',
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ),
                                if (!isSended)
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: context
                                          .read<RateAppCubit>()
                                          .submitRating,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: _baseTextColor,
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 30,
                                          vertical: 18,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                      ),
                                      child:
                                          state.state ==
                                              RateAppActionState.loading
                                          ? const SizedBox(
                                              width: 20,
                                              height: 20,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                color: Colors.white,
                                              ),
                                            )
                                          : Text(
                                              'Submit Rating',
                                              style: const TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                    ),
                                  ),
                                if (!isSended)
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed:
                                          state.state ==
                                              RateAppActionState.loading
                                          ? null
                                          : () {
                                              context
                                                  .read<RateAppCubit>()
                                                  .resetRating();
                                            },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(
                                          0xFF41A6F4,
                                        ),
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 30,
                                          vertical: 18,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
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
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(_getPhoneImage(state.rating), width: 120),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  String _getPhoneImage(int rating) {
    switch (rating) {
      case 0:
        return 'assets/phone.png';
      case 1:
        return 'assets/phone_1.png';
      case 2:
        return 'assets/phone_2.png';
      case 3:
        return 'assets/phone_3.png';
      case 4:
        return 'assets/phone_4.png';
      case 5:
        return 'assets/phone_5.png';
      default:
        return 'assets/phone.png';
    }
  }
}

SnackBar _createSnackBar(BuildContext context, String result) {
  return SnackBar(
    content: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.star, color: Colors.white),
        const SizedBox(width: 12),
        Text(result, style: const TextStyle(fontSize: 16)),
        const SizedBox(width: 12),
        const Icon(Icons.star, color: Colors.white),
      ],
    ),
    behavior: SnackBarBehavior.floating,
    duration: const Duration(seconds: 4),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(6)),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    dismissDirection: DismissDirection.none,
  );
}
