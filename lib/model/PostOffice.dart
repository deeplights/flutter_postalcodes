class PostOffice {
  final String name;
  final String pinCode;
  final String branchType;
  final String district;

  PostOffice({this.name, this.pinCode, this.branchType, this.district});

  factory PostOffice.fromJson(Map<String, dynamic> json) {
    return PostOffice(
      name: json['Name'],
      pinCode: json['Pincode'],
      branchType: json['BranchType'],
      district: json['District']
    );
  }
}