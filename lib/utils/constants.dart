class AppConstants {
  static const String name = "Ajay Jadhav";
  static const String role = "Software Engineer (Flutter & Spring Boot)";
  static const String shortRole = "Software Engineer";
  static const String email = "ajayjadhav852000@gmail.com";
  static const String location = "Pune, India";
  static const String phone = "+91 91750 80872";
  static const String linkedinUrl = "https://linkedin.com/in/ajayaniljadhav";
  
  static const String heroDescription = "Software Engineer specializing in building scalable systems. Bridging the gap between high-performance backends, seamless mobile experiences, and resilient deployment pipelines.";
  
  static const String aboutMe = "I engineer complete product ecosystems. Over the past ~4 years, my focus has been on architecting robust backend infrastructures, delivering high-performance cross-platform mobile functionality, and ensuring deployment reliability through advanced DevOps structures. My technical contributions span across establishing multi-tenant architectures scaling to 30+ B2B clients and integrating mission-critical regional authentication frameworks for extensive international markets (USA, Japan, China). I specialize in diagnosing and solving complex architectural bottlenecks at scale—combining robust Java Spring Boot microservices, resilient Flutter frontends, and automated GitLab/Jenkins pipelines to deliver platforms ready for global operation.";
  
  static const List<Map<String, dynamic>> skills = [
    {"category": "Mobile Engineering", "items": ["Flutter (Advanced)", "Bloc", "GetX", "Clean Architecture"]},
    {"category": "Backend & Architecture", "items": ["Java", "Spring Boot", "Microservices"]},
    {"category": "Cloud & DevOps", "items": ["AWS (EC2, S3, Lambda)", "Docker", "Kubernetes", "Jenkins", "GitLab CI/CD"]},
    {"category": "Integrations", "items": ["WeChat SDK", "Line SDK", "Payment Gateways", "Firebase", "OAuth 2.0"]},
  ];
  
  static const List<Map<String, dynamic>> projects = [
    {
      "name": "Kicksnap (AI E-commerce Platform)",
      "metric": "Global Expansion",
      "description": "High-performance AI-driven e-commerce platform scaled globally.",
      "problem": "Reaching international distinct markets structurally limited by localization and region-specific login restrictions.",
      "solution": "Built a global Flutter application supporting 8 languages natively, integrated complex regional authentication workflows including LINE (Japan) and WeChat (China), and implemented cutting-edge AI 'Search by Image' alongside AR Try-on modules.",
      "impact": "Significantly improved user engagement metrics and effectively extended product reach across core distinct international markets.",
      "tech": ["Flutter", "Dart", "LINE SDK", "WeChat SDK", "AR Core"]
    },
    {
      "name": "Cascada (IoT Smart Waterer)",
      "metric": "100% Reliability",
      "description": "Stable IoT controller interface ensuring mission-critical health alerts.",
      "problem": "Legacy codebase lacked stability, with deep-linking failures preventing timely intervention alerts.",
      "solution": "Migrated legacy Flutter infrastructure to the latest framework versions and entirely replaced deprecated Firebase Dynamic Links with robust App Links.",
      "impact": "Ensured 100% reliability for vital hardware health alerts, stabilizing the IoT management lifecycle.",
      "tech": ["Flutter", "IoT", "App Links", "Firebase"]
    },
    {
      "name": "Jewello (B2C FinTech Platform)",
      "metric": "Multi-tenant Scaling",
      "description": "Scalable financial technology backend supporting simultaneous B2C clients.",
      "problem": "Standard backend architecture couldn't structurally isolate or securely handle overlapping B2B distinct transaction flows.",
      "solution": "Designed a dynamic microservices backend via Spring Boot establishing a robust multi-tenant architecture to support 30+ distinct clients, integrating major payment gateways like Cashfree and BillDesk securely.",
      "impact": "Delivered a highly secure, isolated, and scalable transaction system reliably addressing massive multi-client B2C load.",
      "tech": ["Spring Boot", "Java", "Microservices", "Cashfree API"]
    },
    {
      "name": "CI/CD Automation System",
      "metric": "Deployment Efficiency",
      "description": "Automated deployment pipeline eliminating manual staging workflows.",
      "problem": "Manual compilation and varied regional deployments induced massive human-error vulnerability and downtime.",
      "solution": "Constructed end-to-end automated pipelines utilizing GitLab CI/CD alongside Jenkins, handling complex selective app versioning and simultaneous deployment routines.",
      "impact": "Reduced manual deployment effort significantly, virtually eliminating deployment-time errors across application rollout phases.",
      "tech": ["GitLab CI/CD", "Jenkins", "Docker", "Kubernetes"]
    },
    {
      "name": "POS Hardware Integration System",
      "metric": "Real-time Settlement",
      "description": "Native Android Point-of-Sale hardware integrated securely.",
      "problem": "Seamless hardware interaction required zero-latency processing to prevent financial discrepancies during on-site checkout.",
      "solution": "Engineered a low-level integration between the Android POS and immediate payment processing machines, strictly orchestrating synchronous real-time data flows.",
      "impact": "Facilitated completely secure, instantaneous financial settlements, directly enhancing physical retail operational speed.",
      "tech": ["Android SDK", "Java", "Hardware APIs"]
    }
  ];

  static const List<Map<String, dynamic>> experience = [
    {
      "company": "Mindbowser Inc",
      "role": "Software Engineer",
      "duration": "August 2025 – Present",
      "location": "Pune, India",
      "points": [
        "Architected highly scalable cross-platform solutions for massive international markets including the USA, Japan, and China.",
        "Drove complex system-level integrations bypassing critical regional telecom blocks via strategic LINE and WeChat auth deployments.",
        "Designed performant multi-lingual architectures and AI-driven capability integrations yielding substantial engagement improvements."
      ]
    },
    {
      "company": "Acme Infovision Systems Pvt. Ltd.",
      "role": "Software Developer",
      "duration": "June 2022 – August 2025",
      "location": "Satara, India",
      "points": [
        "Constructed isolated Spring Boot microservice architectures empowering a single ecosystem to serve 30+ disparate enterprise clients effectively.",
        "Optimized DevOps processes by delivering a resilient automated deployment structure utilizing advanced pipeline tools, significantly decreasing engineer overhead.",
        "Delivered mission-critical native payment integrations ensuring 99.9% reconciliation accuracy across massive financial throughput."
      ]
    }
  ];

  static const List<Map<String, dynamic>> education = [
    {
      "degree": "Master of Computer Applications (MCA)",
      "institution": "Shivaji University",
      "duration": "2021 – 2023",
    },
    {
      "degree": "Bachelor of Computer Applications (BCA)",
      "institution": "Shivaji University",
      "duration": "2018 – 2021",
    }
  ];

  static const List<Map<String, dynamic>> certifications = [
    {
      "title": "AWS Certified Developer – Associate",
      "year": "2026 – 2029",
      "logoUrl": "https://images.credly.com/size/340x340/images/b9feab85-1a43-4f6c-99a5-6ea51d4d5259/image.png",
    },
    {
      "title": "Microservices with Spring Boot & Spring Cloud",
      "year": "Udemy Certified",
      "logoUrl": "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e3/Udemy_logo.svg/512px-Udemy_logo.svg.png",
    },
    {
      "title": "Best Performer of the Year Award (ABP 2024)",
      "year": "Acme Infovision Systems",
    }
  ];

  static const List<Map<String, dynamic>> careerPosts = [
    {
      "id": "7418307629279498240",
      "title": "Guest Lecture: Career Guidance & Computer Science",
      "description": "It was an absolute privilege to interact with the bright minds and share my insights on career paths in Computer Science. We discussed the evolving landscape of tech, from scalable backend systems with Spring Boot to cross-platform mobile apps with Flutter.",
      "date": "Recent",
      "tags": ["#GuestLecture", "#CareerGuidance", "#ComputerScience", "#Flutter"],
      "link": "https://www.linkedin.com/posts/ajayaniljadhav_guestlecture-careerguidance-computerscience-activity-7418307629279498240-gI2m",
    },
    {
      "id": "7375357688265904128",
      "title": "Flutter Architecture Masterclass at YCIS",
      "description": "Had a fantastic opportunity to deliver a guest lecture at YCIS highlighting the power of Clean Architecture in Flutter. We dove deep into responsive UI, BLoC pattern, and how to scale mobile solutions for millions of users.",
      "date": "Recent",
      "tags": ["#Flutter", "#GuestLecture", "#CleanArchitecture", "#YCIS"],
      "link": "https://www.linkedin.com/posts/ajayaniljadhav_flutter-guestlecture-ycis-activity-7375357688265904128-FLnq",
    }
  ];
}
