import 'package:campuscravings/src/src.dart';
import 'package:file_picker/file_picker.dart';

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

  File? image;

  @override
  void initState() {
    _selectedRole = _roles.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    final isIOS = Platform.isIOS;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: Dimensions.paddingSizeLarge,
                bottom: Dimensions.paddingSizeDefault,
              ),
              child: Row(
                children: [
                  if (!widget.newUser)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.paddingSizeDefault,
                      ),
                      child: IconButton(
                        onPressed: () => context.maybePop(),
                        icon: Icon(
                          isIOS ? Icons.arrow_back_ios_new : Icons.arrow_back,
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
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeExtraLarge,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  height(50),
                  Center(
                    child: InkWellButtonWidget(
                      onTap: () async {
                        final FilePickerResult? result = await FilePicker
                            .platform
                            .pickFiles(type: FileType.image);
                        if (result != null) {
                          File file = File(result.files.single.path!);
                          setState(() {
                            image = file;
                          });
                        } else {}
                      },
                      child: SizedBox(
                        width: 64,
                        height: 64,
                        child: Stack(
                          children: [
                            Container(
                              width: 64,
                              height: 64,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: image != null
                                      ? FileImage(image!)
                                      : NetworkImage(
                                          'https://images.app.goo.gl/him1uAKDAzpZeGW29',
                                        ),
                                ),
                                color: Colors.grey,
                                shape: BoxShape.circle,
                              ),
                            ),
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: SvgAssets('edit', width: 20, height: 20),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  height(50),
                  CustomTextField(
                    textInputAction: TextInputAction.next,
                    label: widget.newUser
                        ? locale.enterFirstName
                        : locale.firstName,
                  ),
                  height(16),
                  CustomTextField(
                    textInputAction: TextInputAction.next,
                    label:
                        widget.newUser ? locale.enterLastName : locale.lastName,
                  ),
                  height(16),
                  CustomTextField(
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.number,
                    label: widget.newUser
                        ? locale.enterPhoneNumber
                        : locale.phoneNumber,
                  ),
                  height(16),
                  Padding(
                    padding: EdgeInsets.only(bottom: 3),
                    child: Text(
                      widget.newUser ? locale.selectRole : locale.role,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                  DropDownWidget(
                    universitiesList: _roles,
                    onChange: (value) {
                      setState(() {
                        _selectedRole = value!;
                      });
                    },
                    hintText: locale.selectRole,
                  ),
                  height(12),
                  Row(
                    children: [
                      Consumer(
                        builder: (context, ref, child) {
                          final isActive = ref.watch(editProfileProvider);
                          return Transform.scale(
                            scale: 1.3,
                            child: Checkbox(
                              value: isActive,
                              onChanged: (value) => ref
                                  .read(editProfileProvider.notifier)
                                  .state = value!,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              side: WidgetStateBorderSide.resolveWith(
                                (states) => const BorderSide(
                                  width: 1.0,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      width(7),
                      Text(
                        widget.newUser
                            ? locale.registerForDelivery
                            : locale.registerDelivery,
                        style: TextStyle(
                          fontSize: Dimensions.fontSizeSmall,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff6C7278),
                        ),
                      ),
                    ],
                  ),
                  height(18),
                  Consumer(
                    builder: (context, ref, child) {
                      final isActive = ref.watch(editProfileProvider);
                      return RoundedButtonWidget(
                        btnTitle: widget.newUser ? locale.next : locale.save,
                        onTap: widget.newUser
                            ? isActive
                                ? () => context.pushRoute(
                                      StudentProfileDetailsRoute(),
                                    )
                                : () => context.pushRoute(const MainRoute())
                            : isActive
                                ? () => context.maybePop()
                                : null,
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final editProfileProvider = StateProvider<bool>((ref) => false);
