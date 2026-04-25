import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:video_player/video_player.dart';
import '../theme/app_colors.dart';
import '../utils/constants.dart';
import '../widgets/components.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// MAIN SCREEN
// ═══════════════════════════════════════════════════════════════════════════════

class PortfolioHome extends StatefulWidget {
  const PortfolioHome({super.key});

  @override
  State<PortfolioHome> createState() => _PortfolioHomeState();
}

class _PortfolioHomeState extends State<PortfolioHome> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _scrollController = ScrollController();

  final _heroKey = GlobalKey();
  final _aboutKey = GlobalKey();
  final _skillsKey = GlobalKey();
  final _experienceKey = GlobalKey();
  final _achievementsKey = GlobalKey();
  final _certificationsKey = GlobalKey();
  final _educationKey = GlobalKey();
  final _guestLectureKey = GlobalKey();
  final _contactKey = GlobalKey();

  void _scrollTo(GlobalKey key) {
    if (key.currentContext != null) {
      Scrollable.ensureVisible(
        key.currentContext!,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void _navigateTo(String section) {
    final map = {
      'Home': _heroKey,
      'Experience': _experienceKey,
      'Projects': _achievementsKey,
      'Skills': _skillsKey,
      'Speaking': _guestLectureKey,
      'Certifications': _certificationsKey,
      'Contact': _contactKey,
    };
    final key = map[section];
    if (key != null) _scrollTo(key);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isDesktop = w > 1024;
    final isMobile = w < 600;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.background,
      drawer: !isDesktop
          ? _MobileDrawer(
              onNavigate: (s) {
                Navigator.pop(context);
                _navigateTo(s);
              },
            )
          : null,
      body: Stack(
        children: [
          // Background
          Positioned.fill(child: Container(color: AppColors.background)),
          Positioned.fill(child: CustomPaint(painter: _DotPainter())),
          const _GlowOrb(color: AppColors.primary, size: 700, top: -250, left: -250),
          const _GlowOrb(color: AppColors.accent, size: 600, top: 300, right: -200),
          const _GlowOrb(color: AppColors.primary, size: 400, top: 1800, left: -150),

          // Scrollable content
          Scrollbar(
            controller: _scrollController,
            thumbVisibility: true,
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1100),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isDesktop ? 64 : isMobile ? 20 : 40,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 88), // space for sticky navbar
                        _HeroSection(
                          key: _heroKey,
                          isDesktop: isDesktop,
                          onViewWork: () => _scrollTo(_experienceKey),
                        ),
                        _sectionGap(),
                        _AboutSection(key: _aboutKey, isDesktop: isDesktop),
                        _sectionGap(),
                        _SkillsSection(key: _skillsKey),
                        _sectionGap(),
                        _ExperienceSection(key: _experienceKey),
                        _sectionGap(),
                        _AchievementsSection(key: _achievementsKey, isMobile: isMobile),
                        _sectionGap(),
                        _CertificationsSection(key: _certificationsKey, isMobile: isMobile),
                        _sectionGap(),
                        _EducationSection(key: _educationKey, isDesktop: isDesktop),
                        _sectionGap(),
                        _GuestLectureSection(
                          key: _guestLectureKey,
                          isDesktop: isDesktop,
                          isMobile: isMobile,
                        ),
                        _sectionGap(),
                        _ContactSection(key: _contactKey, isDesktop: isDesktop),
                        const SizedBox(height: 80),
                        _Footer(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Sticky navbar overlay
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Builder(
              builder: (ctx) => ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                  child: _NavBar(
                    isDesktop: isDesktop,
                    onNavigate: _navigateTo,
                    onMenuTap: () => Scaffold.of(ctx).openDrawer(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  SizedBox _sectionGap() => const SizedBox(height: 140);
}

// ═══════════════════════════════════════════════════════════════════════════════
// BACKGROUND
// ═══════════════════════════════════════════════════════════════════════════════

class _DotPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.025)
      ..strokeCap = StrokeCap.round;
    const spacing = 28.0;
    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), 1.2, paint);
      }
    }
  }

  @override
  bool shouldRepaint(_) => false;
}

class _GlowOrb extends StatelessWidget {
  final Color color;
  final double size;
  final double? top;
  final double? left;
  final double? right;

  const _GlowOrb({
    required this.color,
    required this.size,
    this.top,
    this.left,
    this.right,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      child: IgnorePointer(
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.07),
                blurRadius: size * 0.8,
                spreadRadius: size * 0.2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// NAVBAR
// ═══════════════════════════════════════════════════════════════════════════════

class _NavBar extends StatelessWidget {
  final bool isDesktop;
  final void Function(String) onNavigate;
  final VoidCallback onMenuTap;

  const _NavBar({
    required this.isDesktop,
    required this.onNavigate,
    required this.onMenuTap,
  });

  @override
  Widget build(BuildContext context) {
    const items = ['Home', 'Experience', 'Projects', 'Skills', 'Speaking', 'Certifications', 'Contact'];

    return Container(
      height: 72,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 64 : 24,
      ),
      decoration: BoxDecoration(
        color: AppColors.background.withValues(alpha: 0.7),
        border: const Border(
          bottom: BorderSide(color: AppColors.border, width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo
          GestureDetector(
            onTap: () => onNavigate('Home'),
            child: ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [AppColors.primary, AppColors.accent],
              ).createShader(bounds),
              child: Text(
                '<AJ />',
                style: GoogleFonts.spaceGrotesk(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1,
                ),
              ),
            ),
          ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.2),

          if (isDesktop)
            Row(
              children: [
                ...items.map(
                  (item) => _NavLink(label: item, onTap: () => onNavigate(item)),
                ),
                const SizedBox(width: 24),
                OutlineBtn(
                  text: 'Resume',
                  onPressed: () => launchUrl(Uri.parse(AppConstants.resumeUrl.isEmpty
                      ? 'mailto:${AppConstants.email}'
                      : AppConstants.resumeUrl)),
                ),
              ],
            ).animate().fadeIn(delay: 200.ms, duration: 600.ms)
          else
            IconButton(
              icon: const Icon(Icons.menu_rounded, color: AppColors.textMain),
              onPressed: onMenuTap,
            ),
        ],
      ),
    );
  }
}

class _NavLink extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const _NavLink({required this.label, required this.onTap});

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _line;
  bool _hovered = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(duration: const Duration(milliseconds: 200), vsync: this);
    _line = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() => _hovered = true);
        _ctrl.forward();
      },
      onExit: (_) {
        setState(() => _hovered = false);
        _ctrl.reverse();
      },
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.label,
                style: GoogleFonts.spaceGrotesk(
                  color: _hovered ? AppColors.textMain : AppColors.textSecondary,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 3),
              AnimatedBuilder(
                animation: _line,
                builder: (_, __) => FractionallySizedBox(
                  widthFactor: _line.value,
                  alignment: Alignment.centerLeft,
                  child: Container(
                    height: 2,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [AppColors.primary, AppColors.accent],
                      ),
                      borderRadius: BorderRadius.circular(1),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MobileDrawer extends StatelessWidget {
  final void Function(String) onNavigate;

  const _MobileDrawer({required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    const items = ['Home', 'Experience', 'Projects', 'Skills', 'Speaking', 'Certifications', 'Contact'];
    return Drawer(
      backgroundColor: AppColors.backgroundCard,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShaderMask(
                shaderCallback: (b) => const LinearGradient(
                  colors: [AppColors.primary, AppColors.accent],
                ).createShader(b),
                child: Text(
                  '<AJ />',
                  style: GoogleFonts.spaceGrotesk(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              ...items.map(
                (item) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    item,
                    style: GoogleFonts.spaceGrotesk(
                      color: AppColors.textMain,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onTap: () => onNavigate(item),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// HERO
// ═══════════════════════════════════════════════════════════════════════════════

class _HeroSection extends StatelessWidget {
  final bool isDesktop;
  final VoidCallback onViewWork;

  const _HeroSection({super.key, required this.isDesktop, required this.onViewWork});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: isDesktop ? 700 : null,
      child: isDesktop
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(flex: 6, child: _HeroContent(onViewWork: onViewWork)),
                const SizedBox(width: 60),
                Expanded(flex: 4, child: _CodeSnippet()),
              ],
            )
          : _HeroContent(onViewWork: onViewWork),
    );
  }
}

class _HeroContent extends StatelessWidget {
  final VoidCallback onViewWork;
  const _HeroContent({required this.onViewWork});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Greeting
        Text(
          "Hi, I'm",
          style: GoogleFonts.dmMono(
            color: AppColors.accent,
            fontSize: 16,
            letterSpacing: 2,
          ),
        ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.3),
        const SizedBox(height: 12),

        // Name + blinking cursor
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                AppConstants.name,
                style: Theme.of(context).textTheme.displayLarge,
              ).animate().fadeIn(delay: 200.ms, duration: 600.ms),
              const SizedBox(width: 4),
              const _BlinkingCursor(),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Animated role ticker
        Row(
          children: [
            AnimatedTextKit(
              animatedTexts: AppConstants.heroRoles
                  .map(
                    (role) => TypewriterAnimatedText(
                      role,
                      textStyle: GoogleFonts.spaceGrotesk(
                        color: AppColors.primary,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                      speed: const Duration(milliseconds: 65),
                    ),
                  )
                  .toList(),
              repeatForever: true,
              pause: const Duration(milliseconds: 1200),
              displayFullTextOnTap: true,
            ),
          ],
        ).animate().fadeIn(delay: 400.ms, duration: 600.ms),
        const SizedBox(height: 24),

        // Subtext
        Text(
          AppConstants.heroSubtext,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 18),
        ).animate().fadeIn(delay: 600.ms, duration: 600.ms),
        const SizedBox(height: 40),

        // CTA buttons
        Wrap(
          spacing: 16,
          runSpacing: 12,
          children: [
            PrimaryButton(
              text: '→ View My Work',
              onPressed: onViewWork,
            ),
            OutlineBtn(
              text: '↓ Download Resume',
              icon: Icons.download_rounded,
              onPressed: () => launchUrl(Uri.parse(AppConstants.resumeUrl.isEmpty
                  ? 'mailto:${AppConstants.email}'
                  : AppConstants.resumeUrl)),
            ),
          ],
        ).animate().fadeIn(delay: 800.ms, duration: 600.ms),
        const SizedBox(height: 40),

        // Social icons
        Row(
          children: [
            const SocialButton(icon: FontAwesomeIcons.linkedin, url: AppConstants.linkedinUrl, color: Color(0xFF0A66C2)),
            const SizedBox(width: 12),
            const SocialButton(icon: FontAwesomeIcons.github, url: AppConstants.githubUrl, color: AppColors.textMain),
            const SizedBox(width: 12),
            const SocialButton(icon: FontAwesomeIcons.envelope, url: 'mailto:${AppConstants.email}', color: AppColors.accent),
            const SizedBox(width: 12),
            SocialButton(icon: FontAwesomeIcons.phone, url: 'tel:${AppConstants.phone.replaceAll(' ', '')}', color: AppColors.primary),
          ],
        ).animate().fadeIn(delay: 1000.ms, duration: 600.ms),
      ],
    );
  }
}

class _BlinkingCursor extends StatefulWidget {
  const _BlinkingCursor();

  @override
  State<_BlinkingCursor> createState() => _BlinkingCursorState();
}

class _BlinkingCursorState extends State<_BlinkingCursor>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 550),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, __) => Opacity(
        opacity: _ctrl.value > 0.5 ? 1.0 : 0.0,
        child: Text(
          '|',
          style: GoogleFonts.spaceGrotesk(
            color: AppColors.primary,
            fontSize: 72,
            fontWeight: FontWeight.w700,
            height: 1.1,
          ),
        ),
      ),
    );
  }
}

