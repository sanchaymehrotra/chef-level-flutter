// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_chef/core/controller/user_controller.dart';
import 'package:food_chef/core/domain/di/service_locator.dart';
import 'package:food_chef/core/domain/models/preference_level/get_all_pref_data_model.dart';
import 'package:food_chef/core/domain/models/preference_level/get_saved_pref_data_model.dart';
import 'package:food_chef/core/domain/models/preference_level/save_pref_data_model%20.dart';
import 'package:food_chef/core/ui/home/home_screen.dart';
import 'package:food_chef/core/ui/widgets/loader/app_loader.dart';
import 'package:food_chef/core/ui/widgets/snackbar/bottom_snackbar.dart';
import 'package:food_chef/core/utils/constant/colors/app_color.dart';
import 'package:food_chef/core/utils/constant/string/app_string.dart';
import 'package:food_chef/core/utils/constant/prefs/shared_pref.dart';
import 'package:google_fonts/google_fonts.dart';

class PreferenceLevelScreen extends StatefulWidget {
  const PreferenceLevelScreen({super.key});

  @override
  State<PreferenceLevelScreen> createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferenceLevelScreen> {
  // Expand/collapse state
  bool dietaryExpanded = false;
  bool cuisineExpanded = false;
  //bool spiceExpanded = false;

  //radio group value
  //int _selectedVal = 0;
  //String? _selectedSpice = '';
  final userController = getIt.get<UserController>();

  // Api Data
  //List<Data>? spice_data_list;
  List<Data>? favorite_data_list;
  List<Data>? dietary_data_list;

  //final List<Data> _filters_spice = <Data>[];
  final List<Data> _filters_favorite = <Data>[];
  final List<Data> _filters_dietary = <Data>[];

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    await Future.wait([
      fetchDietaryApi('DIETARY_PREFERENCE'),
      fetchFavouriteApi('FAVOURITE_CUISINE'),
     // fetchSpiceApi('SPICE_LEVEL'),
    ]);
  }

  Future<List<Data>> fetchDietaryApi(String test) async {
    final Map<String, dynamic> data = {'check': test};
    var response = await userController.dataDefination(data);
    if (response?.responseCode == 20000) {
      dietary_data_list = response?.data;
      await SharedPrefService.setDietaryList(jsonEncode(dietary_data_list));
    } else {
      BottomSnackBar.show(
        context,
        message: response!.message!,
        backgroundColor: AppColor.btnBackground,
        icon: Icons.check_circle,
      );
    }
    return dietary_data_list ?? [];
  }

  Future<List<Data>> fetchFavouriteApi(String test) async {
    final Map<String, dynamic> data = {'check': test};
    var response = await userController.dataDefination(data);
    if (response?.responseCode == 20000) {
      favorite_data_list = response?.data;
      await SharedPrefService.setFavoriteCuisineList(jsonEncode(favorite_data_list));
    } else {
      BottomSnackBar.show(
        context,
        message: response!.message!,
        backgroundColor: AppColor.btnBackground,
        icon: Icons.check_circle,
      );
    }
    return favorite_data_list ?? [];
  }

  // Future<List<Data>> fetchSpiceApi(String test) async {
  //   final Map<String, dynamic> data = {'check': test};
  //   var response = await userController.dataDefination(data);
  //   if (response?.responseCode == 20000) {
  //     spice_data_list = response?.data;
  //     fetchFavouriteApi('FAVOURITE_CUISINE');
  //   } else {
  //     BottomSnackBar.show(
  //       context,
  //       message: response!.message!,
  //       backgroundColor: AppColor.btnBackground,
  //       icon: Icons.check_circle,
  //     );
  //   }
  //   return spice_data_list ?? [];
  // }

  Future<List<Data>> getDietary() async {
    return dietary_data_list ?? [];
  }

  Future<List<Data>> getFavorite() async {
    return favorite_data_list ?? [];
  }

  // Future<List<Data>> getSpice() async {
  //   return spice_data_list ?? [];
  // }

