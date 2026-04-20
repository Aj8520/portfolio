// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:ui_web' as ui_web;
import 'package:flutter/material.dart';

class LinkedInEmbedWidget extends StatefulWidget {
  final String activityId;
  final double width;
  final double height;

  const LinkedInEmbedWidget({
    Key? key,
    required this.activityId,
    this.width = 400,
    this.height = 600,
  }) : super(key: key);

  @override
  State<LinkedInEmbedWidget> createState() => _LinkedInEmbedWidgetState();
}

class _LinkedInEmbedWidgetState extends State<LinkedInEmbedWidget> {
  late final String viewId;

  @override
  void initState() {
    super.initState();
    viewId = 'linkedin-embed-${widget.activityId}';
    
    // Register the platform view factory
    // ignore: undefined_prefixed_name
    ui_web.platformViewRegistry.registerViewFactory(viewId, (int id) {
      final iframe = html.IFrameElement()
        ..src = 'https://www.linkedin.com/embed/feed/update/urn:li:activity:${widget.activityId}'
        ..style.border = 'none'
        ..style.height = '100%'
        ..style.width = '100%'
        ..style.borderRadius = '12px'
        ..allowFullscreen = true;
      return iframe;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: Colors.white, // LinkedIn background is white
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      // To ensure scrolling within the iframe works properly, we wrap in an empty GestureDetector
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: HtmlElementView(viewType: viewId),
      ),
    );
  }
}
