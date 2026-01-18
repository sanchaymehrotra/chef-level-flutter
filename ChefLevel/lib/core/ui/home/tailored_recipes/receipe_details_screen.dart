import 'package:flutter/material.dart';
import 'package:food_chef/core/domain/models/home/home_recipes_model.dart';
import 'package:food_chef/core/providers/home_provider.dart';
import 'package:food_chef/core/utils/function/utility.dart';
import 'package:provider/provider.dart';

import '../../../utils/constant/colors/app_color.dart';

class RecipeDetailsScreen extends StatefulWidget {
  final int clickedIndex;
  const RecipeDetailsScreen({super.key, required this.clickedIndex});

  @override
  State<RecipeDetailsScreen> createState() => _RecipeDetailsScreenState();
}

class _RecipeDetailsScreenState extends State<RecipeDetailsScreen>
    with SingleTickerProviderStateMixin {
  int quantity = 1;
  late TabController _tabController;
  TailoredRecipe? recipeDetails;
  late HomeScreenProvider homeProvider;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    homeProvider = Provider.of<HomeScreenProvider>(context, listen: false);
    setData();
  }

  Future<void> setData() async {
    recipeDetails = homeProvider.tailoredRecipesHomeData![widget.clickedIndex];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    recipeHeader(),
                    _imageSection(),
                    _contentSection(),
                  ],
                ),
              ),
            ),
            _ratingRow(),
            _bottomBar(),
          ],
        ),
      ),
    );
  }

  // IMAGE + PLAY BUTTON
  Widget _imageSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            child: recipeDetails!.thumbnailImageId != null
                ? FadeInImage(
                    placeholder: AssetImage(
                      'assets/images/cuisine_default.png',
                    ),
                    image: recipeDetails!.image != null
                        ? NetworkImage(
                            Utility.getImageUrl(
                              recipeDetails!.image!,
                              'recipe',
                              'assets/images/cuisine_default.png',
                            ),
                          )
                        : AssetImage('assets/images/cuisine_default.png'),
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    'assets/images/cuisine_default.png',
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
          ),
          Visibility(
            visible: recipeDetails!.imageId != null,
            child: Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  width: 42,
                  height: 42,
                  decoration:  BoxDecoration(
                    border: BoxBorder.all(width: 1,color: AppColor.white),
                    shape: BoxShape.circle,
                    color: Colors.black,
                  ),
                  child: const Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // MAIN CONTENT
  Widget _contentSection() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            recipeDetails!.shortDescription ?? '',
            style: TextStyle(color: Colors.white60, fontSize: 13),
          ),

          // const SizedBox(height: 6),
          // const Text(
          //   'Read More',
          //   style: TextStyle(color: Colors.orange, fontSize: 13),
          // ),
          const SizedBox(height: 16),
          _nutritionRow(),

          const SizedBox(height: 20),
          const Text(
            'Recipe Details',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          const SizedBox(height: 12),
          _detailsGrid(),

          const SizedBox(height: 20),
          _tabsSection(),
        ],
      ),
    );
  }

  // NUTRITION CARDS
  Widget _nutritionRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _infoCard('Calories', '${recipeDetails!.calories} kcal'),
        _infoCard('Protein', '${recipeDetails!.protein}g'),
        _infoCard('Carbs', '${recipeDetails!.carbs}gm'),
        _infoCard('Fats', '${recipeDetails!.fats}g'),
        _infoCard('Fiber', '${recipeDetails!.fiber}g'),
      ],
    );
  }

  Widget _infoCard(String title, String value) {
    return Container(
      width: 64,
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF1B1B1B),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.white54, fontSize: 11),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // DETAILS GRID
  Widget _detailsGrid() {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        _detailChip('Pre Time', '${recipeDetails!.prepTime} min'),
        _detailChip('Protein', '${recipeDetails!.protein}g'),
        _detailChip('Carbs', '${recipeDetails!.carbs}gm'),
        _detailChip('Difficulties', recipeDetails!.difficulty ?? ''),
        _detailChip('Skill Level', recipeDetails!.skillLevel ?? ''),
        _detailChip('Cuisine', recipeDetails!.cuisine ?? ''),
      ],
    );
  }

  Widget _detailChip(String title, String value) {
    return Container(
      width: (MediaQuery.of(context).size.width - 56) / 3,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF1B1B1B),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.white54, fontSize: 11),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // TABS
  Widget _tabsSection() {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          indicatorColor: AppColor.btnBackground,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white54,
          tabs: const [
            Tab(text: 'Ingredients'),
            Tab(text: 'Instruction'),
            Tab(text: 'Utensils'),
            Tab(text: 'Tips'),
          ],
        ),
        Container(
          height: 160,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF1B1B1B),
            borderRadius: BorderRadius.circular(12),
          ),
          child: TabBarView(
            controller: _tabController,
            children: [
              recipeDetails!.ingredientDetails!.isNotEmpty
                  ? _ingredientsList(recipeDetails!.ingredientDetails!)
                  : Center(
                      child: Text(
                        'No Ingredients',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ),
                    recipeDetails!.instructions!.isNotEmpty?
                    Text(
                  recipeDetails!.instructions!,
                  style: TextStyle(color: Colors.white70),
                ):
              Center(
                child: Text(
                  'No Instructions',
                  style: TextStyle(color: Colors.white70),
                ),
              ),
              recipeDetails!.utensils!.isNotEmpty
                  ? _utensilsList(recipeDetails!.utensils)
                  : Center(
                      child: Text(
                        'No Utensils',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ),
              Center(
                child: Text('No Tips', style: TextStyle(color: Colors.white70)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _ingredientsList(List<IngredientDetail> ingredientsList) {
    List<String?> ingredients = ingredientsList
        .map((ingredientsName) => ingredientsName.name)
        .toList();

    return ListView.builder(
      itemCount: ingredients.length,
      itemBuilder: (_, i) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            const Icon(Icons.circle, size: 6, color: AppColor.btnBackground),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                ingredients[i] ?? 'No Ingredients',
                style: const TextStyle(color: Colors.white70, fontSize: 13),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _utensilsList(List<String>? utensils) {
    return ListView.builder(
      itemCount: utensils!.length,
      itemBuilder: (_, i) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            const Icon(Icons.circle, size: 6, color: AppColor.btnBackground),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                utensils[i],
                style: const TextStyle(color: Colors.white70, fontSize: 13),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _ratingRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          gradient: const LinearGradient(
            colors: [Color(0xFF1F1F1F), Color(0xFF141414)],
          ),
        ),
        child: Row(
          children: [
            const Text(
              'Add Rating',
              style: TextStyle(
                color: AppColor.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            Row(
              children: List.generate(5, (index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Icon(
                    index < 3 ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                    size: 18,
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  // BOTTOM BAR
  Widget _bottomBar() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(color: Color(0xFF0F0F0F)),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white24),
              borderRadius: BorderRadius.circular(30),
              color: AppColor.white,
            ),
            child: Row(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: const BoxDecoration(
                    color: Colors.black87,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: IconButton(
                      icon: const Icon(
                        Icons.remove,
                        color: Colors.white,
                        size: 15,
                      ),
                      onPressed: () {
                        if (quantity > 1) setState(() => quantity--);
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  '$quantity',
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  width: 30,
                  height: 30,
                  decoration: const BoxDecoration(
                    color: Colors.black87,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: IconButton(
                      icon: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 15,
                      ),
                      onPressed: () {
                        setState(() => quantity++);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black87,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: BorderSide(color: Colors.white24, width: 1),
                ),
              ),
              onPressed: () {},
              child: const Text(
                'Add to Cart',
                style: TextStyle(color: AppColor.white),
              ),
            ),
          ),
          const SizedBox(width: 12),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onPressed: () {},
            child: const Text(
              'Wishlist',
              style: TextStyle(color: AppColor.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget recipeHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      child: Column(
        children: [
          // TOP BAR
          Row(
            children: [
              InkWell(
                onTap: () => {Navigator.pop(context)},
                borderRadius: BorderRadius.circular(24),
                child: const Icon(Icons.arrow_back, color: Colors.white),
              ),
              const Spacer(),
              Text(
                recipeDetails!.dishName ?? '',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              const SizedBox(width: 24), // balances back arrow
            ],
          ),
          const SizedBox(height: 14),

          // META ROW
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // LEFT INFO
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipeDetails!.chefName ?? '',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    recipeDetails!.cuisine ?? '',
                    style: TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

              const Spacer(),

              // RIGHT INFO
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.star, color: Colors.amber, size: 14),
                      SizedBox(width: 4),
                      Text(
                        '4.8 (120).',
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Text(
                    recipeDetails!.skillLevel ?? '',
                    style: TextStyle(color: Colors.white54, fontSize: 11),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
