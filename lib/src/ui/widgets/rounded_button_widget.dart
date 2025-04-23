import 'package:campuscravings/src/src.dart';
import 'package:flutter/cupertino.dart';

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
    bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;

    return SizedBox(
      width: double.infinity,
      height: 48,
      child:
          isIOS
              ? CupertinoButton(
                onPressed: onTap,
                padding: EdgeInsets.zero,
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(10),
                child: Text(
                  btnTitle,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: AppColors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              )
              : ElevatedButton(
                onPressed: onTap,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.white,
                ),
                child:
                    isLoading
                        ? const CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        )
                        : Text(
                          btnTitle,
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium!.copyWith(
                            color: AppColors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
              ),
    );
  }
}
