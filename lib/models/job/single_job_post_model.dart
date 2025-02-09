class JobPostResponse {
  final int code;
  final String message;
  final JobPostData data;

  JobPostResponse({
    required this.code,
    required this.message,
    required this.data,
  });

  factory JobPostResponse.fromJson(Map<String, dynamic> json) {
    return JobPostResponse(
      code: json['code'],
      message: json['message'],
      data: JobPostData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message,
      'data': data.toJson(),
    };
  }
}

class JobPostData {
  final JobPostAttributes attributes;

  JobPostData({
    required this.attributes,
  });

  factory JobPostData.fromJson(Map<String, dynamic> json) {
    return JobPostData(
      attributes: JobPostAttributes.fromJson(json['attributes']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'attributes': attributes.toJson(),
    };
  }
}

class JobPostAttributes {
  final String title;
  final String description;
  final int? salary;
  final String location;
  final String companyName;
  final String jobType;
  final String category;
  final List<JobRequirement> jobRequirements;
  final List<JobQualification> qualifications;
  final DateTime postedAt;
  final String id;

  JobPostAttributes({
    required this.title,
    required this.description,
     this.salary,
    required this.location,
    required this.companyName,
    required this.jobType,
    required this.category,
    required this.jobRequirements,
    required this.qualifications,
    required this.postedAt,
    required this.id,
  });

  factory JobPostAttributes.fromJson(Map<String, dynamic> json) {
    return JobPostAttributes(
      title: json['title'],
      description: json['description'],
      salary: json['salary'],
      location: json['location'],
      companyName: json['company_name'],
      jobType: json['job_type'],
      category: json['category'],
      jobRequirements: List<JobRequirement>.from(
          json['job_requirements'].map((x) => JobRequirement.fromJson(x))),
      qualifications: List<JobQualification>.from(
          json['qualifications'].map((x) => JobQualification.fromJson(x))),
      postedAt: DateTime.parse(json['posted_at']),
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'salary': salary,
      'location': location,
      'company_name': companyName,
      'job_type': jobType,
      'category': category,
      'job_requirements': jobRequirements.map((x) => x.toJson()).toList(),
      'qualifications': qualifications.map((x) => x.toJson()).toList(),
      'posted_at': postedAt.toIso8601String(),
      'id': id,
    };
  }
}

class JobRequirement {
  final String requirement;
  final String id;

  JobRequirement({
    required this.requirement,
    required this.id,
  });

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

class JobQualification {
  final String qualification;
  final String id;

  JobQualification({
    required this.qualification,
    required this.id,
  });

  factory JobQualification.fromJson(Map<String, dynamic> json) {
    return JobQualification(
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
