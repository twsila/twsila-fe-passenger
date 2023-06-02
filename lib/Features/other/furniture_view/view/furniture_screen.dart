import 'package:flutter/material.dart';

import 'package:taxi_for_you/Features/common/widgets/custom_scaffold.dart';
import 'package:taxi_for_you/Features/common/widgets/page_builder.dart';
import 'package:taxi_for_you/Features/other/furniture_view/view/widgets/furniture_top_widget.dart';
import 'furniture_viewmodel.dart';

class FurnitureScreen extends StatefulWidget {
  const FurnitureScreen({Key? key}) : super(key: key);

  @override
  State<FurnitureScreen> createState() => _FurnitureScreenState();
}

class _FurnitureScreenState extends State<FurnitureScreen> {
  final FurnitureViewModel _viewModel = FurnitureViewModel();

  @override
  void initState() {
    _viewModel.start();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      pageBuilder: PageBuilder(
        scaffoldKey: _viewModel.scaffoldKey,
        allowBackButtonInAppBar: false,
        context: context,
        body: ValueListenableBuilder<int>(
            valueListenable: _viewModel.selectedIndex,
            builder: (BuildContext context, int selectedIndex, _) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  FurnitureTopWidget(viewModel: _viewModel),
                  Expanded(
                    child: PageView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: _viewModel.controller,
                      children: _viewModel.screens,
                      onPageChanged: (value) =>
                          _viewModel.selectedIndex.value = value,
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
