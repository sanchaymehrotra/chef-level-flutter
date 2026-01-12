import 'package:flutter/material.dart';

import '../../../utils/constant/colors/app_color.dart';

class ChefProfileScreen extends StatelessWidget {
  const ChefProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// 🔹 HEADER
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Icon(Icons.arrow_back, color: Colors.white),
                    const SizedBox(width: 10),
                    const CircleAvatar(
                      radius: 14,
                      backgroundImage: AssetImage('assets/images/safe_marco.png'),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      "Chef Alex",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Icon(Icons.verified, color: Colors.green, size: 18),
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: const [
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 14),
                            SizedBox(width: 4),
                            Text("4.0 (209)",
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                        Text(
                          "Top-Rated",
                          style: TextStyle(
                              color: Colors.orange,
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    )
                  ],
                ),
              ),

              /// 🔹 VIDEO THUMBNAIL
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        'assets/images/safe_marco.pngq',
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        height: 56,
                        width: 56,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          size: 32,
                        ),
                      )
                    ],
                  ),
                ),
              ),

              /// 🔹 DESCRIPTION
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  "Italian Cuisine\n10 years of experience\n\n"
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
                      "Nunc sit amet finibus leo, id mattis urna. "
                      "Phasellus vitae mauris vel risus tincidunt rutrum in non dolor.\n\n"
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
                      "Nunc sit amet finibus leo, id mattis urna. "
                      "Phasellus vitae mauris vel risus tincidunt rutrum in non dolor.",
                  style: TextStyle(color: Colors.white70, height: 1.5),
                ),
              ),

              /// 🔹 CERTIFICATIONS
              sectionTitle("Certifications / Awards"),
              SizedBox(
                height: 120,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  itemCount: 2,
                  itemBuilder: (_, index) {
                    return Container(
                      margin: const EdgeInsets.only(right: 12),
                      width: 160,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1C1C1C),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Image.asset(
                          'assets/images/phone.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    );
                  },
                ),
              ),

              /// 🔹 SPECIALITIES
              sectionTitle("Specialties / Signature Dishes by Chef Marco"),
              SizedBox(
                height: 160,
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  children: [
                    masterClassCard(
                        image: 'assets/images/sea_food_salad.jpg',
                        title: "Master Class: Knife Skills",
                        duration: "35 Min"),
                    masterClassCard(
                        image: 'assets/images/sea_food_salad.jpg',
                        title: "Master Class: BBQ",
                        duration: "45 Min"),
                  ],
                ),
              ),

              /// 🔹 EXPLORE SIMILAR
              sectionTitle("Explore Similar Chef"),
              SizedBox(
                height: 180,
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  children: [
                    chefCard('assets/images/safe_marco.png', "Chef Marco"),
                    chefCard('assets/images/safe_marco.png', "Chef Jmarco"),
                  ],
                ),
              ),

              /// 🔹 RATING
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Row(
                  children: [
                    Text("Add Rating",
                        style: TextStyle(color: Colors.white)),
                    Spacer(),
                    Icon(Icons.star, color: Colors.amber),
                    Icon(Icons.star, color: Colors.amber),
                    Icon(Icons.star, color: Colors.amber),
                    Icon(Icons.star_border, color: Colors.grey),
                    Icon(Icons.star_border, color: Colors.grey),
                  ],
                ),
              ),

              /// 🔹 BUTTONS
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed: () {},
                        child: const Text("Follow", style: TextStyle(color: AppColor.white),),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.white54),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed: () {},
                        child: const Text(
                          "Contact",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 🔹 COMMON WIDGETS
  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
      child: Text(
        title,
        style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget masterClassCard(
      {required String image,
        required String title,
        required String duration}) {
    return Container(
      width: 220,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1C),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius:
            const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.asset(
              image,
              height: 100,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(title,
                style: const TextStyle(color: Colors.white)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 14),
                const SizedBox(width: 4),
                const Text("4.0 (209)",
                    style: TextStyle(color: Colors.white70)),
                const Spacer(),
                Text(duration,
                    style: const TextStyle(color: Colors.white54)),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget chefCard(String image, String name) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1C),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius:
            const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.asset(
              image,
              height: 100,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          Text(name, style: const TextStyle(color: Colors.white)),
          const SizedBox(height: 4),
          const Text("Top-Rated",
              style: TextStyle(color: Colors.orange, fontSize: 12)),
        ],
      ),
    );
  }
}
