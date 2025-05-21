// import 'dart:convert';

// class Profile {
//   final String id;
//   final int userId;
//   final String userType;
//   final String? avatar;
//   final String? profileLink;
//   final int freeEscrowTransactions;
//   final bool phoneNumberFlagged;
//   final String createdAt;
//   final String updatedAt;
//   final bool showTourGuide;
//   final DateTime lastLoginDate;
//   final bool isFlagged;
//   final bool isDeactivated;
//   final String? referralCode;
//   final int? referredBy;
//   final int unreadNotificationCount;
//   final String fullName;
//   final String phoneNumber;
//   final String email;
//   final List<dynamic> pendingEscrows;
//   final dynamic bankAccount;
//   final String? kyc;
//   final dynamic business;
//   final List<dynamic> bankAccounts;

//   Profile({
//     required this.id,
//     required this.userId,
//     required this.userType,
//     this.avatar,
//     this.profileLink,
//     required this.freeEscrowTransactions,
//     required this.phoneNumberFlagged,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.showTourGuide,
//     required this.lastLoginDate,
//     required this.isFlagged,
//     required this.isDeactivated,
//     this.referralCode,
//     this.referredBy,
//     required this.unreadNotificationCount,
//     required this.fullName,
//     required this.phoneNumber,
//     required this.email,
//     required this.pendingEscrows,
//     this.bankAccount,
//     this.kyc,
//     this.business,
//     required this.bankAccounts,
//   });

//   factory Profile.fromRawJson(String str) => Profile.fromMap(json.decode(str));

//   String toRawJson() => json.encode(toMap());

//   factory Profile.fromMap(Map<String, dynamic> json) => Profile(
//         id: json["id"],
//         userId: json["userId"],
//         userType: json["userType"],
//         avatar: json["avatar"],
//         profileLink: json["profileLink"],
//         freeEscrowTransactions: json["freeEscrowTransactions"],
//         phoneNumberFlagged: json["phoneNumberFlagged"],
//         createdAt: json["createdAt"],
//         updatedAt: json["updatedAt"],
//         showTourGuide: json["showTourGuide"],
//         lastLoginDate: json["lastLoginDate"],
//         isFlagged: json["isFlagged"],
//         isDeactivated: json["isDeactivated"],
//         referralCode: json["referralCode"],
//         referredBy: json["referredBy"],
//         unreadNotificationCount: json["unreadNotificationCount"],
//         fullName: json["fullName"],
//         phoneNumber: json["phoneNumber"],
//         email: json["email"],
//         pendingEscrows: [], //List<dynamic>.from(json["pendingEscrows"]),
//         bankAccount: json["bankAccount"],
//         kyc: json["kyc"],
//         business: json["business"],
//         bankAccounts: [], //List<dynamic>.from(json["bankAccounts"]),
//       );

//   Map<String, dynamic> toMap() => {
//         "id": id,
//         "userId": userId,
//         "userType": userType,
//         "avatar": avatar,
//         "profileLink": profileLink,
//         "freeEscrowTransactions": freeEscrowTransactions,
//         "phoneNumberFlagged": phoneNumberFlagged,
//         "createdAt": createdAt,
//         "updatedAt": updatedAt,
//         "showTourGuide": showTourGuide,
//         "lastLoginDate": lastLoginDate,
//         "isFlagged": isFlagged,
//         "isDeactivated": isDeactivated,
//         "referralCode": referralCode,
//         "referredBy": referredBy,
//         "unreadNotificationCount": unreadNotificationCount,
//         "fullName": fullName,
//         "phoneNumber": phoneNumber,
//         "email": email,
//         "pendingEscrows": pendingEscrows,
//         "bankAccount": bankAccount,
//         "kyc": kyc,
//         "business": business,
//         "bankAccounts": bankAccounts,
//       };

//   @override
//   String toString() {
//     return 'Profile(id: $id, userId: $userId, userType: $userType, avatar: $avatar, profileLink: $profileLink, freeEscrowTransactions: $freeEscrowTransactions, phoneNumberFlagged: $phoneNumberFlagged, createdAt: $createdAt, updatedAt: $updatedAt, showTourGuide: $showTourGuide, lastLoginDate: $lastLoginDate, isFlagged: $isFlagged, isDeactivated: $isDeactivated, referralCode: $referralCode, referredBy: $referredBy, unreadNotificationCount: $unreadNotificationCount, fullName: $fullName, phoneNumber: $phoneNumber, email: $email, pendingEscrows: $pendingEscrows, bankAccount: $bankAccount, kyc: $kyc, business: $business, bankAccounts: $bankAccounts)';
//   }
// }

