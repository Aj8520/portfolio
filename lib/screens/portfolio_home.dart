import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_colors.dart';
import '../utils/constants.dart';
import '../widgets/components.dart';
import '../widgets/linkedin_embed.dart';

class PortfolioHome extends StatefulWidget {
  const PortfolioHome({Key? key}) : super(key: key);

  @override
  State<PortfolioHome> createState() => _PortfolioHomeState();
}

class _PortfolioHomeState extends State<PortfolioHome> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  void _scrollTo(GlobalKey key) {
    if (key.currentContext != null) {
      Scrollable.ensureVisible(
        key.currentContext!,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 800;

    return Scaffold(
      body: Stack(
        children: [
          // Background glows
          Positioned(
            top: -200,
            left: -200,
            child: Container(
              width: 500,
              height: 500,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withOpacity(0.05),
                boxShadow: [
                  BoxShadow(color: AppColors.primary.withOpacity(0.1), blurRadius: 200, spreadRadius: 100),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: -300,
            right: -200,
            child: Container(
              width: 600,
              height: 600,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.accent.withOpacity(0.05),
                boxShadow: [
                  BoxShadow(color: AppColors.accent.withOpacity(0.1), blurRadius: 200, spreadRadius: 100),
                ],
              ),
            ),
          ),
          
          Scrollbar(
            controller: _scrollController,
            thumbVisibility: true,
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  _NavBar(
                    isDesktop: isDesktop,
                    onNavigate: (section) {
                      switch (section) {
                        case 'Home': _scrollTo(_homeKey); break;
                        case 'About': _scrollTo(_aboutKey); break;
                        case 'Arsenal': _scrollTo(_skillsKey); break;
                        case 'Experience': _scrollTo(_experienceKey); break;
                        case 'Projects': _scrollTo(_projectsKey); break;
                        case 'Contact': _scrollTo(_contactKey); break;
                      }
                    },
                  ),
                  Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1000),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: isDesktop ? 64.0 : 24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 100),
                            _HeroSection(key: _homeKey),
                            const SizedBox(height: 150),
                            _AboutSection(key: _aboutKey),
                            const SizedBox(height: 150),
                            _SkillsSection(key: _skillsKey),
                            const SizedBox(height: 150),
                            _ExperienceSection(key: _experienceKey),
                            const SizedBox(height: 150),
                            _ProjectsSection(key: _projectsKey),
                            const SizedBox(height: 150),
                            const _EducationSection(),
                            const SizedBox(height: 150),
                            const _CertificationsAwardsSection(),
                            const SizedBox(height: 150),
                            const _CareerGuidanceSection(),
                            const SizedBox(height: 150),
                            _ContactSection(key: _contactKey),
                            const SizedBox(height: 100),
                            _Footer(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavBar extends StatelessWidget {
  final bool isDesktop;
  final Function(String) onNavigate;

  const _NavBar({required this.isDesktop, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    const items = ['Home', 'About', 'Arsenal', 'Experience', 'Projects', 'Contact'];
    return Container(
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 64.0 : 24.0, vertical: 24),
      color: AppColors.background.withOpacity(0.9),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "<AJ />",
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ).animate().fadeIn().slideX(),
          if (isDesktop)
            Row(
              children: items.map((item) {
                return Padding(
                  padding: const EdgeInsets.only(left: 32),
                  child: InkWell(
                    onTap: () => onNavigate(item),
                    child: Text(
                      item,
                      style: const TextStyle(
                        color: AppColors.textMain,
                        fontWeight: FontWeight.w500,
                      ),
                    ).animate(onPlay: (controller) => controller.repeat(reverse: true)).shimmer(delay: 2000.ms, duration: 2000.ms, color: AppColors.primary.withOpacity(0.2)),
                  ),
                );
              }).toList(),
            ).animate().fadeIn(delay: 300.ms),
          if (!isDesktop)
            IconButton(
              icon: const Icon(Icons.menu, color: AppColors.primary),
              onPressed: () {
                // Bottom sheet or drawer for mobile menu
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Menu Coming Soon')));
              },
            )
        ],
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  const _HeroSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Hi, my name is",
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 18,
            fontWeight: FontWeight.w500,
            letterSpacing: 1.5,
          ),
        ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.3),
        const SizedBox(height: 16),
        Text(
          AppConstants.name,
          style: Theme.of(context).textTheme.displayLarge,
        ).animate().fadeIn(delay: 200.ms, duration: 600.ms).slideY(begin: 0.2),
        const SizedBox(height: 8),
        Text(
          "I build things for mobile & web.",
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
                color: AppColors.textSecondary,
              ),
        ).animate().fadeIn(delay: 400.ms, duration: 600.ms).slideY(begin: 0.2),
        const SizedBox(height: 32),
        SizedBox(
          width: 600,
          child: Text(
            AppConstants.heroDescription,
            style: Theme.of(context).textTheme.bodyLarge,
          ).animate().fadeIn(delay: 600.ms, duration: 600.ms).slideY(begin: 0.1),
        ),
        const SizedBox(height: 48),
        Row(
          children: [
            PrimaryButton(
              text: "Check out my work!",
              icon: Icons.rocket_launch,
              onPressed: () {},
            ),
            const SizedBox(width: 24),
            OutlinedButton(
              onPressed: () async {
                 final url = Uri.parse(AppConstants.linkedinUrl);
                 await launchUrl(url);
              },
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                side: const BorderSide(color: AppColors.primary),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text("LinkedIn", style: TextStyle(color: AppColors.primary, fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ],
        ).animate().fadeIn(delay: 800.ms, duration: 600.ms).slideY(begin: 0.1),
      ],
    );
  }
}

class _AboutSection extends StatelessWidget {
  const _AboutSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeading(title: "About Me", subtitle: "Who am I?").animate().fadeIn(duration: 600.ms).slideX(begin: -0.1),
        const SizedBox(height: 24),
        Text(
          AppConstants.aboutMe,
          style: Theme.of(context).textTheme.bodyLarge,
        ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.1),
        const SizedBox(height: 32),
        Row(
          children: [
            const Icon(Icons.location_on, color: AppColors.primary, size: 20),
            const SizedBox(width: 8),
            Text(AppConstants.location, style: const TextStyle(color: AppColors.textMain, fontWeight: FontWeight.w500)),
          ],
        ).animate().fadeIn(delay: 500.ms),
      ],
    );
  }
}

class _SkillsSection extends StatelessWidget {
  const _SkillsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeading(title: "Tech Arsenal", subtitle: "Technologies I work with.")
            .animate().fadeIn(duration: 600.ms).slideX(begin: -0.1),
        Wrap(
          spacing: 24,
          runSpacing: 24,
          children: AppConstants.skills.map((category) {
            return Container(
              width: 400,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.backgroundLight,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category['category'] as String,
                    style: const TextStyle(color: AppColors.textMain, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: (category['items'] as List<String>).map((skill) {
                      return TechPill(text: skill);
                    }).toList(),
                  )
                ],
              ),
            ).animate().fadeIn(delay: 200.ms).scale(begin: const Offset(0.95, 0.95));
          }).toList(),
        )
      ],
    );
  }
}