class _CodeSnippet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF0E1117),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.12),
            blurRadius: 40,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Window controls
          Row(
            children: [
              _dot(const Color(0xFFFF5F57)),
              const SizedBox(width: 8),
              _dot(const Color(0xFFFFBD2E)),
              const SizedBox(width: 8),
              _dot(const Color(0xFF28C840)),
              const SizedBox(width: 16),
              Text(
                'AjayController.java',
                style: GoogleFonts.dmMono(color: AppColors.textSecondary, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 20),
          RichText(
            text: TextSpan(
              style: GoogleFonts.dmMono(fontSize: 13, height: 1.75),
              children: [
                _kw('@RestController'), _nl(),
                _kw('@RequestMapping'), _plain('('), _str('"/api/portfolio"'), _plain(')'), _nl(),
                _type('public class '), _fn('AjayController '), _plain('{'), _nl(),
                _nl(),
                _plain('  '), _kw('@GetMapping'), _plain('('), _str('"/skills"'), _plain(')'), _nl(),
                _plain('  '), _type('public '), _type('List<String> '), _fn('getSkills'), _plain('() {'), _nl(),
                _plain('    '), _kw('return '), _type('List'), _plain('.of('), _nl(),
                _plain('      '), _str('"Flutter"'), _plain(', '), _str('"Spring Boot"'), _plain(','), _nl(),
                _plain('      '), _str('"AWS"'), _plain(', '), _str('"Microservices"'), _nl(),
                _plain('    );'), _nl(),
                _plain('  }'), _nl(),
                _nl(),
                _plain('  '), _kw('@PostMapping'), _plain('('), _str('"/hire"'), _plain(')'), _nl(),
                _plain('  '), _type('public String '), _fn('hireMe'), _plain('() {'), _nl(),
                _plain('    '), _kw('return '), _str('"Let\'s build great things! 🚀"'), _plain(';'), _nl(),
                _plain('  }'), _nl(),
                _plain('}'),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 600.ms, duration: 800.ms).slideX(begin: 0.2);
  }

  Widget _dot(Color c) =>
      Container(width: 12, height: 12, decoration: BoxDecoration(color: c, shape: BoxShape.circle));

  TextSpan _kw(String t) => TextSpan(text: t, style: const TextStyle(color: Color(0xFFC792EA)));
  TextSpan _type(String t) => TextSpan(text: t, style: const TextStyle(color: Color(0xFF00D4FF)));
  TextSpan _str(String t) => TextSpan(text: t, style: const TextStyle(color: Color(0xFFC3E88D)));
  TextSpan _fn(String t) => TextSpan(text: t, style: const TextStyle(color: Color(0xFF82AAFF)));
  TextSpan _plain(String t) => TextSpan(text: t, style: const TextStyle(color: Color(0xFFE0E0E0)));
  TextSpan _nl() => _plain('\n');
}

// ═══════════════════════════════════════════════════════════════════════════════
// ABOUT
// ═══════════════════════════════════════════════════════════════════════════════

class _AboutSection extends StatelessWidget {
  final bool isDesktop;

  const _AboutSection({super.key, required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Entrance(
          id: 'about-title',
          child: SectionTitle(title: 'About Me', tag: '// who_am_i'),
        ),
        Entrance(
          id: 'about-content',
          delay: const Duration(milliseconds: 150),
          child: isDesktop
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _Avatar(),
                    const SizedBox(width: 56),
                    Expanded(child: _AboutText()),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _Avatar(),
                    const SizedBox(height: 32),
                    _AboutText(),
                  ],
                ),
        ),
        const SizedBox(height: 56),
        Entrance(
          id: 'about-stats',
          delay: const Duration(milliseconds: 300),
          child: _StatsRow(isDesktop: isDesktop),
        ),
      ],
    );
  }
}

