import 'package:campus_cravings/src/src.dart';

@RoutePage()
class DeliverySetupPage extends ConsumerWidget {
  const DeliverySetupPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = AppLocalizations.of(context)!;
    return BaseWrapper(
      label: locale.deliveryProfile,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
            label: locale.socialSecurityNumber,
            onChanged: (value) => ref
                .read(deliveryProfileProvider.notifier)
                .updateSocialSecurityNumber(value),
          ),
          height(16),
          Padding(
            padding: EdgeInsets.only(bottom: 3),
            child: Text(locale.nationalID,
                style: Theme.of(context).textTheme.bodySmall),
          ),
          OutlinedButton(
            onPressed: () => ref
                .read(deliveryProfileProvider.notifier)
                .updateNICImage('updated'),
            style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                foregroundColor: const Color(0xff525252)),
            child: Text(locale.uploadCaptureImage),
          ),
          Row(
            children: [
              Consumer(
                builder: (context, ref, child) {
                  final deliveryProvider = ref.watch(deliveryProfileProvider);
                  return Transform.scale(
                    scale: 1.3,
                    child: Checkbox(
                      value: deliveryProvider.isAgree,
                      onChanged: (value) => ref
                          .read(deliveryProfileProvider.notifier)
                          .updateTermsAndConditions(value!),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      side: WidgetStateBorderSide.resolveWith(
                        (states) =>
                            const BorderSide(width: 1.0, color: Colors.grey),
                      ),
                    ),
                  );
                },
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
          Consumer(
            builder: (context, ref, child) {
              final deliveryProvider = ref.watch(deliveryProfileProvider);
              return RoundedButtonWidget(
                btnTitle: locale.next,
                onTap: deliveryProvider.isAgree &&
                        deliveryProvider.nICImage.isNotEmpty &&
                        deliveryProvider.socialSecurityNumber.isNotEmpty
                    ? () => context.pushRoute(const AddPayoutRoute())
                    : null,
              );
            },
          )
        ],
      ),
    );
  }
}

final deliverySetupProvider = StateProvider<String>((ref) => '');
