class PostOffice {
  final String name;
  final String pinCode;
  final String branchType;
  final String district;
  final String division;
  final String state;
  final String region;
  final String circle;

  PostOffice({this.name, this.pinCode, this.branchType, this.district, this.division, this.state, this.region, this.circle});

  factory PostOffice.fromJson(Map<String, dynamic> json) {
    return PostOffice(
      name: json['Name'],
      pinCode: json['Pincode'],
      branchType: json['BranchType'],
      district: json['District'],
      division: json['Division'],
      state: json['State'],
      region: json['Region'],
      circle: json['Circle']
    );
  }
}