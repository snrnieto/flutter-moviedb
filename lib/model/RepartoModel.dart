class Reparto {
  String name;
  String profileURL;
  String job;

  Reparto({
    this.name,
    this.profileURL,
    this.job,
  });

  toJson() {
    return {
      "name": this.name,
      "profileURL": this.profileURL,
      "job": this.job,
    };
  }

  Reparto.fromMap(Map<String, dynamic> map) {
    this.name = map['name'];
    this.profileURL = map['profile_path'];
    this.job = map['job'];
  }
}
