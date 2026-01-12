// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:food_chef/core/controller/home_recipes_controller.dart';
import 'package:food_chef/core/domain/di/service_locator.dart';
import 'package:food_chef/core/providers/home_provider.dart';
import 'package:food_chef/core/providers/item_details_provider.dart';
import 'package:food_chef/core/ui/auth/login_screen.dart';
import 'package:food_chef/core/ui/home/popular_cuisine/popular_cuisine_details_screen.dart';
import 'package:food_chef/core/ui/home/tailored_recipes/receipe_details_screen.dart';
import 'package:food_chef/core/ui/widgets/snackbar/bottom_snackbar.dart';
import 'package:food_chef/core/ui/home/food_banner.dart';
import 'package:food_chef/core/ui/home/master_chefs/see_all_master_chef_screen.dart';
import 'package:food_chef/core/ui/home/popular_techniques/see_all_popular_techniques_screen.dart';
import 'package:food_chef/core/ui/home/tailored_recipes/see_all_receipe_home_screen.dart';
import 'package:food_chef/core/utils/constant/colors/app_color.dart';
import 'package:food_chef/core/utils/constant/fonts/font_style.dart';
import 'package:food_chef/core/utils/constant/prefs/shared_pref.dart';
import 'package:food_chef/core/utils/function/utility.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final homeRecipesController = getIt.get<HomeRecipesController>();
  final GlobalKey<ScaffoldState> global_key = GlobalKey();

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    await Future.wait([getHomeRecipesData()]);
  }

  Future<void> getHomeRecipesData() async {
    HomeScreenProvider homeProvider = Provider.of<HomeScreenProvider>(
      context,
      listen: false,
    );
    final Map<String, dynamic> data = {'pageNo': '0', 'pageSize': '10'};
    var response = await homeRecipesController.getHomeData(data);
    if (response.responseCode == 20000) {
      homeProvider.setHomeRecipesData(response.data);
    } else {
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
      key: global_key,
      drawer: _buildDrawer(context, global_key),
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            padding: EdgeInsets.all(18.0),
            icon: Image.asset('assets/images/drawer.png'),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 6),
            child: IconButton(
              padding: EdgeInsets.zero, // Remove padding first
              constraints: BoxConstraints.tight(
                Size(24, 24),
              ), // Force 32x32 size
              icon: Image.asset('assets/images/cart_rounded.png'),
              onPressed: () {
                // To do
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 6),
            child: IconButton(
              padding: EdgeInsets.zero, // Remove padding first
              constraints: BoxConstraints.tight(
                Size(24, 24),
              ), // Force 32x32 size
              icon: Image.asset('assets/images/search_rounded.png'),

              onPressed: () {
                // To do
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: IconButton(
              padding: const EdgeInsets.all(0),
              constraints: BoxConstraints.tight(const Size.square(28)),
              icon: CircleAvatar(
                radius: 14,
                backgroundImage: AssetImage(
                  'assets/images/default_profile_pic.png',
                ),
              ),
              onPressed: () {
                // To do
              },
            ),
          ),

          // Padding(
          //   padding: const EdgeInsets.only(right: 10),
          //   child: SizedBox(
          //     width: 18.0,
          //     height: 18.0,
          //     child: Image.asset(
          //       'assets/images/search_rounded.png',
          //     ), // Use AssetImage
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.only(right: 8),
          //   child: SizedBox(
          //     width: 18.0,
          //     height: 18.0,
          //     child: Image.asset(
          //       'assets/images/cart_rounded.png',
          //     ), // Use AssetImage
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.only(right: 18),
          //   child: CircleAvatar(
          //     radius: 14,
          //     backgroundImage: AssetImage('assets/images/common.png'),
          //   ),
          // ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _headerText(),
            const SizedBox(height: 24),
            FoodBanner(),
            const SizedBox(height: 24),
            Consumer<HomeScreenProvider>(
              builder: (_, provider, _) {
                return Visibility(
                  visible: provider.tailoredRecipesHomeData!.isNotEmpty,
                  child: Column(
                    children: [
                      _sectionTitle(
                        title: 'Tailored Recipes for You',
                        onSeeAllTap: () {
                          _refreshData(context, 'tailored_recipies_see_all');
                        },
                        isShow: true,
                      ),
                      const SizedBox(height: 12),
                      _recipeHorizontalList(),
                    ],
                  ),
                );
              },
            ),

            Consumer<HomeScreenProvider>(
              builder: (_, provider, _) {
                return Visibility(
                  visible: provider.masterChefHomeData!.isNotEmpty,
                  child: Column(
                    children: [
                      const SizedBox(height: 12),
                      _sectionTitle(
                        title: 'Master Chefs',
                        onSeeAllTap: () {
                          _refreshData(context, 'master_chef_see_all');
                        },
                        isShow: true,
                      ),
                      const SizedBox(height: 12),
                      _chefHorizontalList(),
                    ],
                  ),
                );
              },
            ),

            const SizedBox(height: 12),
            _sectionTitle(
              title: 'Popular Cuisine',
              onSeeAllTap: () {},
              isShow: false,
            ),
            const SizedBox(height: 12),
            _cuisineGrid(context),
            Consumer<HomeScreenProvider>(
              builder: (_, provider, _) {
                return Visibility(
                  visible: provider.popularTechniquesHomeData!.isNotEmpty,
                  child: Column(
                    children: [
                      const SizedBox(height: 12),
                      _sectionTitle(
                        title: 'Popular Techniques',
                        onSeeAllTap: () {
                          _refreshData(context, 'popular_techniques_see_all');
                        },
                        isShow: true,
                      ),
                      const SizedBox(height: 12),
                      _techniqueHorizontalList(),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  // ---------------- WIDGETS ----------------

  Widget _headerText() {
    return Text(
      'Find your Best Chef & Recipe\naround you',
      style: GoogleFonts.playfairDisplay(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
        color: AppColor.white,
      ),
    );
  }

  Widget _sectionTitle({
    required String title,
    VoidCallback? onSeeAllTap,
    required bool isShow,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppFontStyle.whiteText14Bold),
        InkWell(
          onTap: onSeeAllTap,
          child: isShow
              ? Text('See All', style: AppFontStyle.redText12NormalMont)
              : Text('', style: AppFontStyle.redText12NormalMont),
        ),
      ],
    );
  }

  Widget _recipeHorizontalList() {
    return Consumer<HomeScreenProvider>(
      builder: (_, provider, _) {
        return SizedBox(
          height: 210,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: provider.tailoredRecipesHomeData!.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  _openDetailPage(context, 'recipies_details', index);
                },
                child: _recipeCard(index, provider),
              );
            },
          ),
        );
      },
    );
  }
}

Widget _recipeCard(int index, HomeScreenProvider provider) {
  return Container(
    width: 160,
    margin: const EdgeInsets.only(right: 16),
    decoration: BoxDecoration(
      border: Border.all(width: 1, color: AppColor.ligtestGray),

      color: Colors.white.withOpacity(0.08),
      borderRadius: BorderRadius.circular(16),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // IMAGE WITH HEART ICON
        Expanded(
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: FadeInImage(
                  placeholder: AssetImage('assets/images/cuisine_default.png'),
                  image: provider.tailoredRecipesHomeData![index].image != null
                      ? NetworkImage(
                          Utility.getImageUrl(
                            provider.tailoredRecipesHomeData![index].image,
                            'recipe',
                            'assets/images/cuisine_default.png',
                          ),
                        )
                      : AssetImage('assets/images/cuisine_default.png'),
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              // HEART ICON (TOP RIGHT)
              Positioned(
                top: 8,
                right: 8,
                child: Consumer<HomeScreenProvider>(
                  builder: (_, provider, _) {
                    return InkWell(
                      onTap: () {
                        provider.isFavoriteHome
                            ? provider.setIsFavoriteTailoredHome(false)
                            : provider.setIsFavoriteTailoredHome(true);
                      },
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.4),
                          shape: BoxShape.circle,
                        ),
                        child: SizedBox(
                          width: 14.0,
                          height: 14.0,
                          child: Image.asset(
                            provider.isFavoriteHome
                                ? 'assets/images/favorite_select.png'
                                : 'assets/images/favorite_unselect.png',
                          ), // Use AssetImage
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),

        // TEXT CONTENT
        Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                provider.tailoredRecipesHomeData![index].dishName ?? '',
                textAlign: TextAlign.center,
                style: GoogleFonts.playfairDisplay(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColor.white,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                provider.tailoredRecipesHomeData![index].chefName ?? '',
                style: GoogleFonts.montserrat(
                  fontSize: 8,
                  fontWeight: FontWeight.w400,
                  color: AppColor.lightgray,
                ),
              ),
              const SizedBox(height: 4),

              // STAR + TIME ROW
              Padding(
                padding: const EdgeInsets.all(6),
                child: Row(
                  children: [
                    Text(
                      '⭐ 4.8 (120).',
                      style: GoogleFonts.montserrat(
                        fontSize: 8,
                        fontWeight: FontWeight.w400,
                        color: AppColor.lightgray,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '${provider.tailoredRecipesHomeData![index].prepTime} min',
                      style: GoogleFonts.montserrat(
                        fontSize: 8,
                        fontWeight: FontWeight.w400,
                        color: AppColor.lightgray,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

//---------------- Methods ---------------

Widget _chefHorizontalList() {
  return Consumer<HomeScreenProvider>(
    builder: (_, provider, _) {
      return SizedBox(
        height: 150,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: provider.masterChefHomeData!.length,
          itemBuilder: (context, index) {
            return Container(
              width: 220,
              margin: const EdgeInsets.only(right: 16),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: AppColor.ligtestGray),
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: NetworkImage(
                    Utility.getImageUrl(
                      provider.masterChefHomeData![index].imageResponse,
                      'chef_profile_photo',
                      'assets/images/chef_default.png',
                    ),
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Colors.black.withOpacity(0.8), Colors.transparent],
                  ),
                ),
                child: Row(
                  children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            provider.masterChefHomeData![index].name ?? '',
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.normal,
                              color: AppColor.white,
                            ),
                          ),
                          Text(
                            '⭐ 4.9.',
                            style: GoogleFonts.montserrat(
                              fontSize: 8,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              color: AppColor.lightgray,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),

                    Align(
                      alignment: Alignment.bottomRight,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Top-Rated.',
                            style: GoogleFonts.montserrat(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: AppColor.lightgray,
                            ),
                          ),
                          Text(
                            '${provider.masterChefHomeData![index].recipeCount} Recipies',
                            style: GoogleFonts.montserrat(
                              fontSize: 8,
                              fontWeight: FontWeight.w400,
                              color: AppColor.lightgray,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    },
  );
}

Widget _cuisineGrid(BuildContext context) {
  return GridView.count(
    crossAxisCount: 3,
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    crossAxisSpacing: 12,
    mainAxisSpacing: 12,
    children: List.generate(
      6,
      (index) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: index == 0
                ? AssetImage('assets/images/italian.png')
                : index == 1
                ? AssetImage('assets/images/japenies.png')
                : index == 2
                ? AssetImage('assets/images/maxican.png')
                : index == 3
                ? AssetImage('assets/images/vegeterian.png')
                : index == 4
                ? AssetImage('assets/images/bbq.png')
                : AssetImage('assets/images/deserts.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: GestureDetector(
          onTap: () {
            _refreshData(
              context,
              'popular_cuisine_details',
              index == 0
                  ? 'Italian'
                  : index == 1
                  ? 'Japanese'
                  : index == 2
                  ? 'Mexican'
                  : index == 3
                  ? 'Vegetarian'
                  : index == 4
                  ? 'BBQ'
                  : 'Desserts',
            );
          },

          child: Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: AppColor.ligtestGray),

              borderRadius: BorderRadius.circular(16),
              color: Colors.black.withOpacity(0.4),
            ),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Text(
                  index == 0
                      ? 'Italian'
                      : index == 1
                      ? 'Japanese'
                      : index == 2
                      ? 'Mexican'
                      : index == 3
                      ? 'Vegetarian'
                      : index == 4
                      ? 'BBQ'
                      : 'Desserts',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                    color: AppColor.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

Future<void> _refreshData(
  BuildContext context,
  String? title, [
  String? val,
]) async {
  if (title == 'tailored_recipies_see_all') {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SeeAllTailoredRecipeHomeScreen()),
    );
    if (result != null && result == 'tailored_recipies_see_all') {
      Provider.of<HomeScreenProvider>(context, listen: false).clearSeeAllData();
    }
  } else if (title == 'master_chef_see_all') {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SeeAllMasterChefScreen()),
    );
    if (result != null && result == 'master_chef_see_all') {
      Provider.of<HomeScreenProvider>(context, listen: false).clearSeeAllData();
    }
  } else if (title == 'popular_techniques_see_all') {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SeeAllPopularTechniquesScreen()),
    );
    if (result != null && result == 'popular_techniques_see_all') {
      Provider.of<HomeScreenProvider>(context, listen: false).clearSeeAllData();
    }
  } else if (title == 'popular_cuisine_details') {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            PopularCuisineDetailsScreen(cuisineTitle: val ?? 'dafult'),
      ),
    );
    if (result != null && result == 'popular_cuisine_details') {
      Provider.of<ItemDetailsProvider>(context, listen: false).clearAllData();
    }
  }
}

Future<void> _openDetailPage(
  BuildContext context,
  String pageType,
  int index,
) async {
  if (pageType == 'recipies_details') {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RecipeDetailsScreen(clickedIndex: index),
      ),
    );
  }
}

Widget _techniqueHorizontalList() {
  return Consumer<HomeScreenProvider>(
    builder: (_, provider, _) {
      return SizedBox(
        height: 160,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: provider.popularTechniquesHomeData!.length,
          itemBuilder: (context, index) {
            return Container(
              width: 240,
              margin: const EdgeInsets.only(right: 16),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: AppColor.ligtestGray),
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: NetworkImage(
                    Utility.getImageUrl(
                      provider
                          .popularTechniquesHomeData![index]
                          .imageResponseDTO,
                      'video_thumbnail',
                      'assets/images/popular_technique_default.png',
                    ),
                  ),
                  fit: BoxFit.cover,
                ),
              ),

              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Colors.black.withOpacity(0.8), Colors.transparent],
                  ),
                ),
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: 28.0,
                          height: 28.0,
                          child: Image.asset(
                            'assets/images/play.png',
                          ), // Use AssetImage
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          children: [
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    provider
                                            .popularTechniquesHomeData![index]
                                            .chefName ??
                                        '',
                                    style: GoogleFonts.playfairDisplay(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FontStyle.normal,
                                      color: AppColor.white,
                                    ),
                                  ),
                                  Text(
                                    provider
                                            .popularTechniquesHomeData![index]
                                            .title ??
                                        '',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 8,
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                      color: AppColor.lightgray,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '35 Min.',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 8,
                                      fontWeight: FontWeight.w400,
                                      color: AppColor.lightgray,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                // Center(
                //   child: SizedBox(
                //           width: 24.0,
                //           height: 24.0,
                //           child: Image.asset(
                //             'assets/images/play.png',
                //           ), // Use AssetImage
                //         ),
                // ),
                // Row(
                //     children: [
                //       Align(
                //         alignment: Alignment.bottomLeft,
                //         child: Column(
                //           mainAxisAlignment: MainAxisAlignment.end,
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             Text(
                //               index==0?'Master Class: Knife Skills':index==1?'Master Class: BBQ':'Master Class: Barbie',
                //               style: GoogleFonts.playfairDisplay(
                //                 fontSize: 12,
                //                 fontWeight: FontWeight.w600,
                //                 fontStyle: FontStyle.normal,
                //                 color: AppColor.white,
                //               ),
                //             ),
                //             Text(
                //               'Chef marco',
                //               style: GoogleFonts.montserrat(
                //                 fontSize: 8,
                //                 fontWeight: FontWeight.w400,
                //                 fontStyle: FontStyle.normal,
                //                 color: AppColor.lightgray,
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //       Spacer(),
                //       Align(
                //         alignment: Alignment.bottomRight,
                //         child: Column(
                //           mainAxisAlignment: MainAxisAlignment.end,
                //           crossAxisAlignment: CrossAxisAlignment.end,
                //           children: [
                //             Text(
                //               '35 Min',
                //               style: GoogleFonts.montserrat(
                //                 fontSize: 8,
                //                 fontWeight: FontWeight.w400,
                //                 color: AppColor.lightgray,
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //     ],
                //   ),
              ),
            );
          },
        ),
      );
    },
  );
}

Widget _buildDrawer(BuildContext context, GlobalKey<ScaffoldState> global_key) {
  return Drawer(
    backgroundColor: Colors.black,
    child: Column(
      // Changed this to a Column from a ListView
      children: <Widget>[
        _createHeader(context, global_key),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  alignment: AlignmentGeometry.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      'Your Information',
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                        color: AppColor.white,
                      ),
                    ),
                  ),
                ),
                ListTile(
                  leading: SizedBox(
                    width: 24.0,
                    height: 24.0,
                    child: Image.asset(
                      'assets/images/your_orders.png',
                    ), // Use AssetImage
                  ),
                  title: Text(
                    'Your Orders',
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      color: AppColor.white,
                    ),
                  ),
                ),
                ListTile(
                  leading: SizedBox(
                    width: 24.0,
                    height: 24.0,
                    child: Image.asset(
                      'assets/images/save_recipes.png',
                    ), // Use AssetImage
                  ),
                  title: Text(
                    'Wishlist',
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      color: AppColor.white,
                    ),
                  ),
                ),
                ListTile(
                  leading: SizedBox(
                    width: 24.0,
                    height: 24.0,
                    child: Image.asset(
                      'assets/images/coupans.png',
                    ), // Use AssetImage
                  ),
                  title: Text(
                    'Coupons',
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      color: AppColor.white,
                    ),
                  ),
                ),
                ListTile(
                  leading: SizedBox(
                    width: 24.0,
                    height: 24.0,
                    child: Image.asset(
                      'assets/images/earn_rewards.png',
                    ), // Use AssetImage
                  ),
                  title: Text(
                    'Earn & Redeem',
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      color: AppColor.white,
                    ),
                  ),
                ),
                ListTile(
                  leading: SizedBox(
                    width: 24.0,
                    height: 24.0,
                    child: Image.asset(
                      'assets/images/address_book.png',
                    ), // Use AssetImage
                  ),
                  title: Text(
                    'Address Book',
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      color: AppColor.white,
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentGeometry.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      'Others',
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                        color: AppColor.white,
                      ),
                    ),
                  ),
                ),

                ListTile(
                  leading: SizedBox(
                    width: 24.0,
                    height: 24.0,
                    child: Image.asset(
                      'assets/images/share.png',
                    ), // Use AssetImage
                  ),
                  title: Text(
                    'Share App',
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      color: AppColor.white,
                    ),
                  ),
                ),
                ListTile(
                  leading: SizedBox(
                    width: 24.0,
                    height: 24.0,
                    child: Image.asset(
                      'assets/images/about_us.png',
                    ), // Use AssetImage
                  ),
                  title: Text(
                    'About Us',
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      color: AppColor.white,
                    ),
                  ),
                ),
                ListTile(
                  leading: SizedBox(
                    width: 24.0,
                    height: 24.0,
                    child: Image.asset(
                      'assets/images/settings.png',
                    ), // Use AssetImage
                  ),
                  title: Text(
                    'Settings',
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      color: AppColor.white,
                    ),
                  ),
                ),
                ListTile(
                  leading: SizedBox(
                    width: 24.0,
                    height: 24.0,
                    child: Image.asset(
                      'assets/images/privacy_center.png',
                    ), // Use AssetImage
                  ),
                  title: Text(
                    'Privacy Center',
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      color: AppColor.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        _createFooterItem(context),
      ],
    ),
  );
}

