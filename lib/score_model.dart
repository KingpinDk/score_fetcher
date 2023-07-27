
class ScoreModel {
  bool? status;
  List<Models>? models;
  int? version;

  ScoreModel({this.status, this.models, this.version});

  ScoreModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['models'] != null) {
      models = <Models>[];
      json['models'].forEach((v) {
        models!.add(new Models.fromJson(v));
      });
    }
    version = json['version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.models != null) {
      data['models'] = this.models!.map((v) => v.toJson()).toList();
    }
    data['version'] = this.version;
    return data;
  }
}

class Models {
  String? badgeCategory;
  String? badgeType;
  String? categoryName;
  String? badgeName;
  String? badgeShortName;
  int? totalStars;
  int? totalPoints;
  String? url;
  int? solved;
  int? totalChallenges;
  int? trackTotalScore;
  int? hackerRank;
  int? stars;
  int? level;
  double? currentPoints;
  double? progressToNextStar;
  String? upcomingLevel;

  Models(
      {this.badgeCategory,
        this.badgeType,
        this.categoryName,
        this.badgeName,
        this.badgeShortName,
        this.totalStars,
        this.totalPoints,
        this.url,
        this.solved,
        this.totalChallenges,
        this.trackTotalScore,
        this.hackerRank,
        this.stars,
        this.level,
        this.currentPoints,
        this.progressToNextStar,
        this.upcomingLevel});

  Models.fromJson(Map<String, dynamic> json) {
    badgeCategory = json['badge_category'];
    badgeType = json['badge_type'];
    categoryName = json['category_name'];
    badgeName = json['badge_name'];
    badgeShortName = json['badge_short_name'];
    totalStars = json['total_stars'];
    totalPoints = json['total_points'];
    url = json['url'];
    solved = json['solved'];
    totalChallenges = json['total_challenges'];
    trackTotalScore = json['track_total_score'];
    hackerRank = json['hacker_rank'];
    stars = json['stars'];
    level = json['level'];
    currentPoints = json['current_points'];
    progressToNextStar = json['progress_to_next_star'];
    upcomingLevel = json['upcoming_level'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['badge_category'] = this.badgeCategory;
    data['badge_type'] = this.badgeType;
    data['category_name'] = this.categoryName;
    data['badge_name'] = this.badgeName;
    data['badge_short_name'] = this.badgeShortName;
    data['total_stars'] = this.totalStars;
    data['total_points'] = this.totalPoints;
    data['url'] = this.url;
    data['solved'] = this.solved;
    data['total_challenges'] = this.totalChallenges;
    data['track_total_score'] = this.trackTotalScore;
    data['hacker_rank'] = this.hackerRank;
    data['stars'] = this.stars;
    data['level'] = this.level;
    data['current_points'] = this.currentPoints;
    data['progress_to_next_star'] = this.progressToNextStar;
    data['upcoming_level'] = this.upcomingLevel;
    return data;
  }
}