class _Avatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.accent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 30,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(3),
        child: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.background,
          ),
          child: Center(
            child: Text(
              'AJ',
              style: GoogleFonts.spaceGrotesk(
                color: AppColors.primary,
                fontSize: 56,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AboutText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppConstants.aboutBio, style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(height: 24),
        Row(
          children: [
            const Icon(Icons.location_on_rounded, color: AppColors.accent, size: 18),
            const SizedBox(width: 8),
            Text(
              AppConstants.location,
              style: GoogleFonts.dmMono(color: AppColors.textSecondary, fontSize: 14),
            ),
          ],
        ),
      ],
    );
  }
}

class _StatsRow extends StatelessWidget {
  final bool isDesktop;

  const _StatsRow({required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: isDesktop
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _buildStats(),
            )
          : Wrap(
              spacing: 32,
              runSpacing: 32,
              alignment: WrapAlignment.center,
              children: _buildStats(),
            ),
    );
  }

  List<Widget> _buildStats() {
    return AppConstants.aboutStats.map((s) {
      return AnimatedCounter(
        value: s['value']!,
        suffix: s['suffix']!,
        label: s['label']!,
      );
    }).toList();
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// SKILLS
// ═══════════════════════════════════════════════════════════════════════════════

class _SkillsSection extends StatelessWidget {
  const _SkillsSection({super.key});

  static const _catColors = {
    'backend': AppColors.catBackend,
    'mobile': AppColors.catMobile,
    'cloud': AppColors.catCloud,
    'database': AppColors.catDatabase,
    'security': AppColors.catSecurity,
    'integrations': AppColors.catIntegrations,
    'tools': AppColors.catTools,
  };

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = constraints.maxWidth < 600 ? constraints.maxWidth : 340.0;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Entrance(
              id: 'skills-title',
              child: SectionTitle(title: 'Tech Stack', tag: '// technologies'),
            ),
            Wrap(
              spacing: 24,
              runSpacing: 24,
              children: AppConstants.skills.asMap().entries.map((entry) {
                final i = entry.key;
                final cat = entry.value;
                final color = _catColors[cat['colorKey']] ?? AppColors.primary;
                return Entrance(
                  id: 'skill-cat-$i',
                  delay: Duration(milliseconds: i * 80),
                  child: _SkillCategory(
                    category: cat['category'] as String,
                    items: List<String>.from(cat['items'] as List),
                    color: color,
                    width: cardWidth,
                  ),
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }
}

class _SkillCategory extends StatelessWidget {
  final String category;
  final List<String> items;
  final Color color;
  final double width;

  const _SkillCategory({required this.category, required this.items, required this.color, this.width = 340});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: GlassCard(
        borderColor: color.withValues(alpha: 0.2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                ),
                const SizedBox(width: 10),
                Text(
                  category,
                  style: GoogleFonts.spaceGrotesk(
                    color: color,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: items.map((s) => SkillChip(text: s, color: color)).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// EXPERIENCE
// ═══════════════════════════════════════════════════════════════════════════════

class _ExperienceSection extends StatelessWidget {
  const _ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Entrance(
          id: 'exp-title',
          child: SectionTitle(title: 'Professional Experience', tag: '// professional_journey'),
        ),
        ...AppConstants.experience.asMap().entries.map((e) {
          return Entrance(
            id: 'exp-entry-${e.key}',
            delay: Duration(milliseconds: e.key * 200),
            child: _ExpEntry(exp: e.value),
          );
        }),
      ],
    );
  }
}

class _ExpEntry extends StatelessWidget {
  final Map<String, dynamic> exp;

  const _ExpEntry({required this.exp});

  @override
  Widget build(BuildContext context) {
    final isCurrent = exp['isCurrent'] as bool;
    final dotColor = isCurrent ? AppColors.primary : AppColors.accent;
    final projects = exp['projects'] as List;

    return Padding(
      padding: const EdgeInsets.only(bottom: 48),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Timeline
            Column(
              children: [
                Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    color: dotColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: dotColor.withValues(alpha: 0.5),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 2,
                    color: AppColors.border,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 28),
            // Card
            Expanded(
              child: GlassCard(
                borderColor: dotColor.withValues(alpha: 0.2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Wrap(
                      spacing: 10,
                      runSpacing: 8,
                      children: [
                        if (isCurrent)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: AppColors.primary.withValues(alpha: 0.4),
                              ),
                            ),
                            child: Text(
                              'Current',
                              style: GoogleFonts.dmMono(
                                color: AppColors.primary,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      exp['role'] as String,
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: AppColors.textMain,
                          ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${exp['company']} · ${exp['location']}',
                      style: TextStyle(
                        color: dotColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      exp['duration'] as String,
                      style: GoogleFonts.dmMono(
                        color: AppColors.textSecondary,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Projects
                    ...projects.map((p) {
                      final proj = p as Map<String, dynamic>;
                      return _ProjectBlock(proj: proj, color: dotColor);
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProjectBlock extends StatelessWidget {
  final Map<String, dynamic> proj;
  final Color color;

  const _ProjectBlock({required this.proj, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: color.withValues(alpha: 0.3)),
            ),
            child: Text(
              proj['name'] as String,
              style: GoogleFonts.spaceGrotesk(
                color: color,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(height: 14),
          ...(proj['points'] as List).map(
            (point) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('▹ ', style: TextStyle(color: color, fontWeight: FontWeight.w700)),
                  Expanded(
                    child: Text(
                      point as String,
                      style: Theme.of(context).textTheme.bodyMedium,
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

// ═══════════════════════════════════════════════════════════════════════════════
// KEY ACHIEVEMENTS
// ═══════════════════════════════════════════════════════════════════════════════

class _AchievementsSection extends StatelessWidget {
  final bool isMobile;

  const _AchievementsSection({super.key, required this.isMobile});

  static final _icons = {
    'rocket': FontAwesomeIcons.rocket,
    'creditCard': FontAwesomeIcons.creditCard,
    'globe': FontAwesomeIcons.globe,
    'trophy': FontAwesomeIcons.trophy,
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Entrance(
          id: 'ach-title',
          child: SectionTitle(title: 'Key Achievements', tag: '// highlights'),
        ),
        Wrap(
          spacing: 24,
          runSpacing: 24,
          children: AppConstants.achievements.asMap().entries.map((e) {
            final i = e.key;
            final a = e.value;
            return Entrance(
              id: 'ach-$i',
              delay: Duration(milliseconds: i * 100),
              child: SizedBox(
                width: isMobile ? double.infinity : 480,
                child: _AchievementCard(
                  icon: _icons[a['icon']] ?? FontAwesomeIcons.star,
                  stat: a['stat'] as String,
                  title: a['title'] as String,
                  description: a['description'] as String,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _AchievementCard extends StatefulWidget {
  final IconData icon;
  final String stat;
  final String title;
  final String description;

  const _AchievementCard({
    required this.icon,
    required this.stat,
    required this.title,
    required this.description,
  });

  @override
  State<_AchievementCard> createState() => _AchievementCardState();
}

class _AchievementCardState extends State<_AchievementCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: _hovered
              ? AppColors.primary.withValues(alpha: 0.08)
              : Colors.white.withValues(alpha: 0.03),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _hovered
                ? AppColors.primary.withValues(alpha: 0.4)
                : AppColors.border,
          ),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.15),
                    blurRadius: 20,
                  )
                ]
              : null,
        ),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
              ),
              child: Center(
                child: FaIcon(widget.icon, color: AppColors.primary, size: 22),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        widget.stat,
                        style: GoogleFonts.spaceGrotesk(
                          color: AppColors.primary,
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          height: 1,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        widget.title,
                        style: GoogleFonts.spaceGrotesk(
                          color: AppColors.textMain,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// CERTIFICATIONS
// ═══════════════════════════════════════════════════════════════════════════════

class _CertificationsSection extends StatelessWidget {
  final bool isMobile;

  const _CertificationsSection({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = isMobile ? constraints.maxWidth : 340.0;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Entrance(
              id: 'cert-title',
              child: SectionTitle(title: 'Certifications', tag: '// credentials'),
            ),
            Wrap(
              spacing: 24,
              runSpacing: 24,
              children: AppConstants.certifications.asMap().entries.map((e) {
                final i = e.key;
                final cert = e.value;
                return Entrance(
                  id: 'cert-$i',
                  delay: Duration(milliseconds: i * 100),
                  child: SizedBox(
                    width: cardWidth,
                    child: _CertCard(cert: cert),
                  ),
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }
}

class _CertCard extends StatelessWidget {
  final Map<String, dynamic> cert;

  const _CertCard({required this.cert});

  @override
  Widget build(BuildContext context) {
    final isAward = cert['type'] == 'award';
    final iconColor = isAward ? const Color(0xFFFFD166) : AppColors.primary;

    return GlassCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon or logo
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: iconColor.withValues(alpha: 0.3)),
            ),
            child: cert['logoUrl'] != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      cert['logoUrl'] as String,
                      width: 48,
                      height: 48,
                      fit: BoxFit.contain,
                      loadingBuilder: (_, child, progress) {
                        if (progress == null) return child;
                        return Center(
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: iconColor,
                            ),
                          ),
                        );
                      },
                      errorBuilder: (_, __, ___) => Center(
                        child: FaIcon(
                          isAward ? FontAwesomeIcons.trophy : FontAwesomeIcons.certificate,
                          color: iconColor,
                          size: 20,
                        ),
                      ),
                    ),
                  )
                : Center(
                    child: FaIcon(
                      isAward ? FontAwesomeIcons.trophy : FontAwesomeIcons.certificate,
                      color: iconColor,
                      size: 20,
                    ),
                  ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cert['title'] as String,
                  style: GoogleFonts.spaceGrotesk(
                    color: AppColors.textMain,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  cert['issuer'] as String,
                  style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
                ),
                const SizedBox(height: 6),
                Text(
                  cert['year'] as String,
                  style: GoogleFonts.dmMono(color: iconColor, fontSize: 12),
                ),
                if ((cert['verifyUrl'] as String).isNotEmpty) ...[
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () => launchUrl(Uri.parse(cert['verifyUrl'] as String)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Verify Badge →',
                          style: GoogleFonts.dmMono(
                            color: AppColors.accent,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// EDUCATION
// ═══════════════════════════════════════════════════════════════════════════════

class _EducationSection extends StatelessWidget {
  final bool isDesktop;

  const _EducationSection({super.key, required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Entrance(
          id: 'edu-title',
          child: SectionTitle(title: 'Education', tag: '// academic_background'),
        ),
        Wrap(
          spacing: 24,
          runSpacing: 24,
          children: AppConstants.education.asMap().entries.map((e) {
            final i = e.key;
            final edu = e.value;
            return Entrance(
              id: 'edu-$i',
              delay: Duration(milliseconds: i * 150),
              child: SizedBox(
                width: isDesktop ? 490 : double.infinity,
                child: GlassCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.accent.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.accent.withValues(alpha: 0.3)),
                        ),
                        child: const FaIcon(FontAwesomeIcons.graduationCap, color: AppColors.accent, size: 22),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        edu['degree']!,
                        style: GoogleFonts.spaceGrotesk(
                          color: AppColors.textMain,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        edu['institution']!,
                        style: const TextStyle(color: AppColors.textSecondary, fontSize: 15),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        edu['duration']!,
                        style: GoogleFonts.dmMono(color: AppColors.primary, fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// CONTACT
// ═══════════════════════════════════════════════════════════════════════════════

class _ContactSection extends StatefulWidget {
  final bool isDesktop;

  const _ContactSection({super.key, required this.isDesktop});

  @override
  State<_ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<_ContactSection> {
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _msgCtrl = TextEditingController();

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _msgCtrl.dispose();
    super.dispose();
  }

  void _send() {
    final subject = Uri.encodeComponent('Portfolio Contact from ${_nameCtrl.text}');
    final body = Uri.encodeComponent(
      'From: ${_nameCtrl.text}\nEmail: ${_emailCtrl.text}\n\n${_msgCtrl.text}',
    );
    launchUrl(Uri.parse('mailto:${AppConstants.email}?subject=$subject&body=$body'));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Entrance(
          id: 'contact-title',
          child: SectionTitle(title: "Let's Connect", tag: '// get_in_touch'),
        ),
        Entrance(
          id: 'contact-subtitle',
          delay: const Duration(milliseconds: 100),
          child: Text(
            'Open to full-time roles, freelance projects, and collaborations.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        const SizedBox(height: 48),
        Entrance(
          id: 'contact-body',
          delay: const Duration(milliseconds: 200),
          child: widget.isDesktop
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _ContactInfo()),
                    const SizedBox(width: 48),
                    Expanded(child: _ContactForm(nameCtrl: _nameCtrl, emailCtrl: _emailCtrl, msgCtrl: _msgCtrl, onSend: _send)),
                  ],
                )
              : Column(
                  children: [
                    _ContactInfo(),
                    const SizedBox(height: 40),
                    _ContactForm(nameCtrl: _nameCtrl, emailCtrl: _emailCtrl, msgCtrl: _msgCtrl, onSend: _send),
                  ],
                ),
        ),
      ],
    );
  }
}

class _ContactInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final items = [
      {'icon': FontAwesomeIcons.envelope, 'label': AppConstants.email, 'url': 'mailto:${AppConstants.email}', 'color': AppColors.accent},
      {'icon': FontAwesomeIcons.phone, 'label': AppConstants.phone, 'url': 'tel:+919175080872', 'color': AppColors.primary},
      {'icon': FontAwesomeIcons.linkedin, 'label': 'linkedin.com/in/ajayaniljadhav', 'url': AppConstants.linkedinUrl, 'color': const Color(0xFF0A66C2)},
      {'icon': FontAwesomeIcons.locationDot, 'label': AppConstants.location, 'url': '', 'color': AppColors.catTools},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.map((item) {
        final icon = item['icon'] as IconData;
        final label = item['label'] as String;
        final url = item['url'] as String;
        final color = item['color'] as Color;
        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: GestureDetector(
            onTap: url.isNotEmpty ? () => launchUrl(Uri.parse(url)) : null,
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: color.withValues(alpha: 0.3)),
                  ),
                  child: Center(child: FaIcon(icon, color: color, size: 17)),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    label,
                    style: GoogleFonts.dmMono(
                      color: url.isNotEmpty ? AppColors.textMain : AppColors.textSecondary,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _ContactForm extends StatelessWidget {
  final TextEditingController nameCtrl;
  final TextEditingController emailCtrl;
  final TextEditingController msgCtrl;
  final VoidCallback onSend;

  const _ContactForm({
    required this.nameCtrl,
    required this.emailCtrl,
    required this.msgCtrl,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        children: [
          TextField(
            controller: nameCtrl,
            decoration: const InputDecoration(labelText: 'Name'),
            style: const TextStyle(color: AppColors.textMain),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: emailCtrl,
            decoration: const InputDecoration(labelText: 'Email'),
            style: const TextStyle(color: AppColors.textMain),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: msgCtrl,
            decoration: const InputDecoration(labelText: 'Message'),
            style: const TextStyle(color: AppColors.textMain),
            maxLines: 5,
          ),
          const SizedBox(height: 24),
          Align(
            alignment: Alignment.centerRight,
            child: PrimaryButton(
              text: 'Send Message',
              icon: Icons.send_rounded,
              onPressed: onSend,
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// GUEST LECTURES
// ═══════════════════════════════════════════════════════════════════════════════

class _GuestLectureSection extends StatelessWidget {
  final bool isDesktop;
  final bool isMobile;

  const _GuestLectureSection({super.key, required this.isDesktop, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    const lectures = AppConstants.guestLectures;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Entrance(
          id: 'speaking-title',
          child: SectionTitle(title: 'Speaking & Mentorship', tag: '// guest_lectures'),
        ),
        Entrance(
          id: 'speaking-subtitle',
          child: Text(
            'Invited to share industry insights with the next generation of developers at Yashwantrao Chavan Institute of Science (YCIS), Satara.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        const SizedBox(height: 40),
        if (isDesktop)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Entrance(
                  id: 'lecture-card-0',
                  child: _LectureVideoCard(lecture: lectures[0], isMobile: false),
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: Entrance(
                  id: 'lecture-card-1',
                  delay: const Duration(milliseconds: 150),
                  child: _LectureVideoCard(lecture: lectures[1], isMobile: false),
                ),
              ),
            ],
          )
        else
          Column(
            children: [
              Entrance(
                id: 'lecture-card-0',
                child: _LectureVideoCard(lecture: lectures[0], isMobile: isMobile),
              ),
              const SizedBox(height: 24),
              Entrance(
                id: 'lecture-card-1',
                delay: const Duration(milliseconds: 150),
                child: _LectureVideoCard(lecture: lectures[1], isMobile: isMobile),
              ),
            ],
          ),
      ],
    );
  }
}

class _LectureVideoCard extends StatefulWidget {
  final Map<String, String> lecture;
  final bool isMobile;

  const _LectureVideoCard({required this.lecture, required this.isMobile});

  @override
  State<_LectureVideoCard> createState() => _LectureVideoCardState();
}

class _LectureVideoCardState extends State<_LectureVideoCard> {
  VideoPlayerController? _ctrl;
  bool _initialized = false;
  bool _dialogOpen = false;
  bool _hovered = false;

  @override
  void initState() {
    super.initState();
    _initVideo();
  }

  Future<void> _initVideo() async {
    final path = widget.lecture['videoAsset'] ?? '';
    if (path.isEmpty) return;
    try {
      final ctrl = VideoPlayerController.asset(path);
      await ctrl.initialize();
      if (!mounted) {
        ctrl.dispose();
        return;
      }
      await ctrl.setLooping(true);
      await ctrl.setVolume(0);
      await ctrl.play();
      setState(() {
        _ctrl = ctrl;
        _initialized = true;
      });
    } catch (_) {
      // Video unavailable — gradient placeholder renders instead
    }
  }

  @override
  void dispose() {
    _ctrl?.dispose();
    super.dispose();
  }

  void _openPlayer(BuildContext context) {
    _ctrl?.pause();
    _ctrl?.setVolume(1.0);
    setState(() => _dialogOpen = true);
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.9),
      builder: (_) => _VideoDialog(
        controller: _ctrl!,
        title: widget.lecture['topic']!,
      ),
    ).then((_) {
      if (!mounted) return;
      _ctrl?.setVolume(0);
      _ctrl?.play();
      setState(() => _dialogOpen = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final cardHeight = widget.isMobile ? 300.0 : 440.0;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        height: cardHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _hovered
                ? AppColors.primary.withValues(alpha: 0.5)
                : AppColors.border,
            width: _hovered ? 1.5 : 1,
          ),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.18),
                    blurRadius: 40,
                    spreadRadius: -8,
                  ),
                ]
              : null,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // ── Background: video or gradient placeholder ──
              if (_initialized && _ctrl != null && !_dialogOpen)
                FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: _ctrl!.value.size.width,
                    height: _ctrl!.value.size.height,
                    child: VideoPlayer(_ctrl!),
                  ),
                )
              else
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF1A1A2E), Color(0xFF16213E), Color(0xFF0F3460)],
                    ),
                  ),
                  child: Center(
                    child: FaIcon(
                      FontAwesomeIcons.chalkboardUser,
                      color: AppColors.primary.withValues(alpha: 0.18),
                      size: 90,
                    ),
                  ),
                ),

              // ── Gradient overlay (always shown) ──
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [0.0, 0.4, 1.0],
                      colors: [
                        Colors.black.withValues(alpha: 0.42),
                        Colors.black.withValues(alpha: 0.58),
                        Colors.black.withValues(alpha: 0.96),
                      ],
                    ),
                  ),
                ),
              ),

              // ── Top-left badge ──
              Positioned(
                top: 20,
                left: 20,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.88),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const FaIcon(FontAwesomeIcons.chalkboardUser,
                          color: Colors.white, size: 11),
                      const SizedBox(width: 6),
                      Text(
                        widget.lecture['number']!,
                        style: GoogleFonts.dmMono(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ── Muted indicator (top-right, only when video playing) ──
              if (_initialized && !_dialogOpen)
                Positioned(
                  top: 20,
                  right: 20,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.45),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.volume_off_rounded,
                        color: Colors.white60, size: 14),
                  ),
                ),

              // ── Bottom content ──
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.location_on_rounded,
                              color: AppColors.accent, size: 13),
                          const SizedBox(width: 4),
                          Text(
                            widget.lecture['institute']!,
                            style: GoogleFonts.dmMono(
                                color: AppColors.accent, fontSize: 12),
                          ),
                          const Spacer(),
                          Text(
                            widget.lecture['date']!,
                            style: GoogleFonts.dmMono(
                                color: Colors.white54, fontSize: 11),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        widget.lecture['topic']!,
                        style: GoogleFonts.spaceGrotesk(
                          color: Colors.white,
                          fontSize: widget.isMobile ? 16 : 19,
                          fontWeight: FontWeight.w700,
                          height: 1.25,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.lecture['department']!,
                        style: GoogleFonts.inter(
                            color: Colors.white54, fontSize: 13),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.lecture['tags']!,
                              style: GoogleFonts.dmMono(
                                color: AppColors.primary
                                    .withValues(alpha: 0.85),
                                fontSize: 11,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 12),
                          GestureDetector(
                            onTap: () {
                              if (_initialized && _ctrl != null) {
                                _openPlayer(context);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Video plays on Safari (iOS/macOS). Convert to .mp4 for Chrome support.',
                                      style: GoogleFonts.dmMono(fontSize: 13),
                                    ),
                                    backgroundColor: const Color(0xFF1E1E2E),
                                    behavior: SnackBarBehavior.floating,
                                    duration: const Duration(seconds: 4),
                                  ),
                                );
                              }
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 180),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: _hovered
                                    ? Colors.white.withValues(alpha: 0.22)
                                    : Colors.white.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.white30),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    _initialized
                                        ? Icons.play_arrow_rounded
                                        : Icons.play_disabled_rounded,
                                    color: _initialized
                                        ? Colors.white
                                        : Colors.white54,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Watch',
                                    style: GoogleFonts.spaceGrotesk(
                                      color: _initialized
                                          ? Colors.white
                                          : Colors.white54,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _VideoDialog extends StatefulWidget {
  final VideoPlayerController controller;
  final String title;

  const _VideoDialog({required this.controller, required this.title});

  @override
  State<_VideoDialog> createState() => _VideoDialogState();
}

class _VideoDialogState extends State<_VideoDialog> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_update);
  }

  void _update() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    widget.controller.removeListener(_update);
    super.dispose();
  }

  String _fmt(Duration d) {
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    final ctrl = widget.controller;
    final isPlaying = ctrl.value.isPlaying;
    final position = ctrl.value.position;
    final duration = ctrl.value.duration;
    final muted = ctrl.value.volume == 0;

    final screenH = MediaQuery.of(context).size.height;
    return Dialog(
      backgroundColor: const Color(0xFF0E0E0E),
      insetPadding: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: screenH * 0.85),
        child: Column(
          children: [
            // Title bar
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 8, 12),
              child: Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                        color: AppColors.primary, shape: BoxShape.circle),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      widget.title,
                      style: GoogleFonts.spaceGrotesk(
                        color: AppColors.textMain,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded, color: Colors.white60),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),

            // Video — Expanded so it fills remaining height, AspectRatio letterboxes inside
            Expanded(
              child: AspectRatio(
                aspectRatio: ctrl.value.isInitialized
                    ? ctrl.value.aspectRatio
                    : 16 / 9,
                child: ctrl.value.isInitialized
                    ? VideoPlayer(ctrl)
                    : const Center(
                        child: CircularProgressIndicator(
                            color: AppColors.primary)),
              ),
            ),

            // Progress bar
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: VideoProgressIndicator(
                ctrl,
                allowScrubbing: true,
                colors: const VideoProgressColors(
                  playedColor: AppColors.primary,
                  bufferedColor: Color(0x44FFFFFF),
                  backgroundColor: Color(0x22FFFFFF),
                ),
              ),
            ),

            // Controls row
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 4, 8, 12),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                      color: Colors.white,
                      size: 26,
                    ),
                    onPressed: () =>
                        isPlaying ? ctrl.pause() : ctrl.play(),
                  ),
                  Text(
                    '${_fmt(position)} / ${_fmt(duration)}',
                    style: GoogleFonts.dmMono(
                        color: Colors.white54, fontSize: 12),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: Icon(
                      muted
                          ? Icons.volume_off_rounded
                          : Icons.volume_up_rounded,
                      color: Colors.white60,
                      size: 22,
                    ),
                    onPressed: () =>
                        ctrl.setVolume(muted ? 1.0 : 0.0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// FOOTER
// ═══════════════════════════════════════════════════════════════════════════════

class _Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 48),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.border, width: 1)),
      ),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SocialButton(icon: FontAwesomeIcons.linkedin, url: AppConstants.linkedinUrl, color: Color(0xFF0A66C2)),
              SizedBox(width: 16),
              SocialButton(icon: FontAwesomeIcons.github, url: AppConstants.githubUrl, color: AppColors.textMain),
              SizedBox(width: 16),
              SocialButton(icon: FontAwesomeIcons.envelope, url: 'mailto:${AppConstants.email}', color: AppColors.accent),
            ],
          ),
          const SizedBox(height: 28),
          Text(
            'Designed & Built by Ajay Jadhav',
            style: GoogleFonts.dmMono(color: AppColors.textSecondary, fontSize: 13),
          ),
          const SizedBox(height: 8),
          Text(
            'Made with Flutter 💙  ·  © 2025',
            style: GoogleFonts.dmMono(color: AppColors.textSecondary, fontSize: 13),
          ),
        ],
      ),

    );
  }
}