class Profile {
  final String id;
  final int userId;
  final String userType;
  final String? avatar;
  final String? profileLink;
  final int freeEscrowTransactions;
  final bool phoneNumberFlagged;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool showTourGuide;
  final DateTime? lastLoginDate;
  final bool isFlagged;
  final bool isDeactivated;
  final String? referralCode;
  final String? referredBy;
  final int unreadNotificationCount;
  final String fullName;
  final String phoneNumber;
  final String email;
  final List<dynamic> pendingEscrows;
  final dynamic bankAccount;
  final dynamic kyc;
  final dynamic business;
  final List<dynamic> bankAccounts;

  Profile({
    required this.id,
    required this.userId,
    required this.userType,
    this.avatar,
    this.profileLink,
    required this.freeEscrowTransactions,
    required this.phoneNumberFlagged,
    required this.createdAt,
    required this.updatedAt,
    required this.showTourGuide,
    this.lastLoginDate,
    required this.isFlagged,
    required this.isDeactivated,
    this.referralCode,
    this.referredBy,
    required this.unreadNotificationCount,
    required this.fullName,
    required this.phoneNumber,
    required this.email,
    required this.pendingEscrows,
    this.bankAccount,
    this.kyc,
    this.business,
    required this.bankAccounts,
  });

  // Factory constructor to create instance from JSON
  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'] as String,
      userId: json['userId'] as int,
      userType: json['userType'] as String,
      avatar: json['avatar'] as String?,
      profileLink: json['profileLink'] as String?,
      freeEscrowTransactions: json['freeEscrowTransactions'] as int,
      phoneNumberFlagged: json['phoneNumberFlagged'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      showTourGuide: json['showTourGuide'] as bool,
      lastLoginDate: json['lastLoginDate'] != null
          ? DateTime.parse(json['lastLoginDate'] as String)
          : null,
      isFlagged: json['isFlagged'] as bool,
      isDeactivated: json['isDeactivated'] as bool,
      referralCode: json['referralCode'] as String?,
      referredBy: json['referredBy'] as String?,
      unreadNotificationCount: json['unreadNotificationCount'] as int,
      fullName: json['fullName'] as String,
      phoneNumber: json['phoneNumber'] as String,
      email: json['email'] as String,
      pendingEscrows: json['pendingEscrows'] as List<dynamic>,
      bankAccount: json['bankAccount'],
      kyc: json['kyc'],
      business: json['business'],
      bankAccounts: json['bankAccounts'] as List<dynamic>,
    );
  }

  // Method to convert instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'userType': userType,
      'avatar': avatar,
      'profileLink': profileLink,
      'freeEscrowTransactions': freeEscrowTransactions,
      'phoneNumberFlagged': phoneNumberFlagged,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'showTourGuide': showTourGuide,
      'lastLoginDate': lastLoginDate?.toIso8601String(),
      'isFlagged': isFlagged,
      'isDeactivated': isDeactivated,
      'referralCode': referralCode,
      'referredBy': referredBy,
      'unreadNotificationCount': unreadNotificationCount,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'email': email,
      'pendingEscrows': pendingEscrows,
      'bankAccount': bankAccount,
      'kyc': kyc,
      'business': business,
      'bankAccounts': bankAccounts,
    };
  }

  static const List<String> userTypes = [
    'BUYER',
    'SELLER',
    'MERCHANT',
    'CUSTOM'
  ];

  @override
  String toString() {
    return 'Profile(id: $id, userId: $userId, userType: $userType, avatar: $avatar, profileLink: $profileLink, freeEscrowTransactions: $freeEscrowTransactions, phoneNumberFlagged: $phoneNumberFlagged, createdAt: $createdAt, updatedAt: $updatedAt, showTourGuide: $showTourGuide, lastLoginDate: $lastLoginDate, isFlagged: $isFlagged, isDeactivated: $isDeactivated, referralCode: $referralCode, referredBy: $referredBy, unreadNotificationCount: $unreadNotificationCount, fullName: $fullName, phoneNumber: $phoneNumber, email: $email, pendingEscrows: $pendingEscrows, bankAccount: $bankAccount, kyc: $kyc, business: $business, bankAccounts: $bankAccounts)';
  }
}
