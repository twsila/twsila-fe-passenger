import 'dart:io';
import 'package:country_picker/country_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taxi_for_you/presentation/register/register_viewmodel.dart';

import '../../app/app_prefs.dart';
import '../../app/constants.dart';
import '../../app/di.dart';
import '../common/state_renderer/state_renderer_impl.dart';
import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/routes_manager.dart';
import '../resources/strings_manager.dart';
import '../resources/values_manager.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final RegisterViewModel _viewModel = instance<RegisterViewModel>();
  final ImagePicker _imagePicker = instance<ImagePicker>();
  final AppPreferences _appPreferences = instance<AppPreferences>();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _userNameEditingController =
      TextEditingController();
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passwordEditingController =
      TextEditingController();
  final TextEditingController _mobileNumberEditingController =
      TextEditingController();

  _bind() {
    _viewModel.start();
    _userNameEditingController.addListener(() {
      _viewModel.setUserName(_userNameEditingController.text);
    });
    _emailEditingController.addListener(() {
      _viewModel.setEmail(_emailEditingController.text);
    });

    _passwordEditingController.addListener(() {
      _viewModel.setPassword(_passwordEditingController.text);
    });

    _mobileNumberEditingController.addListener(() {
      _viewModel.setMobileNumber(_mobileNumberEditingController.text);
    });
    _viewModel.isUserRegisteredInSuccessfullyStreamController.stream
        .listen((isLoggedIn) {
      if (isLoggedIn) {
        // navigate to main screen
        SchedulerBinding.instance?.addPostFrameCallback((_) {
          _appPreferences.setUserLoggedIn();
          Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
        });
      }
    });
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        elevation: AppSize.s0,
        backgroundColor: ColorManager.white,
        iconTheme: IconThemeData(color: ColorManager.primary),
      ),
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(context, _getContentWidget(),
                  () {
                _viewModel.register();
              }) ??
              _getContentWidget();
        },
      ),
    );
  }

  Widget _getContentWidget() {
    return Container(
        padding: const EdgeInsets.only(top: AppPadding.p28),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Center(
                    child: Image(image: AssetImage(ImageAssets.splashLogo))),
                const SizedBox(
                  height: AppSize.s28,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: AppPadding.p28, right: AppPadding.p28),
                  child: StreamBuilder<String?>(
                      stream: _viewModel.outputErrorUserName,
                      builder: (context, snapshot) {
                        return TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _userNameEditingController,
                          decoration: InputDecoration(
                              hintText: AppStrings.username.tr(),
                              labelText: AppStrings.username.tr(),
                              errorText: snapshot.data),
                        );
                      }),
                ),
                const SizedBox(
                  height: AppSize.s18,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: AppPadding.p28, right: AppPadding.p28),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: ElevatedButton(
                            onPressed: () {
                              showCountryPicker(
                                context: context,
                                //Optional.  Can be used to exclude(remove) one ore more country from the countries list (optional).
                                exclude: <String>['KN', 'MF'],
                                favorite: <String>['SE'],
                                //Optional. Shows phone code before the country name.
                                showPhoneCode: true,
                                onSelect: (Country country) {
                                  _viewModel
                                      .setCountryCode(country.countryCode);
                                },
                                // Optional. Sets the theme for the country list picker.
                                countryListTheme: CountryListThemeData(
                                  // Optional. Sets the border radius for the bottomsheet.
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(40.0),
                                    topRight: Radius.circular(40.0),
                                  ),
                                  // Optional. Styles the search field.
                                  inputDecoration: InputDecoration(
                                    labelText: 'Search',
                                    hintText: 'Start typing to search',
                                    prefixIcon: const Icon(Icons.search),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: const Color(0xFF8C98A8)
                                            .withOpacity(0.2),
                                      ),
                                    ),
                                  ),
                                  // Optional. Styles the text in the search field
                                  searchTextStyle: const TextStyle(
                                    color: Colors.blue,
                                    fontSize: 18,
                                  ),
                                ),
                              );
                            },
                            child: const Text('Show country picker'),
                          ),
                          //  showCountryPicker(
                          //                       onChanged: (country) {
                          //                         // update view model with code
                          //                         _viewModel.setCountryCode(
                          //                             country.dialCode ?? Constants.token);
                          //                       },
                          //                       initialSelection: '+20',
                          //                       favorite: const ['+39', 'FR', "+966"],
                          //                       // optional. Shows only country name and flag
                          //                       showCountryOnly: true,
                          //                       hideMainText: true,
                          //                       // optional. Shows only country name and flag when popup is closed.
                          //                       showOnlyCountryWhenClosed: true,
                          //                     ),
                        ),
                        Expanded(
                            flex: 4,
                            child: StreamBuilder<String?>(
                                stream: _viewModel.outputErrorMobileNumber,
                                builder: (context, snapshot) {
                                  return TextFormField(
                                    keyboardType: TextInputType.phone,
                                    controller: _mobileNumberEditingController,
                                    decoration: InputDecoration(
                                        hintText: AppStrings.mobileNumber.tr(),
                                        labelText: AppStrings.mobileNumber.tr(),
                                        errorText: snapshot.data),
                                  );
                                }))
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: AppSize.s18,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: AppPadding.p28, right: AppPadding.p28),
                  child: StreamBuilder<String?>(
                      stream: _viewModel.outputErrorEmail,
                      builder: (context, snapshot) {
                        return TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailEditingController,
                          decoration: InputDecoration(
                              hintText: AppStrings.emailHint.tr(),
                              labelText: AppStrings.emailHint.tr(),
                              errorText: snapshot.data),
                        );
                      }),
                ),
                const SizedBox(
                  height: AppSize.s18,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: AppPadding.p28, right: AppPadding.p28),
                  child: StreamBuilder<String?>(
                      stream: _viewModel.outputErrorPassword,
                      builder: (context, snapshot) {
                        return TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          controller: _passwordEditingController,
                          decoration: InputDecoration(
                              hintText: AppStrings.password.tr(),
                              labelText: AppStrings.password.tr(),
                              errorText: snapshot.data),
                        );
                      }),
                ),
                const SizedBox(
                  height: AppSize.s18,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: AppPadding.p28, right: AppPadding.p28),
                  child: Container(
                    height: AppSize.s40,
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(AppSize.s8)),
                        border: Border.all(color: ColorManager.grey)),
                    child: GestureDetector(
                      child: _getMediaWidget(),
                      onTap: () {
                        _showPicker(context);
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: AppSize.s40,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: AppPadding.p28, right: AppPadding.p28),
                  child: StreamBuilder<bool>(
                      stream: _viewModel.outputAreAllInputsValid,
                      builder: (context, snapshot) {
                        return SizedBox(
                          width: double.infinity,
                          height: AppSize.s40,
                          child: ElevatedButton(
                              onPressed: (snapshot.data ?? false)
                                  ? () {
                                      _viewModel.register();
                                    }
                                  : null,
                              child: Text(AppStrings.register.tr())),
                        );
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: AppPadding.p18,
                      left: AppPadding.p28,
                      right: AppPadding.p28),
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(AppStrings.alreadyHaveAccount.tr(),
                        style: Theme.of(context).textTheme.titleMedium),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  _showPicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
              child: Wrap(
            children: [
              ListTile(
                trailing: const Icon(Icons.arrow_forward),
                leading: const Icon(Icons.camera),
                title: Text(AppStrings.photoGallery.tr()),
                onTap: () {
                  _imageFromGallery();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                trailing: const Icon(Icons.arrow_forward),
                leading: const Icon(Icons.camera_alt_outlined),
                title: Text(AppStrings.photoCamera.tr()),
                onTap: () {
                  _imageFromCamera();
                  Navigator.of(context).pop();
                },
              )
            ],
          ));
        });
  }

  _imageFromGallery() async {
    var image = await _imagePicker.pickImage(source: ImageSource.gallery);
    _viewModel.setProfilePicture(File(image?.path ?? ""));
  }

  _imageFromCamera() async {
    var image = await _imagePicker.pickImage(source: ImageSource.camera);
    _viewModel.setProfilePicture(File(image?.path ?? ""));
  }

  Widget _getMediaWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: AppPadding.p8, right: AppPadding.p8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(child: Text(AppStrings.profilePicture.tr())),
          Flexible(
              child: StreamBuilder<File>(
            stream: _viewModel.outputProfilePicture,
            builder: (context, snapshot) {
              return _imagePicketByUser(snapshot.data);
            },
          )),
          Flexible(child: SvgPicture.asset(ImageAssets.photoCameraIc))
        ],
      ),
    );
  }

  Widget _imagePicketByUser(File? image) {
    if (image != null && image.path.isNotEmpty) {
      // return image
      return Image.file(image);
    } else {
      return Container();
    }
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
