import 'package:auto_route/auto_route.dart';
import 'package:campus_cravings/constants/app_colors.dart';
import 'package:campus_cravings/ui/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class NewCardPage extends ConsumerStatefulWidget {
  const NewCardPage({super.key});

  @override
  ConsumerState createState() => _NewCardPageState();
}

class _NewCardPageState extends ConsumerState<NewCardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 15),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: IconButton(
                            onPressed: ()=> context.maybePop(),
                            icon: const Icon(Icons.arrow_back, size: 28,),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: Text(
                            'Add New Card',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 25, right: 25, top: 45),
                    child: Column(
                      children: [
                        CustomTextField(label: 'Full Name',),
                        SizedBox(height: 16),
                        CustomTextField(
                          label: 'Card Number',
                          // suffixIcon: ImageIcon(AssetImage('assets/images/png/mastercard_icon.png')),
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(child: CustomTextField(label: 'Expires',)),
                            SizedBox(width: 16),
                            Expanded(child: CustomTextField(label: 'CVV',)),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 48,
              margin: const EdgeInsets.only(left: 25, right: 25, bottom: 36),
              child: ElevatedButton(
                onPressed: (){
                  context.maybePop();
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.background,// Splash color
                ),
                child: const Text(
                  'Save',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}