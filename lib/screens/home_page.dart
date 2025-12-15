import 'package:flutter/material.dart';
import 'package:eduwlc/constant.dart';
import 'score_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Home Page',
              style: TextStyle(
                color: kDarkGreyColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Choose your course right away',
              style: TextStyle(
                color: kGreyColor,
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: Icon(
              Icons.notifications_outlined,
              color: const Color.fromARGB(255, 75, 51, 212),
              size: 28,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: kLightGreyColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.search, color: kGreyColor),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Search for your grade, course, training type...',
                      style: TextStyle(color: kGreyColor, fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Category Grid
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _buildCategoryCard(
                  icon: Icons.category,
                  title: 'Category',
                  color: kCategoryColor,
                ),
                _buildCategoryCard(
                  icon: Icons.school,
                  title: 'Boutique class',
                  color: kBoutiqueColor,
                ),
                _buildCategoryCard(
                  icon: Icons.menu_book,
                  title: 'Free course',
                  color: kFreeColor,
                ),
                _buildCategoryCard(
                  icon: Icons.store,
                  title: 'Bookstore',
                  color: kBookstoreColor,
                ),
                _buildCategoryCard(
                  icon: Icons.live_tv,
                  title: 'Live course',
                  color: kLiveColor,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ScorePage(),
                      ),
                    );
                  },
                  child: _buildCategoryCard(
                    icon: Icons.score,
                    title: 'Score',
                    color: kLeaderboardColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Recommended Course Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Recommended course',
                      style: TextStyle(
                        color: kDarkGreyColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'you may also like 😊',
                      style: TextStyle(color: kGreyColor, fontSize: 14),
                    ),
                  ],
                ),
                Text(
                  'More',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 75, 51, 212),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Course Cards
            SizedBox(
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildCourseCard(
                    title: 'Morning textbook',
                    rating: '8.6',
                    color: kPrimaryColor,
                    image: 'assets/course1.png',
                  ),
                  _buildCourseCard(
                    title: 'English reading',
                    rating: '8.0',
                    color: kBoutiqueColor,
                    image: 'assets/course2.png',
                  ),
                  _buildCourseCard(
                    title: 'Illustration',
                    rating: '7.5',
                    color: kAccentColor,
                    image: 'assets/course3.png',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard({
    required IconData icon,
    required String title,
    required Color color,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: kWhiteColor, size: 24),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: kDarkGreyColor,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCourseCard({
    required String title,
    required String rating,
    required Color color,
    required String image,
  }) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Center(child: Icon(Icons.book, color: color, size: 40)),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: kDarkGreyColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      rating,
                      style: TextStyle(
                        color: kDarkGreyColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 4),
                    ...List.generate(5, (index) {
                      return Icon(
                        index < 4 ? Icons.star : Icons.star_border,
                        color: kAccentColor,
                        size: 12,
                      );
                    }),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