class _ExperienceSection extends StatelessWidget {
  const _ExperienceSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeading(title: "Where I've Worked", subtitle: "My professional journey.")
            .animate().fadeIn(duration: 600.ms).slideX(begin: -0.1),
        Column(
          children: AppConstants.experience.map((exp) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 48),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Timeline line
                  Column(
                    children: [
                      Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(color: AppColors.primary, shape: BoxShape.circle, border: Border.all(color: AppColors.background, width: 4)),
                      ),
                      Container(width: 2, height: 150, color: AppColors.border),
                    ],
                  ),
                  const SizedBox(width: 32),
                  // Content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          exp['role']!,
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: AppColors.textMain),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "${exp['company']} | ${exp['location']} | ${exp['duration']}",
                          style: const TextStyle(color: AppColors.primaryVariant, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 16),
                        ...((exp['projects'] as List).map((project) {
                           return Padding(
                             padding: const EdgeInsets.only(bottom: 16),
                             child: Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Text(project['name'], style: const TextStyle(color: AppColors.textMain, fontWeight: FontWeight.bold)),
                                 const SizedBox(height: 8),
                                 ...((project['points'] as List).map((point) {
                                   return Padding(
                                     padding: const EdgeInsets.only(bottom: 8),
                                     child: Row(
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                         const Text("▹ ", style: TextStyle(color: AppColors.primary)),
                                         Expanded(child: Text(point, style: Theme.of(context).textTheme.bodyMedium)),
                                       ],
                                     ),
                                   );
                                 }).toList())
                               ],
                             ),
                           );
                        }).toList())
                      ],
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1);
          }).toList(),
        )
      ],
    );
  }
}

