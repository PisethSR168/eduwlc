import 'package:flutter/material.dart';
import 'package:eduwlc/constants/constant.dart';

class AboutAppPage extends StatelessWidget {
  const AboutAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Project Information',
          style: TextStyle(color: kWhiteColor, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: kWhiteColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProjectHeader(),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle("PROJECT OVERVIEW"),
                  _buildDescriptionCard(),

                  const SizedBox(height: 24),
                  _buildSectionTitle("LEAD DEVELOPER"),
                  _buildLeadDeveloperCard(),

                  const SizedBox(height: 24),
                  _buildSectionTitle("TEAM MEMBERS (G2 MS)"),

                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio: 0.85,
                    children: [
                      _buildMemberCard(
                        "Member 2",
                        "UI/UX Designer",
                        "assets/wlc_logo.png",
                      ),
                      _buildMemberCard(
                        "Member 3",
                        "System Analyst",
                        "assets/wlc_logo.png",
                      ),
                      _buildMemberCard(
                        "Member 4",
                        "Database Designer",
                        "assets/wlc_logo.png",
                      ),
                      _buildMemberCard(
                        "Member 5",
                        "Researcher",
                        "assets/wlc_logo.png",
                      ),
                      _buildMemberCard(
                        "Member 6",
                        "Documentation",
                        "assets/wlc_logo.png",
                      ),
                    ],
                  ),

                  const SizedBox(height: 40),
                  _buildFooter(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, left: 4),
      child: Text(
        title,
        style: const TextStyle(
          color: kGreyColor,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildDescriptionCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: kPrimaryColor.withOpacity(0.1)),
      ),
      child: const Text(
        "The School Information System is a comprehensive platform built as a final Thesis Project. It aims to digitize school operations, providing students with real-time access to academic scores, enrollment data, and school announcements through a modern mobile interface.",
        style: TextStyle(color: kDarkGreyColor, height: 1.5, fontSize: 13),
      ),
    );
  }

  Widget _buildProjectHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      decoration: const BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: Column(
        children: [
          Hero(
            tag: 'app_logo',
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: kWhiteColor,
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
              ),
              child: Image.asset('assets/wlc_logo.png', height: 70),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "G2 MS - Thesis Project",
            style: TextStyle(
              color: kWhiteColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            "WLC School Information System",
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildLeadDeveloperCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 35,
            backgroundColor: kPrimaryColor,
            backgroundImage: AssetImage('assets/nun.jpg'),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Suon Phanun",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: kDarkGreyColor,
                  ),
                ),
                const Text(
                  "Full-stack Developer",
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    _buildSkillTag("Flutter"),
                    const SizedBox(width: 5),
                    _buildSkillTag("Laravel"),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillTag(String skill) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        skill,
        style: TextStyle(
          color: Colors.blue.shade700,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildMemberCard(String name, String role, String img) {
    return Container(
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 8),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: kLightGreyColor,
            backgroundImage: AssetImage(img),
          ),
          const SizedBox(height: 10),
          Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: kDarkGreyColor,
            ),
          ),
          Text(role, style: const TextStyle(color: kGreyColor, fontSize: 10)),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Column(
      children: [
        const Divider(),
        const SizedBox(height: 10),
        const Text(
          "© 2026 G2 MS Team. All Rights Reserved.",
          style: TextStyle(color: kGreyColor, fontSize: 11),
        ),
        const Text(
          "Built with Flutter & Laravel API",
          style: TextStyle(
            color: kGreyColor,
            fontSize: 10,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }
}
