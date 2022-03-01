import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logistic_management_staff/constants/enums.dart';
import 'package:logistic_management_staff/controllers/route_controller.dart';
import 'package:logistic_management_staff/views/change_password.dart';
import 'package:logistic_management_staff/views/profile_update.dart';
import 'package:logistic_management_staff/widgets/dialogs/bottom_dialog.dart';
import 'package:logistic_management_staff/widgets/dialogs/loading_dialog.dart';
import 'package:logistic_management_staff/widgets/single_personal_detail.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';
import '../constants/values.dart';
import '../controllers/authentication_controller.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_input.dart';
import '../widgets/dialogs/custom_dialog.dart' as customDialog;
import '../widgets/header.dart';
import '../widgets/profile_info_heading.dart';
import 'history.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final List<TextEditingController> _assignedRoutes = [];
  final List<TextEditingController> _assignedVechiles = [];

  @override
  void initState() {
    _assignedRoutes.add(TextEditingController(text: '1. Bhaktapur'));
    _assignedRoutes.add(TextEditingController(text: '2. Kathamandu'));
    _assignedVechiles.add(TextEditingController(text: '1. Jeep'));
    super.initState();
  }

  @override
  void dispose() {
    for (TextEditingController c in _assignedRoutes) {
      c.dispose();
    }
    for (TextEditingController c in _assignedVechiles) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final auth = context.watch<AuthenticationController>();
    final route = context.watch<RouteController>();
    return Column(
      children: [
        Header(
          title: 'Profile',
          trailing: IconButton(
            onPressed: () {
              customDialog.CustomDialogs.dialogs.showCustomDialog(
                context: context,
                type: customDialog.DialogType.logout,
              );

              // context.read<AuthenticationController>().logOut();
              // Navigator.pushAndRemoveUntil(
              //   context,
              //   MaterialPageRoute(builder: (_) => const Login()),
              //   (route) => false,
              // );
            },
            icon: const Icon(
              Icons.exit_to_app_rounded,
              color: RED,
            ),
            tooltip: 'Logout',
          ),
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () => route.getVechile(),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(height: BASE_PADDING),
                  Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                            auth.userModel?.photo ?? '',
                          ),
                          radius: size.width * 0.2,
                          backgroundColor: TEXT_BLUE.withOpacity(0.2),
                        ),
                        Positioned(
                          bottom: 4.0,
                          right: 4.0,
                          child: CircleAvatar(
                            radius: 18.0,
                            backgroundColor: TEXT_WHITE,
                            child: CircleAvatar(
                              backgroundColor: BUTTON_BLUE,
                              radius: 16.0,
                              child: IconButton(
                                onPressed: () => _uploadImage(context),
                                icon: const Icon(
                                  Icons.camera_alt_rounded,
                                  color: TEXT_WHITE,
                                  size: 16.0,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: BASE_PADDING),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ChangePassword(),
                        ),
                      );
                    },
                    child: const Text(
                      'Change Password',
                      style: TextStyle(
                        color: RED,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(RADIUS),
                        // side: BorderSide(
                        //   color: RED,
                        // ),
                      ),
                    ),
                  ),
                  const SizedBox(height: BASE_PADDING),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProfileInfoHeading(
                        title: 'Basic Information',
                        onTab: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const ProfileUpdate(),
                            ),
                          );
                        },
                      ),
                      ProfileDetailRow(
                        title: 'Name',
                        value: auth.userModel?.name ?? '',
                      ),
                      ProfileDetailRow(
                        title: 'Experience',
                        value: auth.userModel?.name == null
                            ? ''
                            : '${auth.userModel?.experience} Years',
                      ),
                      ProfileDetailRow(
                        title: 'Mobile Number',
                        value: auth.userModel?.phone ?? '',
                      ),
                      ProfileDetailRow(
                        title: 'Email',
                        value: auth.userModel?.email ?? '',
                      ),
                      const SizedBox(height: BASE_PADDING * 2),
                      const ProfileInfoHeading(
                        title: 'Assigned Routes',
                      ),
                      if (route.vehicle?.data?.route != null)
                        Padding(
                          padding: const EdgeInsets.all(BASE_PADDING),
                          child: CustomInput(
                            controller: TextEditingController(
                              text:
                                  route.vehicle?.data?.route?.routeTitle ?? '',
                            ),
                            hint: route.vehicle?.data?.route?.routeTitle ?? '',
                            enabled: false,
                          ),
                        ),
                      if (route.vehicle?.data?.route == null)
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(BASE_PADDING * 2),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  'No assigned routes for today right now.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: TEXT_SECONDARY,
                                    fontSize: TITLE_TEXT + 4.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () => route.getVechile(),
                                  icon: const Icon(Icons.refresh_rounded),
                                ),
                              ],
                            ),
                          ),
                        ),
                      if (route.vehicle?.data?.route != null)
                        const SizedBox(height: BASE_PADDING),
                      const ProfileInfoHeading(title: 'Assigned Vehicle'),
                      if (route.vehicle?.data?.vehicle != null)
                        Padding(
                          padding: const EdgeInsets.all(BASE_PADDING),
                          child: CustomInput(
                            controller: TextEditingController(
                              text: route.vehicle?.data?.vehicle?.regNo ?? '',
                            ),
                            hint: route.vehicle?.data?.vehicle?.regNo ?? '',
                            enabled: false,
                          ),
                        ),
                      if (route.vehicle?.data?.vehicle == null)
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(BASE_PADDING * 2),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  'No assigned vehicle for today right now.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: TEXT_SECONDARY,
                                    fontSize: TITLE_TEXT + 4.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () => route.getVechile(),
                                  icon: const Icon(Icons.refresh_rounded),
                                ),
                              ],
                            ),
                          ),
                        ),
                      if (route.vehicle?.data?.vehicle != null)
                        const SizedBox(height: BASE_PADDING),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: BASE_PADDING,
                        ),
                        child: CustomButton(
                          title: 'View History',
                          onTab: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (cxt) => const HistoryView(),
                              ),
                            );
                          },
                        ),
                      ),
                      // SizedBox(height: BASE_PADDING / 2),
                      // CustomButton(
                      //   title: 'Logout',
                      //   onTab: () {
                      //     auth.logOut();
                      //     Navigator.pushAndRemoveUntil(
                      //       context,
                      //       MaterialPageRoute(
                      //         builder: (_) => Login(),
                      //       ),
                      //       (route) => false,
                      //     );
                      //   },
                      // ),
                      const SizedBox(height: 60),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  _uploadImage(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(RADIUS),
        ),
      ),
      builder: (_) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: BASE_PADDING),
              ListTile(
                leading: const Icon(
                  Icons.photo_library_rounded,
                  color: TEXT_BLUE,
                ),
                title: const Text(
                  'Select photo from gallery',
                  style: TextStyle(
                    color: TEXT_BLUE,
                    fontWeight: FontWeight.bold,
                    fontSize: TITLE_TEXT,
                  ),
                ),
                horizontalTitleGap: 0.0,
                onTap: () async {
                  Navigator.pop(context);
                  XFile? image = await _fromGallery();

                  if (image != null) {
                    _saveImage(context, image);
                  }
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.camera_alt_rounded,
                  color: TEXT_BLUE,
                ),
                title: const Text(
                  'Take photo from camera',
                  style: TextStyle(
                    color: TEXT_BLUE,
                    fontWeight: FontWeight.bold,
                    fontSize: TITLE_TEXT,
                  ),
                ),
                horizontalTitleGap: 0.0,
                onTap: () async {
                  Navigator.pop(context);
                  XFile? image = await _fromCamera();

                  if (image != null) {
                    _saveImage(context, image);
                  }
                },
              ),
              const SizedBox(height: BASE_PADDING),
            ],
          ),
        );
      },
    );
  }

  Future<XFile?> _fromCamera() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    return image;
  }

  Future<XFile?> _fromGallery() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    return image;
  }

  _saveImage(BuildContext context, XFile image) async {
    final croppedImage = await ImageCropper().cropImage(
      sourcePath: image.path,
      aspectRatioPresets: [CropAspectRatioPreset.square],
      androidUiSettings: const AndroidUiSettings(
        toolbarTitle: 'Crop Profile Image',
        toolbarColor: BUTTON_BLUE,
        toolbarWidgetColor: TEXT_WHITE,
        initAspectRatio: CropAspectRatioPreset.square,
        lockAspectRatio: false,
        activeControlsWidgetColor: BUTTON_BLUE,
      ),
      iosUiSettings: const IOSUiSettings(
        title: 'Crop Profile Image',
        minimumAspectRatio: 1.0,
      ),
    );

    if (croppedImage != null) {
      var progressDialog = getProgressDialog(context: context);
      progressDialog.show(useSafeArea: false);

      var result = await context
          .read<AuthenticationController>()
          .updateImage(path: croppedImage.path);

      progressDialog.dismiss();

      if (result) {
        showBottomDialog(
          context: context,
          dialogType: DialogType.SUCCESS,
          title: 'Update Successfully',
          message: 'Your profile photo is updated successfully.',
        );
      } else {
        showBottomDialog(
          context: context,
          dialogType: DialogType.ERROR,
          title: 'Update Error',
        );
      }
    } else {
      showBottomDialog(
        context: context,
        dialogType: DialogType.ERROR,
        title: 'Update Error',
      );
    }
  }
}