class _ProjectsSection extends StatelessWidget {
  const _ProjectsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeading(title: "Featured Projects", subtitle: "Some things I've built.")
            .animate().fadeIn(duration: 600.ms).slideX(begin: -0.1),
        // Just a showcase of main app projects
        Wrap(
          spacing: 24,
          runSpacing: 24,
          children: [
            _buildProjectCard("Kicksnap", "Global AI-driven E-commerce application localized for 8 languages across USA, Japan, and China.", ["Flutter", "Line SDK", "WeChat SDK", "AR/AI", "AppsFlyer"]),
            _buildProjectCard("Jewello", "B2C Jewellery Saving Scheme Platform supporting a customizable Flavor architecture for 30+ brands.", ["Spring Boot", "Flutter", "Clean Architecture", "Fastlane", "Payment Gateways"]),
            _buildProjectCard("Cascada", "IoT Smart Waterer for Equine Health utilizing deep native app links and reliable tracking.", ["Flutter", "Native App Links", "IoT"]),
            _buildProjectCard("Acme Padm POS", "Engineered POS system integrated with POS hardware and swipe machines for seamless backend settlement.", ["Flutter", "Hardware Integration", "Java", "Worldline"]),
          ].map((w) => w.animate().fadeIn(delay: 200.ms).scale(begin: const Offset(0.95, 0.95))).toList(),
        )
      ],
    );
  }
  
  Widget _buildProjectCard(String title, String desc, List<String> tech) {
    return Container(
      width: 400,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
           BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 10, offset: const Offset(0, 10)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const FaIcon(FontAwesomeIcons.folderOpen, color: AppColors.primary, size: 40),
              Row(
                children: const [
                  FaIcon(FontAwesomeIcons.github, color: AppColors.textSecondary, size: 20),
                  SizedBox(width: 16),
                  FaIcon(FontAwesomeIcons.arrowUpRightFromSquare, color: AppColors.textSecondary, size: 18),
                ],
              )
            ],
          ),
          const SizedBox(height: 32),
          Text(title, style: const TextStyle(color: AppColors.textMain, fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Text(desc, style: const TextStyle(color: AppColors.textSecondary, height: 1.5)),
          const SizedBox(height: 32),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: tech.map((t) => Text(t, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13, fontFamily: "monospace"))).toList(),
          )
        ],
      ),
    );
  }
}

class _EducationSection extends StatelessWidget {
  const _EducationSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeading(title: "Education", subtitle: "My academic background.")
            .animate().fadeIn(duration: 600.ms).slideX(begin: -0.1),
        Wrap(
          spacing: 24,
          runSpacing: 24,
          children: AppConstants.education.map((edu) {
            return Container(
              width: 400,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.backgroundLight,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const FaIcon(FontAwesomeIcons.graduationCap, color: AppColors.primary, size: 32),
                  const SizedBox(height: 24),
                  Text(
                    edu['degree']!,
                    style: const TextStyle(color: AppColors.textMain, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    edu['institution']!,
                    style: const TextStyle(color: AppColors.textSecondary, fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    edu['duration']!,
                    style: const TextStyle(color: AppColors.primaryVariant, fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ).animate().fadeIn(delay: 200.ms).scale(begin: const Offset(0.95, 0.95));
          }).toList(),
        ),
      ],
    );
  }
}

class _CertificationsAwardsSection extends StatelessWidget {
  const _CertificationsAwardsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeading(title: "Certifications & Awards", subtitle: "Recognitions and specialized achievements.")
            .animate().fadeIn(duration: 600.ms).slideX(begin: -0.1),
        Wrap(
          spacing: 24,
          runSpacing: 24,
          children: AppConstants.certifications.map((cert) {
            final isAward = cert['title']!.toLowerCase().contains("award");
            return Container(
              width: 400,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.backgroundLight,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  FaIcon(
                    isAward ? FontAwesomeIcons.trophy : FontAwesomeIcons.certificate,
                    color: isAward ? Colors.amber : AppColors.primary,
                    size: 32,
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cert['title']!,
                          style: const TextStyle(color: AppColors.textMain, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          cert['year']!,
                          style: const TextStyle(color: AppColors.primaryVariant, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1);
          }).toList(),
        ),
      ],
    );
  }
}

class _CareerGuidanceSection extends StatelessWidget {
  const _CareerGuidanceSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeading(
          title: "Career Guidance & Talks",
          subtitle: "Guest lectures, mentoring, and my latest professional updates.",
        ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.1),
        
