import 'package:flutter/material.dart';
import 'package:taxi_for_you/Features/common/widgets/custom_back_button.dart';
import 'package:taxi_for_you/core/utils/ext/screen_size_ext.dart';
import 'package:taxi_for_you/core/utils/resources/assets_manager.dart';
import 'package:taxi_for_you/core/utils/resources/color_manager.dart';
import 'package:taxi_for_you/data/model/country.dart';

import 'custom_flag_widget.dart';

class CustomCoutnryCodesWidget extends StatefulWidget {
  final List<CountryModel> countries;
  final CountryModel? selectedCountry;
  final Function(CountryModel) getCountryCode;

  CustomCoutnryCodesWidget({
    Key? key,
    required this.countries,
    required this.selectedCountry,
    required this.getCountryCode,
  }) : super(key: key);

  @override
  State<CustomCoutnryCodesWidget> createState() =>
      _CustomCoutnryCodesWidgetState();
}

class _CustomCoutnryCodesWidgetState extends State<CustomCoutnryCodesWidget> {
  final TextEditingController _searchController = TextEditingController();
  List<CountryModel> _filteredCountries = [];
  CountryModel? _selectedCountry;

  @override
  void initState() {
    _filteredCountries = widget.countries;
    _selectedCountry = widget.selectedCountry;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.countries.length > 6
        ? Stack(
            children: [
              Positioned(
                top: 42,
                left: 16,
                child: CustomBackButton(),
              ),
              Positioned(
                  top: (context.getHeight() / 8),
                  left: 0,
                  bottom: 0,
                  right: 0,
                  child: countriesWidget()),
            ],
          )
        : countriesWidget();
  }

  Widget countriesWidget() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.withOpacity(0.4)),
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(16),
            topLeft: Radius.circular(16),
          )),
      child: Column(
        children: [
          if (widget.countries.length > 6)
            Column(
              children: [
                searchBarWidget(),
                Container(
                  height: 2,
                  color: ColorManager.primary,
                ),
              ],
            ),
          Expanded(
            child: _filteredCountries.isNotEmpty
                ? ListView.builder(
                    shrinkWrap: true,
                    cacheExtent: 9999,
                    itemCount: _filteredCountries.length,
                    itemBuilder: ((context, index) {
                      var country = _filteredCountries[index];
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            FocusScope.of(context).unfocus();
                            _selectedCountry = country;
                            if (_selectedCountry == null) return;
                            widget.getCountryCode(_selectedCountry!);
                          });

                          Navigator.of(context).pop();
                        },
                        child: Container(
                          margin: const EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomNetworkImage(
                                imageUrl: country.imageURL,
                              ),
                              const SizedBox(width: 5),
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                    children: highlightOccurrences(
                                        "(${country.countryCode}) ${country.countryName}",
                                        _searchController.text),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: _selectedCountry != null &&
                                              _selectedCountry!.countryID ==
                                                  country.countryID
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                              _selectedCountry != null &&
                                      _selectedCountry!.countryID ==
                                          country.countryID
                                  ? SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: Image.asset(ImageAssets.checkIcon),
                                    )
                                  : const SizedBox()
                            ],
                          ),
                        ),
                      );
                    }),
                  )
                : const Center(
                    child: Text(
                      'No Results Found!!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Chalkboard SE',
                        color: Colors.black,
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(1.0, 1.0),
                            blurRadius: 5.0,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  void changeText() {
    if (_searchController.text.isNotEmpty) {
      List<CountryModel> _result = [];
      _result = widget.countries
          .where(
            (element) =>
                element.countryName
                    .toLowerCase()
                    .contains(_searchController.text.toLowerCase()) ||
                element.countryCode
                    .contains(_searchController.text.toLowerCase()),
          )
          .toList();

      setState(() {
        _filteredCountries = _result;
      });
    } else {
      setState(() {
        _filteredCountries = widget.countries;
      });
    }
  }

  List<TextSpan> highlightOccurrences(String source, String query) {
    if (query.isEmpty || !source.toLowerCase().contains(query.toLowerCase())) {
      return [TextSpan(text: source)];
    }
    final matches = query.toLowerCase().allMatches(source.toLowerCase());

    int lastMatchEnd = 0;

    final List<TextSpan> children = [];
    for (var i = 0; i < matches.length; i++) {
      final match = matches.elementAt(i);

      if (match.start != lastMatchEnd) {
        children.add(
          TextSpan(
            text: source.substring(lastMatchEnd, match.start),
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        );
      }

      children.add(
        TextSpan(
          text: source.substring(match.start, match.end),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: ColorManager.primary,
          ),
        ),
      );

      if (i == matches.length - 1 && match.end != source.length) {
        children.add(TextSpan(
          text: source.substring(match.end, source.length),
          style: const TextStyle(color: Colors.black),
        ));
      }

      lastMatchEnd = match.end;
    }
    return children;
  }

  Widget searchBarWidget() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: _searchController,
              cursorColor: Colors.black,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              style: const TextStyle(color: Colors.black),
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 8),
                hintText: "Search...",
                hintStyle: TextStyle(color: Colors.black),
              ),
              onChanged: (value) {
                changeText();
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.all(8),
            child: const Icon(
              Icons.search,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
