class CustomerModel {
  String id;
  int version;
  int lastMessageSequenceNumber;
  String createdAt;
  String lastModifiedAt;
  LastModifiedBy lastModifiedBy;
  LastModifiedBy createdBy;
  String email;
  String firstName;
  String lastName;
  String middleName;
  String title;
  String salutation;
  String dateOfBirth;
  String password;
  List<Addresses> addresses;
  String defaultShippingAddressId;
  String defaultBillingAddressId;
  List<String> shippingAddressIds;
  List<String> billingAddressIds;
  bool isEmailVerified;

  CustomerModel(
      {this.id,
      this.version,
      this.lastMessageSequenceNumber,
      this.createdAt,
      this.lastModifiedAt,
      this.lastModifiedBy,
      this.createdBy,
      this.email,
      this.firstName,
      this.lastName,
      this.middleName,
      this.title,
      this.salutation,
      this.dateOfBirth,
      this.password,
      this.addresses,
      this.defaultShippingAddressId,
      this.defaultBillingAddressId,
      this.shippingAddressIds,
      this.billingAddressIds,
      this.isEmailVerified});

  CustomerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    version = json['version'];
    lastMessageSequenceNumber = json['lastMessageSequenceNumber'];
    createdAt = json['createdAt'];
    lastModifiedAt = json['lastModifiedAt'];
    lastModifiedBy = json['lastModifiedBy'] != null
        ? new LastModifiedBy.fromJson(json['lastModifiedBy'])
        : null;
    createdBy = json['createdBy'] != null
        ? new LastModifiedBy.fromJson(json['createdBy'])
        : null;
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    middleName = json['middleName'];
    title = json['title'];
    salutation = json['salutation'];
    dateOfBirth = json['dateOfBirth'];
    password = json['password'];
    if (json['addresses'] != null) {
      addresses = new List<Addresses>();
      json['addresses'].forEach((v) {
        addresses.add(new Addresses.fromJson(v));
      });
    }
    defaultShippingAddressId = json['defaultShippingAddressId'];
    defaultBillingAddressId = json['defaultBillingAddressId'];
    shippingAddressIds = json['shippingAddressIds'].cast<String>();
    billingAddressIds = json['billingAddressIds'].cast<String>();
    isEmailVerified = json['isEmailVerified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['version'] = this.version;
    data['lastMessageSequenceNumber'] = this.lastMessageSequenceNumber;
    data['createdAt'] = this.createdAt;
    data['lastModifiedAt'] = this.lastModifiedAt;
    if (this.lastModifiedBy != null) {
      data['lastModifiedBy'] = this.lastModifiedBy.toJson();
    }
    if (this.createdBy != null) {
      data['createdBy'] = this.createdBy.toJson();
    }
    data['email'] = this.email;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['middleName'] = this.middleName;
    data['title'] = this.title;
    data['salutation'] = this.salutation;
    data['dateOfBirth'] = this.dateOfBirth;
    data['password'] = this.password;
    if (this.addresses != null) {
      data['addresses'] = this.addresses.map((v) => v.toJson()).toList();
    }
    data['defaultShippingAddressId'] = this.defaultShippingAddressId;
    data['defaultBillingAddressId'] = this.defaultBillingAddressId;
    data['shippingAddressIds'] = this.shippingAddressIds;
    data['billingAddressIds'] = this.billingAddressIds;
    data['isEmailVerified'] = this.isEmailVerified;
    return data;
  }
}

class LastModifiedBy {
  bool isPlatformClient;
  User user;

  LastModifiedBy({this.isPlatformClient, this.user});

  LastModifiedBy.fromJson(Map<String, dynamic> json) {
    isPlatformClient = json['isPlatformClient'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isPlatformClient'] = this.isPlatformClient;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

class User {
  String typeId;
  String id;

  User({this.typeId, this.id});

  User.fromJson(Map<String, dynamic> json) {
    typeId = json['typeId'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['typeId'] = this.typeId;
    data['id'] = this.id;
    return data;
  }
}

class Addresses {
  String id;
  String title;
  String salutation;
  String firstName;
  String lastName;
  String streetName;
  String streetNumber;
  String postalCode;
  String city;
  String region;
  String state;
  String country;
  String phone;
  String mobile;
  String email;
  String additionalAddressInfo;

  Addresses(
      {this.id,
      this.title,
      this.salutation,
      this.firstName,
      this.lastName,
      this.streetName,
      this.streetNumber,
      this.postalCode,
      this.city,
      this.region,
      this.state,
      this.country,
      this.phone,
      this.mobile,
      this.email,
      this.additionalAddressInfo});

  Addresses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    salutation = json['salutation'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    streetName = json['streetName'];
    streetNumber = json['streetNumber'];
    postalCode = json['postalCode'];
    city = json['city'];
    region = json['region'];
    state = json['state'];
    country = json['country'];
    phone = json['phone'];
    mobile = json['mobile'];
    email = json['email'];
    additionalAddressInfo = json['additionalAddressInfo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['salutation'] = this.salutation;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['streetName'] = this.streetName;
    data['streetNumber'] = this.streetNumber;
    data['postalCode'] = this.postalCode;
    data['city'] = this.city;
    data['region'] = this.region;
    data['state'] = this.state;
    data['country'] = this.country;
    data['phone'] = this.phone;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['additionalAddressInfo'] = this.additionalAddressInfo;
    return data;
  }
}
