import 'dart:ui';

import 'package:flutter/material.dart';

import '../extensions/extensions.dart';
import '../widgets/widgets.dart';

Future<T?> showBlurry<T>(BuildContext context, Future<T> future) async {
  CustomDialog.blurry(context);
  final result = await future;
  if (context.mounted) {
    CustomDialog.hide(context);
  }
  return result;
}

class CustomDialog extends StatelessWidget {
  const CustomDialog._({
    required this.title,
    required this.icon,
  });
  final String title;
  final IconData icon;

  static void blurry(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  static void hide(BuildContext context) => context.pop();

  static Future<T?> show<T>(
    BuildContext context, {
    required String title,
    required IconData icon,
  }) {
    return showDialog(
      context: context,
      builder: (_) => CustomDialog._(title: title, icon: icon),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: SizedBox(
          width: context.width * .8,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: context.theme.scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, size: 40),
                  4.h,
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  8.h,
                  CustomButton(
                    onPressed: () => CustomDialog.hide(context),
                    text: 'OK',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
