class AppConstants {
  static const String name = "Ajay Jadhav";
  static const String role = "Full-Stack Developer";
  static const String email = "ajayjadhav852000@gmail.com";
  static const String location = "Pune, Maharashtra, India";
  static const String phone = "+91 91750 80872";
  static const String linkedinUrl = "https://linkedin.com/in/ajayaniljadhav";
  static const String githubUrl = "https://github.com/";
  static const String resumeUrl = ""; // Add hosted PDF URL here

  static const String heroSubtext =
      "4 years building scalable backends & 30+ live mobile apps";

  static const List<String> heroRoles = [
    "Full-Stack Developer",
    "Flutter Expert",
    "Java / Spring Boot",
    "AWS Certified",
  ];

  static const String aboutBio =
      "Versatile Full-Stack Developer with 4 years of experience delivering scalable "
      "backend systems and cross-platform mobile applications. Expert in Java (JDK 8/17) "
      "and Spring Boot for microservices architecture, and Flutter (Dart) for "
      "production-grade iOS/Android apps with 30+ live deployments. AWS Certified "
      "Developer with expertise in CI/CD, payment gateway integration, IoT connectivity, "
      "and multi-tenant B2C platform design across FinTech, ERP, and E-commerce domains.";

  static const List<Map<String, String>> aboutStats = [
    {"value": "4", "suffix": "+", "label": "Years Experience"},
    {"value": "30", "suffix": "+", "label": "Live Apps"},
    {"value": "3", "suffix": "", "label": "Domains"},
  ];

  static const List<Map<String, dynamic>> skills = [
    {
      "category": "Backend",
      "colorKey": "backend",
      "items": ["Java JDK 8/17", "Spring Boot", "Spring Cloud", "Spring Security", "Hibernate", "REST APIs"],
    },
    {
      "category": "Mobile",
      "colorKey": "mobile",
      "items": ["Flutter", "Dart", "Bloc", "GetX", "Clean Architecture", "Flavor Architecture"],
    },
    {
      "category": "Cloud & DevOps",
      "colorKey": "cloud",
      "items": ["AWS (EC2, S3, Lambda)", "Docker", "Kubernetes (GKE)", "Jenkins", "GitLab CI/CD", "Fastlane"],
    },
    {
      "category": "Databases",
      "colorKey": "database",
      "items": ["PostgreSQL", "MySQL", "JPA/Hibernate", "Query Optimization"],
    },
    {
      "category": "Security & Auth",
      "colorKey": "security",
      "items": ["OAuth 2.0", "JWT", "Spring Security", "WeChat SDK", "Line SDK", "RBAC"],
    },
    {
      "category": "Integrations",
      "colorKey": "integrations",
      "items": ["Cashfree", "BillDesk", "Worldline", "BonusHub", "Firebase", "AppsFlyer"],
    },
    {
      "category": "Tools",
      "colorKey": "tools",
      "items": ["Git", "Postman", "Maven", "SonarQube", "Google Play Console", "App Store Connect"],
    },
  ];