  Future<void> _savePrefLevelData(String jsonBodyData) async {
    AppLoader.show(context);
    GetPrefSavedData apiResponse = await userController.savePrefLevelData(
      jsonBodyData,
    );

//     {"status":"SUCCESS","message":"SUCCESS","responseCode":20000,"data":{"uid":"CU1767636564849","dietaryPreferences":["Keto","Veg"],"favouriteCuisines":["Indian","
// Italian"],"spiceLevelPreference":"Medium"}}

    if (apiResponse.responseCode == 20000) {
      AppLoader.hide();
      await SharedPrefService.setPrefLevel(true);
      BottomSnackBar.show(
        context,
        message: 'Preference saved.!!',
        backgroundColor: Colors.green,
        icon: Icons.check_circle,
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomeScreen()),
      );
    } else {
      AppLoader.hide();
      BottomSnackBar.show(
        context,
        message: apiResponse.message!,
        backgroundColor: AppColor.btnBackground,
        icon: Icons.check_circle,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/common.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => HomeScreen()),
                          );
                        },
                        child: Text(
                          AppString.skip,
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                    Text(
                      AppString.selectYourPrefs,
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal,
                        color: AppColor.white,
                      ),
                    ),
                    const SizedBox(height: 20),

                    //  Dietary Preferences Section
                    _buildExpandableSection(
                      title: AppString.dietaryPrefs,
                      expanded: dietaryExpanded,
                      onToggle: () =>
                          setState(() => dietaryExpanded = !dietaryExpanded),
                      child: Column(
                        children: <Widget>[
                          FutureBuilder<List<Data>>(
                            future: getDietary(),
                            builder:
                                (
                                  BuildContext context,
                                  AsyncSnapshot<List<Data>> snapshot,
                                ) {
                                  Widget result;
                                  if (snapshot.hasData) {
                                    result = Wrap(
                                      spacing: 10,
                                      runSpacing: 10,
                                      children: snapshot.data!.map((
                                        Data option,
                                      ) {
                                        final isSelected = _filters_dietary
                                            .contains(option);
                                        return GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              if (isSelected) {
                                                _filters_dietary.remove(option);
                                              } else {
                                                _filters_dietary.add(option);
                                              }
                                            });
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 14,
                                              vertical: 10,
                                            ),
                                            decoration: BoxDecoration(
                                              color: isSelected
                                                  ? AppColor.btnBackground
                                                  : Colors.black.withOpacity(
                                                      0.6,
                                                    ),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Text(
                                              option.value ?? '',
                                              style: GoogleFonts.montserrat(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                fontStyle: FontStyle.normal,
                                                color: isSelected
                                                    ? AppColor.white
                                                    : AppColor.white,
                                              ),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    );
                                  } else if (snapshot.hasError) {
                                    result = Text('Error: ${snapshot.error}');
                                  } else {
                                    result = const Text('Awaiting result...');
                                  }
                                  return result;
                                },
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Favourite Cuisines Section
                    _buildExpandableSection(
                      title: AppString.favouriteCuisines,
                      expanded: cuisineExpanded,
                      onToggle: () =>
                          setState(() => cuisineExpanded = !cuisineExpanded),
                      child: Column(
                        children: <Widget>[
                          FutureBuilder<List<Data>>(
                            future: getFavorite(),
                            builder:
                                (
                                  BuildContext context,
                                  AsyncSnapshot<List<Data>> snapshot,
                                ) {
                                  Widget result;
                                  if (snapshot.hasData) {
                                    result = Wrap(
                                      spacing: 10,
                                      runSpacing: 10,
                                      children: snapshot.data!.map((
                                        Data option,
                                      ) {
                                        final isSelected = _filters_favorite
                                            .contains(option);
                                        return GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              if (isSelected) {
                                                _filters_favorite.remove(
                                                  option,
                                                );
                                              } else {
                                                _filters_favorite.add(option);
                                              }
                                            });
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 14,
                                              vertical: 10,
                                            ),
                                            decoration: BoxDecoration(
                                              color: isSelected
                                                  ? AppColor.btnBackground
                                                  : Colors.black.withOpacity(
                                                      0.6,
                                                    ),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Text(
                                              option.value ?? '',
                                              style: GoogleFonts.montserrat(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                fontStyle: FontStyle.normal,
                                                color: isSelected
                                                    ? AppColor.white
                                                    : AppColor.white,
                                              ),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    );
                                  } else if (snapshot.hasError) {
                                    result = Text('Error: ${snapshot.error}');
                                  } else {
                                    result = const Text('Awaiting result...');
                                  }
                                  return result;
                                },
                          ),
                        ],
                      ),
                    ),

                    // const SizedBox(height: 20),
                    // // Spice Level Section
                    // _buildExpandableSection(
                    //   title: AppString.spiceLevelPref,
                    //   expanded: spiceExpanded,
                    //   onToggle: () =>
                    //       setState(() => spiceExpanded = !spiceExpanded),
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: <Widget>[
                    //       FutureBuilder<List<Data>>(
                    //         future: getSpice(),
                    //         builder:
                    //             (
                    //               BuildContext context,
                    //               AsyncSnapshot<List<Data>> snapshot,
                    //             ) {
                    //               Widget result;
                    //               if (snapshot.hasData) {
                    //                 result = Wrap(
                    //                   spacing: 2,
                    //                   runSpacing: 2,
                    //                   children: snapshot.data!.map((
                    //                     Data option,
                    //                   ) {
                    //                     return _buildRadio(option);
                    //                   }).toList(),
                    //                 );
                    //               } else if (snapshot.hasError) {
                    //                 result = Text('Error: ${snapshot.error}');
                    //               } else {
                    //                 result = const Text('Awaiting result...');
                    //               }
                    //               return result;
                    //             },
                    //       ),
                    //     ],
                    //   ),
                    // ),

                    const SizedBox(height: 30),

                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.btnBackground,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () async {
                          if (_filters_dietary.isNotEmpty &&
                              _filters_favorite.isNotEmpty 
                            // && _selectedSpice!.isNotEmpty
                              ) {
                            final List<String> dietaryList = _filters_dietary
                                .map((dietary) => dietary.value ?? '')
                                .toList();
                            final List<String> favouriteList = _filters_favorite
                                .map((favorite) => favorite.value ?? '')
                                .toList();

                            final payload = PrefSaveDataModel(
                              dietaryPreferences: dietaryList,
                              favouriteCuisines: favouriteList,
                             // spiceLevelPreference: _selectedSpice!,
                                spiceLevelPreference: '',
                            );

                            final jsonPayload = jsonEncode(payload.toJson());
                            print(jsonPayload);

                            await _savePrefLevelData(jsonPayload);
                          } else {
                            BottomSnackBar.show(
                              context,
                              message: 'Please select preferences.!!',
                              backgroundColor: AppColor.btnBackground,
                              icon: Icons.error,
                            );
                          }
                        },
                        child: Text(
                          AppString.save,
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                            color: AppColor.white,
                          ),
                        ),
                      ),
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

  Widget _buildExpandableSection({
    required String title,
    required bool expanded,
    required VoidCallback onToggle,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.black, // Black header background
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title, // use the parameter
                style: GoogleFonts.playfairDisplay(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                  color: AppColor.white,
                ),
              ),
              IconButton(
                icon: Icon(
                  expanded ? Icons.expand_less : Icons.expand_more,
                  color: AppColor.white,
                ),
                onPressed: onToggle,
              ),
            ],
          ),
        ),
        if (expanded)
          Padding(padding: const EdgeInsets.only(top: 8.0), child: child),
      ],
    );
  }

  // Widget _buildRadio(Data data) {
  //   return RadioListTile(
  //     contentPadding: EdgeInsets.zero,
  //     title: Text(
  //       data.value ?? '',
  //       style: GoogleFonts.montserrat(
  //         fontSize: 14,
  //         fontWeight: FontWeight.w400,
  //         fontStyle: FontStyle.normal,
  //         color: AppColor.white,
  //       ),
  //     ),
  //     value: data.id,
  //     // ignore: deprecated_member_use
  //     groupValue: _selectedVal,
  //     activeColor: AppColor.btnBackground,
  //     onChanged: (val) {
  //       setState(() {
  //         _selectedVal = data.id!;
  //         _selectedSpice = data.value;
  //       });
  //     },
  //   );
  // }
}
