class JobPostsResponse {
  final String title;
  final Category category;
  final String description;
  final String location;
  final String companyName;
  final String jobType;
  final List<JobRequirement> jobRequirements;
  final List<Qualification> qualifications;
  final String dateline;
  final String status;
  final int numApplicants;
  final DateTime postedAt;
  final String id;

  JobPostsResponse({
    required this.title,
    required this.category,
    required this.description,
    required this.location,
    required this.companyName,
    required this.jobType,
    required this.jobRequirements,
    required this.qualifications,
    required this.dateline,
    required this.status,
    required this.numApplicants,
    required this.postedAt,

    required this.id,
  });

  factory JobPostsResponse.fromJson(Map<String, dynamic> json) {
    return JobPostsResponse(
      title: json['title'],
      category: Category.fromJson(json['category']),
      description: json['description'],
      location: json['location'],
      companyName: json['company_name'],
      jobType: json['job_type'],
      jobRequirements: (json['job_requirements'] as List)
          .map((e) => JobRequirement.fromJson(e))
          .toList(),
      qualifications: (json['qualifications'] as List)
          .map((e) => Qualification.fromJson(e))
          .toList(),
      dateline: json['dateline'],
      status: json['status'],
      numApplicants: json['numApplicants'],
      postedAt: DateTime.parse(json['posted_at']),

      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'category': category.toJson(),
      'description': description,
      'location': location,
      'company_name': companyName,
      'job_type': jobType,
      'job_requirements': jobRequirements.map((e) => e.toJson()).toList(),
      'qualifications': qualifications.map((e) => e.toJson()).toList(),
      'dateline': dateline,
      'status': status,
      'numApplicants': numApplicants,
      'posted_at': postedAt.toIso8601String(),
      'id': id,
    };
  }
}

class Category {
  final String category;
  final String description;
  final ImageData image;
  final List<String> subCategories;
  final String id;

  Category({
    required this.category,
    required this.description,
    required this.image,
    required this.subCategories,
    required this.id,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      category: json['category'],
      description: json['description'],
      image: ImageData.fromJson(json['image']),
      subCategories: List<String>.from(json['subCategories']),
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'description': description,
      'image': image.toJson(),
      'subCategories': subCategories,
      'id': id,
    };
  }
}

class ImageData {
  final String url;
  final String path;

  ImageData({required this.url, required this.path});

  factory ImageData.fromJson(Map<String, dynamic> json) {
    return ImageData(
      url: json['url'],
      path: json['path'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'path': path,
    };
  }
}

class JobRequirement {
  final String requirement;
  final String id;

  JobRequirement({required this.requirement, required this.id});

  factory JobRequirement.fromJson(Map<String, dynamic> json) {
    return JobRequirement(
      requirement: json['requirement'],
      id: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'requirement': requirement,
      '_id': id,
    };
  }
}

class Qualification {
  final String qualification;
  final String id;

  Qualification({required this.qualification, required this.id});

  factory Qualification.fromJson(Map<String, dynamic> json) {
    return Qualification(
      qualification: json['qualification'],
      id: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'qualification': qualification,
      '_id': id,
    };
  }
}
