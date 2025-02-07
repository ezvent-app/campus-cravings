import 'package:campus_cravings/src/src.dart';

@RoutePage()
class DeliverySetupPage extends ConsumerStatefulWidget {
  const DeliverySetupPage({super.key});

  @override
  ConsumerState createState() => _DeliverySetupPageState();
}

class _DeliverySetupPageState extends ConsumerState<DeliverySetupPage> {
  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return BaseWrapper(
      label: locale.deliveryProfile,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(label: locale.socialSecurityNumber),
          height(16),
          Padding(
            padding: EdgeInsets.only(bottom: 3),
            child: Text(locale.nationalID,
                style: Theme.of(context).textTheme.bodySmall),
          ),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                foregroundColor: const Color(0xff525252)),
            child: Text(locale.uploadCaptureImage),
          ),
          Row(
            children: [
              Transform.scale(
                scale: 1.3,
                child: Checkbox(
                  value: false,
                  onChanged: (value) {},
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  side: WidgetStateBorderSide.resolveWith(
                    (states) =>
                        const BorderSide(width: 1.0, color: Colors.grey),
                  ),
                ),
              ),
              Text(
                locale.iAgreeWith,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              InkWell(
                onTap: () {},
                child: Text(locale.termsConditions,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: AppColors.black,
                          decoration: TextDecoration.underline,
                        )),
              ),
            ],
          ),
          height(16),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                    text: locale.disclaimer,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: AppColors.black,
                        )),
                TextSpan(
                    text: locale.socialSecurityInfo,
                    style: Theme.of(context).textTheme.bodySmall),
                TextSpan(
                  text: locale.privacyPolicy,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: AppColors.black,
                        decoration: TextDecoration.underline,
                      ),
                  recognizer: TapGestureRecognizer()..onTap = () {},
                ),
                TextSpan(
                    text: '.', style: Theme.of(context).textTheme.bodySmall)
              ],
            ),
          ),
          height(24),
          RoundedButtonWidget(
            btnTitle: locale.next,
            onTap: () => context.pushRoute(const AddPayoutRoute()),
          ),
        ],
      ),
    );
  }
}