        // Wrap for responsive flow between mobile/desktop instead of heavy iframe horizontal scrolling
        Wrap(
          spacing: 24,
          runSpacing: 24,
          children: AppConstants.careerPosts.asMap().entries.map((entry) {
            final index = entry.key;
            final post = entry.value;
            return _CareerPostCard(post: post)
                  .animate()
                  .fadeIn(delay: Duration(milliseconds: 200 + (index * 100)))
                  .scale(begin: const Offset(0.95, 0.95));
          }).toList(),
        ),
      ],
    );
  }
}

class _CareerPostCard extends StatelessWidget {
  final Map<String, dynamic> post;
  
  const _CareerPostCard({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            final width = MediaQuery.of(context).size.width;
            final isDesktop = width > 800;
            return Dialog(
              backgroundColor: Colors.transparent,
              child: Container(
                width: isDesktop ? 600 : width * 0.9,
                height: isDesktop ? 800 : width * 1.5,
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              post['title'], 
                              style: const TextStyle(color: AppColors.textMain, fontWeight: FontWeight.bold, fontSize: 16),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close, color: AppColors.textSecondary), 
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: LinkedInEmbedWidget(
                        activityId: post['id'],
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: OutlinedButton.icon(
                        icon: const FaIcon(FontAwesomeIcons.linkedin, size: 16),
                        label: const Text("View Original Post"),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.primary, 
                          side: const BorderSide(color: AppColors.primary),
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        ),
                        onPressed: () => launchUrl(Uri.parse(post['link'])),
                      ),
                    )
                  ],
                ),
              ),
            );
          }
        );
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 350,
        height: 320,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.backgroundLight,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
          boxShadow: [
             BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 5)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const FaIcon(FontAwesomeIcons.video, color: AppColors.primaryVariant, size: 32),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const FaIcon(FontAwesomeIcons.play, color: AppColors.primary, size: 12),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              post['title'], 
              style: const TextStyle(color: AppColors.textMain, fontSize: 18, fontWeight: FontWeight.bold), 
              maxLines: 2, 
              overflow: TextOverflow.ellipsis
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Text(
                post['description'], 
                style: const TextStyle(color: AppColors.textSecondary, fontSize: 14, height: 1.5), 
                maxLines: 3, 
                overflow: TextOverflow.ellipsis
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: (post['tags'] as List).map((tag) => Text(tag, style: const TextStyle(color: AppColors.primary, fontSize: 12, fontWeight: FontWeight.w600))).toList(),
            )
          ],
        ),
      ),
    );
  }
}

class _ContactSection extends StatelessWidget {
  const _ContactSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 64),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("04. What's Next?", style: TextStyle(color: AppColors.primary)),
          const SizedBox(height: 16),
          Text("Get In Touch", style: Theme.of(context).textTheme.displayMedium),
          const SizedBox(height: 24),
          SizedBox(
            width: 600,
            child: Text(
              "I am continually open to exploring new engineering opportunities and challenging architectures. Whether you have a question, a project requirement, or just want to say hi, I will try my best to get back to you!",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          const SizedBox(height: 48),
          PrimaryButton(
            text: "Say Hello",
            onPressed: () => launchUrl(Uri.parse("mailto:${AppConstants.email}")),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.1);
  }
}

class _Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SocialButton(icon: FontAwesomeIcons.linkedin, url: AppConstants.linkedinUrl),
            const SizedBox(width: 24),
            SocialButton(icon: FontAwesomeIcons.github, url: "https://github.com/"), // replace with actual
            const SizedBox(width: 24),
            SocialButton(icon: FontAwesomeIcons.envelope, url: "mailto:${AppConstants.email}"),
          ],
        ),
        const SizedBox(height: 32),
        const Text("Built with ❤️ using Flutter Web", style: TextStyle(color: AppColors.textSecondary, fontSize: 13, fontFamily: "monospace")),
        const SizedBox(height: 8),
        const Text("© 2026 Ajay Jadhav", style: TextStyle(color: AppColors.textSecondary, fontSize: 13, fontFamily: "monospace")),
        const SizedBox(height: 32),
      ],
    );
  }
}