  static const List<Map<String, dynamic>> experience = [
    {
      "company": "Mindbowser Inc",
      "role": "Software Engineer — Flutter",
      "duration": "Aug 2025 – Present",
      "location": "Pune, India",
      "isCurrent": true,
      "projects": [
        {
          "name": "Kicksnap — Global AI-Driven E-commerce Platform",
          "points": [
            "Built Flutter frontend for AI-driven 'Search by Image' sneaker identification and AR Try-On (AR Core / AR Kit), boosting user engagement significantly.",
            "Integrated WeChat (China) and Line (Japan) social login SDKs for East Asian market entry.",
            "Implemented dynamic UI management and L10n for 8 languages in Flutter.",
            "Integrated AppsFlyer SDK with end-to-end deep linking flows.",
          ],
        },
        {
          "name": "Cascada — IoT Smart Waterer for Equine Health",
          "points": [
            "Led Flutter codebase migration to latest stable, fixing Play Store compatibility.",
            "Migrated deprecated Firebase Dynamic Links to Native App Links for horse health alert deep linking — 100% reliability maintained.",
          ],
        },
      ],
    },
    {
      "company": "Acme Infovision Systems Pvt. Ltd.",
      "role": "Software Developer — Java & Flutter",
      "duration": "Jun 2022 – Aug 2025",
      "location": "Satara, India",
      "isCurrent": false,
      "projects": [
        {
          "name": "Jewello — Multi-tenant B2C Jewellery Saving Scheme Platform",
          "points": [
            "Architected Microservices backend using Spring Boot + Spring Cloud for multi-tenant B2C ecosystem with isolated data and branding per client.",
            "Designed Flutter Flavor Architecture enabling 30+ branded apps from a single codebase.",
            "Integrated Cashfree and BillDesk payment gateways with idempotency, retry logic, and backend reconciliation.",
            "Built Jenkins + Fastlane CI/CD pipelines cutting release cycles from days to hours.",
          ],
        },
        {
          "name": "Acme Padm ERP & Acme Jewel POS",
          "points": [
            "Engineered high-performance RESTful APIs in Java/Spring Boot for Jewellery ERP.",
            "Led end-to-end Flutter migration to Dart Null Safety and mentored the team.",
            "Integrated Android POS hardware with Worldline and BonusHub card machines.",
            "Converted tablet UI to mobile-compatible Flutter views for 500+ retail staff.",
          ],
        },
      ],
    },
  ];

  static const List<Map<String, dynamic>> achievements = [
    {
      "icon": "rocket",
      "stat": "30+",
      "title": "Live Apps",
      "description":
          "Delivered iOS + Android apps from a single Flutter codebase using Flavor Architecture — zero cross-tenant data leaks.",
    },
    {
      "icon": "creditCard",
      "stat": "99.9%",
      "title": "Payment Reliability",
      "description":
          "Built robust Spring Boot exception handling with retry mechanisms and transaction idempotency across FinTech integrations.",
    },
    {
      "icon": "globe",
      "stat": "3",
      "title": "Regions Served",
      "description":
          "Architected region-specific OAuth flows (WeChat, Line) for a global e-commerce platform spanning USA, Japan, and China.",
    },
    {
      "icon": "trophy",
      "stat": "2024",
      "title": "Best Performer Award",
      "description":
          "Awarded Best Performer of the Year at Acme Infovision Systems for backend architecture leadership and mobile delivery excellence.",
    },
  ];

  static const List<Map<String, dynamic>> certifications = [
    {
      "title": "AWS Certified Developer – Associate",
      "issuer": "Amazon Web Services",
      "year": "Valid: 2026 – 2029",
      "type": "cert",
      "logoUrl": "https://images.credly.com/size/340x340/images/b9feab85-1a43-4f6c-99a5-6ea51d4d5259/image.png",
      "verifyUrl": "",
    },
    {
      "title": "Microservices with Spring Boot & Spring Cloud",
      "issuer": "Udemy",
      "year": "Udemy Certified",
      "type": "cert",
      "logoUrl": "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e3/Udemy_logo.svg/512px-Udemy_logo.svg.png",
      "verifyUrl": "",
    },
    {
      "title": "Best Performer of the Year 2024",
      "issuer": "Acme Infovision Systems",
      "year": "2024",
      "type": "award",
      "logoUrl": null,
      "verifyUrl": "",
    },
  ];

  static const List<Map<String, String>> education = [
    {
      "degree": "Master of Computer Applications (MCA)",
      "institution": "Shivaji University, Kolhapur",
      "duration": "2021 – 2023",
    },
    {
      "degree": "Bachelor of Computer Applications (BCA)",
      "institution": "Shivaji University, Kolhapur",
      "duration": "2018 – 2021",
    },
  ];
}
