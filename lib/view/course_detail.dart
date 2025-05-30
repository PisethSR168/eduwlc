import 'package:flutter/material.dart';
import '../constant.dart';

class CourseDetailPage extends StatefulWidget {
  const CourseDetailPage({super.key});

  @override
  State<CourseDetailPage> createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage> {
  String _selectedTab = 'Popular';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: kDarkGreyColor),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: Icon(
              Icons.notifications_outlined,
              color: kPrimaryColor,
              size: 28,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Today's Event Section
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: kLightGreyColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Today's event",
                        style: TextStyle(
                          color: kDarkGreyColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'view all >',
                        style: TextStyle(color: kGreyColor, fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Join now',
                    style: TextStyle(color: kGreyColor, fontSize: 14),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: 120,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [kPrimaryColor, kSecondaryColor],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          right: 16,
                          bottom: 8,
                          child: Text(
                            'Picture book, online score',
                            style: TextStyle(
                              color: kWhiteColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 16,
                          top: 16,
                          child: Icon(Icons.book, color: kWhiteColor, size: 32),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Tab Section
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  _buildTab('Popular', _selectedTab == 'Popular'),
                  _buildTab('Lecture', _selectedTab == 'Lecture'),
                  _buildTab('Taste', _selectedTab == 'Taste'),
                  _buildTab('Task', _selectedTab == 'Task'),
                  _buildTab('Radio', _selectedTab == 'Radio'),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Course List
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: 3,
              itemBuilder: (context, index) {
                return _buildCourseItem(index);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(String title, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTab = title;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 24),
        padding: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected ? kPrimaryColor : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? kPrimaryColor : kGreyColor,
            fontSize: 16,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildCourseItem(int index) {
    final courses = [
      {
        'title': 'How hard is it for humans to climb Mount Everest?',
        'type': 'Record',
        'likes': '122',
        'comments': '9',
        'icon': Icons.terrain,
        'color': kFreeColor,
      },
      {
        'title': 'What is used in life to use Newton\'s first law?',
        'type': 'Taste',
        'likes': '30',
        'comments': '1',
        'icon': Icons.science,
        'color': kAccentColor,
      },
      {
        'title': 'How to learn to get along well with others?',
        'type': 'Radio',
        'likes': '10',
        'comments': '2',
        'icon': Icons.people,
        'color': kBookstoreColor,
      },
    ];

    final course = courses[index];

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: (course['color'] as Color).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              course['icon'] as IconData,
              color: course['color'] as Color,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  course['title'] as String,
                  style: TextStyle(
                    color: kDarkGreyColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: kLightGreyColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        course['type'] as String,
                        style: TextStyle(color: kGreyColor, fontSize: 12),
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Icon(
                          Icons.favorite_border,
                          color: kGreyColor,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          course['likes'] as String,
                          style: TextStyle(color: kGreyColor, fontSize: 12),
                        ),
                        const SizedBox(width: 16),
                        Icon(
                          Icons.comment_outlined,
                          color: kGreyColor,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          course['comments'] as String,
                          style: TextStyle(color: kGreyColor, fontSize: 12),
                        ),
                      ],
                    ),
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
