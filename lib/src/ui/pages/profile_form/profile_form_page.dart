import 'package:campus_cravings/src/src.dart';

@RoutePage()
class ProfileFormPage extends ConsumerStatefulWidget {
  final bool newUser;
  const ProfileFormPage({super.key, required this.newUser});

  @override
  ConsumerState createState() => _ProfileFormPageState();
}

class _ProfileFormPageState extends ConsumerState<ProfileFormPage> {
  final List<String> _roles = ['Student', 'Faculty'];
  late String _selectedRole;

  @override
  void initState() {
    _selectedRole = _roles.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: Dimensions.paddingSizeLarge,
                  bottom: Dimensions.paddingSizeDefault),
              child: Row(
                children: [
                  if (!widget.newUser)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.paddingSizeDefault),
                      child: IconButton(
                        onPressed: () => context.maybePop(),
                        icon: const Icon(
                          Icons.arrow_back,
                          size: 28,
                        ),
                      ),
                    )
                  else
                    width(25),
                  Padding(
                    padding: EdgeInsets.only(top: widget.newUser ? 12 : 4),
                    child: Text(
                      widget.newUser ? locale.profileSetUp : locale.editProfile,
                      style: const TextStyle(
                          fontSize: Dimensions.fontSizeExtraLarge,
                          fontWeight: FontWeight.w800),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeExtraLarge),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  height(50),
                  Center(
                    child: SizedBox(
                      width: 64,
                      height: 64,
                      child: Stack(
                        children: [
                          Container(
                            width: 64,
                            height: 64,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        'https://s3-alpha-sig.figma.com/img/8929/f506/d6ef157302e2cf4908e7351bb791ad41?Expires=1739750400&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=IrOWv2e5bGX0hD0Mb-WOpcUHEilpfImm3nnpYh~V3iQJ9i2ToXgmfiGUJ8X0Mu3M2ootT8HOD48F5HOG5ENt7fRU1eDH7OpI8cr~OfaT4b7b~CbvxCRIrMaeqSLjcN1~ZVLQ-X8U0KezpESVzGKidhjlJDj33RnOG~UpUT6AJb6f5ew39Way97cIeUQEC1bnwLDhVVDfd4-mt8Ulh0NhZM4oS2d4rloLq6SsD240s288F32VKnkOjsQ6vQNJP6IeKOAEXVeLaanSzBCVMD~-~7LM77Y7xpfWs6lvplOVhRA61Kqvh2vRU8UTWPle~V-ay4qRgOCA2eaZ0zlK6GYC3w__')),
                                color: Colors.grey,
                                shape: BoxShape.circle),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: PngAsset(
                              'edit_profile_icon',
                              width: 20,
                              height: 20,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  height(50),
                  CustomTextField(
                    label: locale.enterFirstName,
                  ),
                  height(16),
                  CustomTextField(
                    label: locale.enterLastName,
                  ),
                  height(16),
                  CustomTextField(
                    label: locale.enterPhoneNumber,
                  ),
                  height(16),
                  Padding(
                    padding: EdgeInsets.only(bottom: 3),
                    child: Text(
                      locale.selectRole,
                      style: TextStyle(
                        fontSize: Dimensions.fontSizeSmall,
                        color: AppColors.lightText,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  DropdownButtonFormField<String>(
                    items: _roles.map((e) {
                      return DropdownMenuItem(value: e, child: Text(e));
                    }).toList(),
                    value: _selectedRole,
                    onChanged: (value) {
                      setState(() {
                        _selectedRole = value!;
                      });
                    },
                    icon: const Icon(Icons.keyboard_arrow_down),
                    iconEnabledColor: AppColors.primary,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: AppColors.textFieldBorder, width: 1.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: AppColors.textFieldBorder, width: 1.5),
                      ),
                    ),
                  ),
                  height(12),
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
                            (states) => const BorderSide(
                                width: 1.0, color: Colors.grey),
                          ),
                        ),
                      ),
                      width(7),
                      Text(
                        locale.registerForDelivery,
                        style: TextStyle(
                            fontSize: Dimensions.fontSizeSmall,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff6C7278)),
                      )
                    ],
                  ),
                  height(18),
                  RoundedButtonWidget(
                      btnTitle: widget.newUser ? locale.next : locale.save,
                      onTap: () => widget.newUser
                          ? context.pushRoute(const DeliverySetupRoute())
                          : context.maybePop()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