Widget _createFooterItem(BuildContext context) {
  return DecoratedBox(
    decoration: BoxDecoration(color: Colors.black),
    child: ListTile(
      onTap: () async {
        // await SharedPrefService.clearOnLogout();
        await SharedPrefService.setLoggedIn(false);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => LoginScreen()),
          (route) => false,
        );
      },
      leading: SizedBox(
        width: 24.0,
        height: 24.0,
        child: Image.asset('assets/images/logout.png'), // Use AssetImage
      ),
      title: Text(
        'Logout',
        style: GoogleFonts.montserrat(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          color: AppColor.white,
        ),
      ),
    ),
  );
}

Widget _createHeader(
  BuildContext context,
  GlobalKey<ScaffoldState> global_key,
) {
  return Theme(
    data: Theme.of(
      context,
    ).copyWith(dividerTheme: const DividerThemeData(color: Colors.transparent)),
    child: SizedBox(
      height: 50.0, // Set your desired height here
      child: DrawerHeader(
        decoration: BoxDecoration(color: Colors.black),
        margin: EdgeInsets.zero,
        child: Row(
          children: [
            InkWell(
              onTap: () {
                global_key.currentState?.openEndDrawer();
              },
              child: Icon(Icons.arrow_back, color: AppColor.white, size: 22.0),
            ),
            SizedBox(width: 50.0),
            Text(
              'Chef Level',
              style: GoogleFonts.playfairDisplay(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.normal,
                color: AppColor.btnBackground,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
