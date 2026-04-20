class AppConstants {
  static const String name = "Ajay Jadhav";
  static const String role = "Software Engineer (Flutter & Java/Spring Boot)";
  static const String shortRole = "Flutter & Spring Boot Engineer";
  static const String email = "ajayjadhav852000@gmail.com";
  static const String location = "Pune, Maharashtra, India";
  static const String phone = "+91 91750 80872";
  static const String linkedinUrl = "https://linkedin.com/in/ajayaniljadhav";
  
  static const String heroDescription = "High-impact Software Engineer with nearly 4 years of experience specializing in scalable backend systems and cross-platform mobile applications. Building the future with Flutter and Java.";
  
  static const String aboutMe = "I am a high-impact Software Engineer with a proven track record of architecting multi-tenant B2C platforms and global product integrations. Combining deep expertise in Java, Spring Boot, and Flutter alongside an AWS Developer certification, I focus on CI/CD automation, IoT connectivity, and overcoming complex regional deployment requirements.";
  
  static const List<Map<String, dynamic>> skills = [
    {"category": "Frontend & Mobile", "items": ["Flutter", "Dart", "Bloc", "GetX", "Clean Architecture", "AR Core/AR Kit"]},
    {"category": "Backend", "items": ["Java (8/11/17)", "Spring Boot", "Spring Cloud", "Microservices", "RESTful APIs", "SQL"]},
    {"category": "Cloud & DevOps", "items": ["AWS (EC2/S3/Lambda)", "Kubernetes Context", "Docker", "GitLab CI/CD", "Fastlane"]},
    {"category": "Integrations", "items": ["WeChat SDK", "Line SDK", "Firebase", "Payment Gateways (Cashfree, BillDesk)", "OAuth 2.0"]},
  ];
  
  static const List<Map<String, dynamic>> experience = [
    {
      "company": "Mindbowser Inc",
      "role": "Software Engineer",
      "duration": "August 2025 – Present",
      "location": "Pune, India",
      "projects": [
        {
          "name": "Kicksnap (Global AI-driven E-commerce)",
          "points": [
            "Engineered a multi-regional Flutter app localized for 8 languages across USA, Japan, and China.",
            "Architected Line (Japan) and WeChat (China) social logins for East Asian market entry.",
            "Implemented AI-driven Search by Image and AR Try-on features.",
            "Integrated AppsFlyer and optimized deep linking flows for user acquisition."
          ]
        },
        {
          "name": "Cascada (IoT Smart Waterer)",
          "points": [
            "Led migration of legacy Flutter code resolving Play Store compatibility issues.",
            "Migrated deprecated Firebase Dynamic Links to Native App Links."
          ]
        }
      ]
    },
    {
      "company": "Acme Infovision Systems Pvt. Ltd.",
      "role": "Software Developer",
      "duration": "June 2022 – August 2025",
      "location": "Satara, India",
      "projects": [
        {
          "name": "Jewello / Acme Padm",
          "points": [
            "Architected Core Microservices using Spring Boot & Clean Architecture Flutter frontend for a multi-tenant B2C ecosystem.",
            "Designed a custom 'Flavor' architecture allowing 30+ clients to deploy branded apps from a single codebase.",
            "Engineered high-performance RESTful APIs utilized by top-tier jewellery brands.",
            "Integrated Fastlane CI/CD pipeline and Android POS hardware (Worldline & BonusHub) with card swipe machines."
          ]
        }
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
    },
    {
      "title": "Microservices with Spring Boot & Spring Cloud",
      "year": "Udemy Certified",
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
