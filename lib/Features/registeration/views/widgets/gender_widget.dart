import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/registeration/models/gender_model.dart';
import 'package:taxi_for_you/Features/registeration/views/registeration_viewmodel.dart';
import 'package:taxi_for_you/core/utils/resources/color_manager.dart';

class GenderWidget extends StatefulWidget {
  final Function(GenderModel) onSelectGender;
  const GenderWidget({Key? key, required this.onSelectGender})
      : super(key: key);

  @override
  State<GenderWidget> createState() => _GenderWidgetState();
}

class _GenderWidgetState extends State<GenderWidget> {
  final RegisterationViewModel _viewModel = RegisterationViewModel();
  late GenderModel _selectedGender;

  @override
  initState() {
    _selectedGender = _viewModel.genderTypes[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        _viewModel.genderTypes.length,
        (index) => GestureDetector(
          onTap: () {
            setState(() {
              _selectedGender = _viewModel.genderTypes[index];
            });
            widget.onSelectGender(_selectedGender);
          },
          child: Container(
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: _viewModel.genderTypes[index] == _selectedGender
                  ? ColorManager.accentColor
                  : Colors.transparent,
              border: Border.all(
                color: _viewModel.genderTypes[index] == _selectedGender
                    ? Colors.transparent
                    : ColorManager.lightGrey,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(4),
              ),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Text(
                _viewModel.genderTypes[index].name,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Colors.black,
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
