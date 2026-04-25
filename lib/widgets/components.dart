import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:animate_do/animate_do.dart';
import '../theme/app_colors.dart';

// ─── Glass card ──────────────────────────────────────────────────────────────

class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final Color? borderColor;

  const GlassCard({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius = 16,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: padding ?? const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.04),
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: borderColor ?? Colors.white.withValues(alpha: 0.08),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}

// ─── Section title ────────────────────────────────────────────────────────────

class SectionTitle extends StatelessWidget {
  final String title;
  final String tag;

  const SectionTitle({super.key, required this.title, required this.tag});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tag,
            style: GoogleFonts.dmMono(
              color: AppColors.accent,
              fontSize: 13,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 4,
                height: 36,
                margin: const EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.primary, AppColors.accent],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Flexible(child: Text(title, style: Theme.of(context).textTheme.displaySmall)),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Skill chip ───────────────────────────────────────────────────────────────

class SkillChip extends StatefulWidget {
  final String text;
  final Color color;

  const SkillChip({super.key, required this.text, required this.color});

  @override
  State<SkillChip> createState() => _SkillChipState();
}

class _SkillChipState extends State<SkillChip> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final c = widget.color;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: _hovered ? c.withValues(alpha: 0.15) : c.withValues(alpha: 0.06),
          border: Border.all(
            color: _hovered ? c.withValues(alpha: 0.8) : c.withValues(alpha: 0.3),
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: _hovered
              ? [BoxShadow(color: c.withValues(alpha: 0.25), blurRadius: 10, spreadRadius: -2)]
              : null,
        ),
        child: Text(
          widget.text,
          style: GoogleFonts.dmMono(
            color: _hovered ? c : c.withValues(alpha: 0.8),
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

// ─── Primary button ───────────────────────────────────────────────────────────

class PrimaryButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;

  const PrimaryButton({super.key, required this.text, required this.onPressed, this.icon});

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            colors: _hovered
                ? [AppColors.accent, AppColors.primary]
                : [AppColors.primary, AppColors.primary.withValues(alpha: 0.85)],
          ),
          boxShadow: _hovered
              ? [BoxShadow(color: AppColors.primary.withValues(alpha: 0.4), blurRadius: 20, offset: const Offset(0, 8))]
              : null,
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          child: InkWell(
            onTap: widget.onPressed,
            borderRadius: BorderRadius.circular(10),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.icon != null) ...[
                    Icon(widget.icon, size: 18, color: Colors.white),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    widget.text,
                    style: GoogleFonts.spaceGrotesk(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Outlined button ─────────────────────────────────────────────────────────

class OutlineBtn extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;

  const OutlineBtn({super.key, required this.text, required this.onPressed, this.icon});

  @override
  State<OutlineBtn> createState() => _OutlineBtnState();
}

class _OutlineBtnState extends State<OutlineBtn> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _hovered ? AppColors.accent : AppColors.primary),
          color: _hovered ? AppColors.primary.withValues(alpha: 0.08) : Colors.transparent,
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          child: InkWell(
            onTap: widget.onPressed,
            borderRadius: BorderRadius.circular(10),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.icon != null) ...[
                    Icon(widget.icon, size: 16, color: _hovered ? AppColors.accent : AppColors.primary),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    widget.text,
                    style: GoogleFonts.spaceGrotesk(
                      color: _hovered ? AppColors.accent : AppColors.primary,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Social button ────────────────────────────────────────────────────────────

class SocialButton extends StatefulWidget {
  final IconData icon;
  final String url;
  final Color? color;

  const SocialButton({super.key, required this.icon, required this.url, this.color});

  @override
  State<SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<SocialButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final c = widget.color ?? AppColors.primary;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => launchUrl(Uri.parse(widget.url)),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: _hovered ? c : AppColors.border),
            color: _hovered ? c.withValues(alpha: 0.1) : Colors.transparent,
            boxShadow: _hovered
                ? [BoxShadow(color: c.withValues(alpha: 0.3), blurRadius: 12)]
                : null,
          ),
          child: FaIcon(widget.icon, color: _hovered ? c : AppColors.textSecondary, size: 18),
        ),
      ),
    );
  }
}

// ─── Animated counter ─────────────────────────────────────────────────────────

class AnimatedCounter extends StatefulWidget {
  final String value;
  final String suffix;
  final String label;

  const AnimatedCounter({
    super.key,
    required this.value,
    required this.suffix,
    required this.label,
  });

  @override
  State<AnimatedCounter> createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<AnimatedCounter>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<int> _anim;
  bool _started = false;

  @override
  void initState() {
    super.initState();
    final target = int.tryParse(widget.value) ?? 0;
    _ctrl = AnimationController(duration: const Duration(milliseconds: 1800), vsync: this);
    _anim = IntTween(begin: 0, end: target)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _start() {
    if (!_started && mounted) {
      _started = true;
      _ctrl.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('counter_${widget.label}'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.1) _start();
      },
      child: AnimatedBuilder(
        animation: _anim,
        builder: (_, __) => Column(
          children: [
            Text(
              '${_anim.value}${widget.suffix}',
              style: GoogleFonts.spaceGrotesk(
                color: AppColors.primary,
                fontSize: 48,
                fontWeight: FontWeight.w700,
                height: 1,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.label,
              style: GoogleFonts.dmMono(
                color: AppColors.textSecondary,
                fontSize: 13,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Scroll entrance wrapper ──────────────────────────────────────────────────

class Entrance extends StatefulWidget {
  final Widget child;
  final String id;
  final Duration delay;

  const Entrance({
    super.key,
    required this.id,
    required this.child,
    this.delay = Duration.zero,
  });

  @override
  State<Entrance> createState() => _EntranceState();
}

class _EntranceState extends State<Entrance> {
  bool _triggered = false;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('entrance_${widget.id}'),
      onVisibilityChanged: (info) {
        if (!_triggered && info.visibleFraction > 0.05 && mounted) {
          setState(() => _triggered = true);
        }
      },
      child: _triggered
          ? FadeInUp(
              delay: widget.delay,
              duration: const Duration(milliseconds: 600),
              child: widget.child,
            )
          : Opacity(opacity: 0, child: widget.child),
    );
  }
}
