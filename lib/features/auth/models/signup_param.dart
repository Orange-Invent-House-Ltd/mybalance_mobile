import 'dart:convert';

class SignupParam {
    String? firstName;
    String? lastName;
    String? email;
    String? phone;
    String? password;
    String? businessName;
    String? businessDescription;
    String? address;
    String? bankName;
    String? bankCode;
    String? accountNumber;
    String? accountName;
    String? referrer;
    String? referralCode;

    SignupParam({
        this.firstName,
        this.lastName,
        this.email,
        this.phone,
        this.password,
        this.businessName,
        this.businessDescription,
        this.address,
        this.bankName,
        this.bankCode,
        this.accountNumber,
        this.accountName,
        this.referrer,
        this.referralCode,
    });

    SignupParam copyWith({
        String? firstName,
        String? lastName,
        String? email,
        String? phone,
        String? password,
        String? businessName,
        String? businessDescription,
        String? address,
        String? bankName,
        String? bankCode,
        String? accountNumber,
        String? accountName,
        String? referrer,
        String? referralCode,
    }) => 
        SignupParam(
            firstName: firstName ?? this.firstName,
            lastName: lastName ?? this.lastName,
            email: email ?? this.email,
            phone: phone ?? this.phone,
            password: password ?? this.password,
            businessName: businessName ?? this.businessName,
            businessDescription: businessDescription ?? this.businessDescription,
            address: address ?? this.address,
            bankName: bankName ?? this.bankName,
            bankCode: bankCode ?? this.bankCode,
            accountNumber: accountNumber ?? this.accountNumber,
            accountName: accountName ?? this.accountName,
            referrer: referrer ?? this.referrer,
            referralCode: referralCode ?? this.referralCode,
        );

    factory SignupParam.fromRawJson(String str) => SignupParam.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory SignupParam.fromJson(Map<String, dynamic> json) => SignupParam(
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        phone: json["phone"],
        password: json["password"],
        businessName: json["businessName"],
        businessDescription: json["businessDescription"],
        address: json["address"],
        bankName: json["bankName"],
        bankCode: json["bankCode"],
        accountNumber: json["accountNumber"],
        accountName: json["accountName"],
        referrer: json["referrer"],
        referralCode: json["referralCode"],
    );

    Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "phone": phone,
        "password": password,
        "businessName": businessName,
        "businessDescription": businessDescription,
        "address": address,
        "bankName": bankName,
        "bankCode": bankCode,
        "accountNumber": accountNumber,
        "accountName": accountName,
        "referrer": referrer,
        "referralCode": referralCode,
    };
}
