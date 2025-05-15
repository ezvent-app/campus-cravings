import 'package:campuscravings/src/src.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundedButtonWidget extends StatelessWidget {
  const RoundedButtonWidget({
    super.key,
    required this.btnTitle,
    required this.onTap,
    this.isLoading = false,
  });

  final String btnTitle;
  final Function()? onTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final isIOS = Theme.of(context).platform == TargetPlatform.iOS;

    final loader = const SizedBox(
      height: 20,
      width: 20,
      child: CircularProgressIndicator(color: AppColors.white, strokeWidth: 2),
    );

    final text = Text(
      btnTitle,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
        color: AppColors.white,
        fontSize: 16,
        fontWeight: FontWeight.w700,
      ),
    );

    return SizedBox(
      width: double.infinity,
      height: 48,
      child:
          isIOS
              ? CupertinoButton(
                onPressed: isLoading ? null : onTap,
                padding: EdgeInsets.zero,
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(10),
                child: isLoading ? loader : text,
              )
              : ElevatedButton(
                onPressed: isLoading ? null : onTap,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.white,
                ),
                child: isLoading ? loader : text,
              ),
    );
  }
}
