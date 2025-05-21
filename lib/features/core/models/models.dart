import 'dart:convert';

class UserModel {
  final String id;
  final int userId;
  final String userType;
  final String? avatar;
  final String? profileLink;
  final int freeEscrowTransactions;
  final bool phoneNumberFlagged;
  final String createdAt;
  final String updatedAt;
  final bool showTourGuide;
  final String? lastLoginDate;
  final bool isFlagged;
  final bool isDeactivated;
  final String? referralCode;
  final int? referredBy;
  final int unreadNotificationCount;
  final String fullName;
  final String phoneNumber;
  final String email;
  final List<dynamic> pendingEscrows;
  final dynamic bankAccount;
  final dynamic kyc;
  final dynamic business;
  final List<dynamic> bankAccounts;

  UserModel({
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

  factory UserModel.fromRawJson(String str) => UserModel.fromMap(json.decode(str));

  String toRawJson() => json.encode(toMap());

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        userId: json["userId"],
        userType: json["userType"],
        avatar: json["avatar"],
        profileLink: json["profileLink"],
        freeEscrowTransactions: json["freeEscrowTransactions"],
        phoneNumberFlagged: json["phoneNumberFlagged"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        showTourGuide: json["showTourGuide"],
        lastLoginDate: json["lastLoginDate"],
        isFlagged: json["isFlagged"],
        isDeactivated: json["isDeactivated"],
        referralCode: json["referralCode"],
        referredBy: json["referredBy"],
        unreadNotificationCount: json["unreadNotificationCount"],
        fullName: json["fullName"],
        phoneNumber: json["phoneNumber"],
        email: json["email"],
        pendingEscrows: List<dynamic>.from(json["pendingEscrows"] ?? []),
        bankAccount: json["bankAccount"],
        kyc: json["kyc"],
        business: json["business"],
        bankAccounts: List<dynamic>.from(json["bankAccounts"] ?? []),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "userId": userId,
        "userType": userType,
        "avatar": avatar,
        "profileLink": profileLink,
        "freeEscrowTransactions": freeEscrowTransactions,
        "phoneNumberFlagged": phoneNumberFlagged,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "showTourGuide": showTourGuide,
        "lastLoginDate": lastLoginDate,
        "isFlagged": isFlagged,
        "isDeactivated": isDeactivated,
        "referralCode": referralCode,
        "referredBy": referredBy,
        "unreadNotificationCount": unreadNotificationCount,
        "fullName": fullName,
        "phoneNumber": phoneNumber,
        "email": email,
        "pendingEscrows": pendingEscrows,
        "bankAccount": bankAccount,
        "kyc": kyc,
        "business": business,
        "bankAccounts": bankAccounts,
      };
}
