import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/transportation_requests/view/widgets/transportation_widgets/persons/model/persons_model.dart';
import 'package:taxi_for_you/Features/transportation_requests/view/widgets/transportation_widgets/persons/views/widgets/first_view_dropdown.dart';
import '../../../../../../../core/utils/resources/color_manager.dart';
import '../../../../../../../core/utils/resources/strings_manager.dart';
import '../../../../../../common/widgets/custom_checkbox.dart';
import '../../../../../../common/widgets/custom_text_button.dart';
import '../../../../transport_request_viewmodel.dart';

class PersonsFirstView extends StatefulWidget {
  final PersonsModel personsModel;
  final TransportRequestViewModel viewModel;

  const PersonsFirstView({
    Key? key,
    required this.personsModel,
    required this.viewModel,
  }) : super(key: key);
  @override
  _PersonsFirstViewState createState() => _PersonsFirstViewState();
}

class _PersonsFirstViewState extends State<PersonsFirstView> {
  @override
  void initState() {
    widget.viewModel.personsViewModel.start(widget.personsModel);
    widget.viewModel.personsViewModel.validateFirstScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.fromLTRB(32, 16, 32, 32),
            child: PersonDropdownView(
              personsViewModel: widget.viewModel.personsViewModel,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Column(
            children: [
              if (widget.viewModel.personsViewModel.gender != "M")
                Column(
                  children: [
                    CustomCheckBox(
                      checked: widget
                          .viewModel.personsViewModel.personsModel.isWoman,
                      fieldName: AppStrings.needLady.tr(),
                      onChange: (checked) {
                        widget.viewModel.personsViewModel.personsModel.isWoman =
                            checked;
                      },
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  boxShadow: [
                    BoxShadow(
                      color: ColorManager.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 6,
                      offset: const Offset(0, -7),
                    )
                  ],
                ),
                child: ValueListenableBuilder(
                    valueListenable:
                        widget.viewModel.personsViewModel.firstScreenValid,
                    builder: (BuildContext context, bool value, _) {
                      return CustomTextButton(
                          text: AppStrings.next.tr(),
                          onPressed: value
                              ? () {
                                  FocusScope.of(context).unfocus();
                                  setState(() {
                                    widget.viewModel.handleSteps();
                                  });
                                }
                              : null);
                    }),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
