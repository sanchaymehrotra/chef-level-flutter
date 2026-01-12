// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:food_chef/core/controller/home_recipes_controller.dart';
import 'package:food_chef/core/domain/di/service_locator.dart';
import 'package:food_chef/core/providers/home_provider.dart';
import 'package:food_chef/core/ui/widgets/snackbar/bottom_snackbar.dart';
import 'package:food_chef/core/utils/constant/colors/app_color.dart';
import 'package:food_chef/core/utils/function/utility.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SeeAllPopularTechniquesScreen extends StatefulWidget {
  const SeeAllPopularTechniquesScreen({super.key});

  @override
  State<SeeAllPopularTechniquesScreen> createState() =>
      _PopularTechniquesScreenState();
}

class _PopularTechniquesScreenState
    extends State<SeeAllPopularTechniquesScreen> {
  final TextEditingController searchController = TextEditingController();
  final homeRecipesController = getIt.get<HomeRecipesController>();
  bool isLoaderVisible = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    await Future.wait([getPopularTechniqueAllData()]);
  }

  Future<void> getPopularTechniqueAllData() async {
    HomeScreenProvider popularTechniqueprovider = Provider.of<HomeScreenProvider>(
      context,
      listen: false,
    );
    setState(() {
      isLoaderVisible = true;
    });
    final Map<String, dynamic> data = {
      'pageNo': popularTechniqueprovider.currentPage.toString(),
      'pageSize': popularTechniqueprovider.pageSize.toString(),
    };
    var response = await homeRecipesController.getPopularTechniqueList(data);
    setState(() {
      isLoaderVisible = false;
    });
    if (response.responseCode == 20000) {
      popularTechniqueprovider.setPopularTechniqueAllData(response.data);
    } else {
      setState(() {
      isLoaderVisible = false;
    });
      BottomSnackBar.show(
        context,
        message: response.message!,
        backgroundColor: AppColor.btnBackground,
        icon: Icons.check_circle,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _topBar(context),
              const SizedBox(height: 16),
              _searchBar(),
              const SizedBox(height: 20),
              Expanded(child: _recipeGrid()),
             Consumer<HomeScreenProvider>(
                builder: (_, provider, _) {
                  return Column(
                    children: [
                      Visibility(
                        visible: isLoaderVisible,
                        child: Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                              child: CircularProgressIndicator(
                                color: AppColor.btnBackground,
                              ),
                            ),
                          ),
                        ),
                      ),

                      Visibility(
                        visible:
                            provider.popularTechniqueFilteredAllData!.isNotEmpty &&
                            !provider.isLastPage,
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF18181B), Color(0xFF565656)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColor.ligtestGray,
                                  blurRadius: 6,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                              border: Border.all(
                                color: AppColor.btnBackground,
                                style: BorderStyle.solid,
                                width: 1.0,
                              ),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(20),
                                onTap: () {
                                  if (!provider.isLastPage) {
                                    provider.loadMoreData();
                                    getData();
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 18,
                                    vertical: 8,
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Load More',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          fontStyle: FontStyle.normal,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(width: 6),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        size: 12,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              ]
           ),
        ),
      ),
    );
  }

  /// ---------------- TOP BAR ----------------
  Widget _topBar(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            InkWell(
              onTap: () =>  {
                Navigator.pop(context,'popular_techniques_see_all'),
              },
              borderRadius: BorderRadius.circular(24),
              child: const Icon(Icons.arrow_back, color: Colors.white),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Popular Techniques',
              style: GoogleFonts.playfairDisplay(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// ---------------- SEARCH BAR ----------------
  Widget _searchBar() {
    return Container(
      height: 42,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: AppColor.ligtestGray),
        color: const Color(0xFF1C1C1C),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              autofocus: false,
              style: GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
                color: AppColor.white,
              ),
              decoration: InputDecoration.collapsed(
                hintText: "Search by tags...",
                hintStyle: TextStyle(color: AppColor.white, fontSize: 12.0),
                border: InputBorder.none,
              ),
            ),
          ),
          SizedBox(
            width: 14.0,
            height: 14.0,
            child: Image.asset('assets/images/search.png'), // Use AssetImage
          ),
        ],
      ),
    );
  }

  /// ---------------- GRID ----------------
  Widget _recipeGrid() {
    return Consumer<HomeScreenProvider>(
      builder: (_, provider, _) {
        return GridView.builder(
          itemCount: provider.popularTechniqueFilteredAllData!.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.65,
          ),
          itemBuilder: (context, index) {
            return _chefProfileCard(index, provider);
          },
        );
      },
    );
  }

  /// ---------------- CARD ----------------
  Widget _chefProfileCard(int index, HomeScreenProvider provider) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        border: Border.all(width: 1, color: AppColor.ligtestGray),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Chef image inside card
          // ClipRRect(
          //   borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          //   child:
          //       provider.popularTechniqueFilteredAllData![index].imageResponseDTO !=
          //           null
          //       ? FadeInImage.assetNetwork(
          //           image: Utility.getImageUrl(
          //             provider.popularTechniqueFilteredAllData![index].imageResponseDTO,
          //             'video_thumbnail',
          //             'assets/images/chef_default.png',
          //           ),
          //           placeholder: 'assets/images/chef_default.png',
          //           fit: BoxFit.cover,
          //           height: 120,
          //           width: double.infinity,
          //         )
          //       : FadeInImage(
          //           placeholder: const AssetImage(
          //             'assets/images/chef_default.png',
          //           ), // Your asset placeholder
          //           image: const AssetImage(
          //             'assets/images/chef_default.png',
          //           ), // Your final asset image
          //           fit: BoxFit.cover,
          //           height: 120,
          //           width: double.infinity,
          //         ),
          // ),
          Stack(
            children: [
              // Image
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: provider.popularTechniqueFilteredAllData![index].imageResponseDTO != null
                    ? FadeInImage.assetNetwork(
                  image: Utility.getImageUrl(
                    provider.popularTechniqueFilteredAllData![index].imageResponseDTO,
                    'video_thumbnail',
                    'assets/images/chef_default.png',
                  ),
                  placeholder: 'assets/images/chef_default.png',
                  fit: BoxFit.cover,
                  height: 120,
                  width: double.infinity,
                )
                    : FadeInImage(
                  placeholder: const AssetImage('assets/images/chef_default.png'),
                  image: const AssetImage('assets/images/chef_default.png'),
                  fit: BoxFit.cover,
                  height: 120,
                  width: double.infinity,
                ),
              ),

              // Play icon overlay
              Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red, // red background
                    ),
                    child: const Icon(
                      Icons.play_arrow,
                      color: Colors.white, // white arrow
                      size: 24,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Name and favorite icon
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                    child: Text(
                      provider.popularTechniqueFilteredAllData![index].chefName ?? '',
                      style: GoogleFonts.playfairDisplay(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      softWrap: true,
                    )
                ),
                InkWell(
                  onTap: () {
                    provider.isFavoritePopularTechniqueAll
                        ? provider.setIsFavoritePopularTechniqueAll(false)
                        : provider.setIsFavoritePopularTechniqueAll(true);
                  },
                  child: SizedBox(
                    width: 14.0,
                    height: 14.0,
                    child: Image.asset(
                      provider.isFavoritePopularTechniqueAll
                          ? 'assets/images/favorite_select.png'
                          : 'assets/images/favorite_unselect.png',
                    ), // Use AssetImage
                  ),
                ),
              ],
            ),
          ),

          // Top-Rated label
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Text(
              provider.popularTechniqueFilteredAllData![index].title ?? '',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),

          // const Spacer(),
          // Rating and recipe count
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    Icon(Icons.star, color: Colors.amber, size: 12),
                    SizedBox(width: 4),
                    Text(
                      '4.0 (1206).',
                      style: TextStyle(fontSize: 10, color: Colors.white54),
                    ),
                  ],
                ),
                const Text(
                  '40 Recipes.',
                  style: TextStyle(fontSize: 10, color: Colors.white54),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //---------------- Methods ---------------
}
