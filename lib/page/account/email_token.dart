class EmailToken {
  String id;
  String createdAt;
  String lastModifiedAt;
  LastModifiedBy lastModifiedBy;
  LastModifiedBy createdBy;
  String customerId;
  String expiresAt;
  String value;

  EmailToken(
      {this.id,
      this.createdAt,
      this.lastModifiedAt,
      this.lastModifiedBy,
      this.createdBy,
      this.customerId,
      this.expiresAt,
      this.value});

  EmailToken.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    lastModifiedAt = json['lastModifiedAt'];
    lastModifiedBy = json['lastModifiedBy'] != null
        ? new LastModifiedBy.fromJson(json['lastModifiedBy'])
        : null;
    createdBy = json['createdBy'] != null
        ? new LastModifiedBy.fromJson(json['createdBy'])
        : null;
    customerId = json['customerId'];
    expiresAt = json['expiresAt'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createdAt'] = this.createdAt;
    data['lastModifiedAt'] = this.lastModifiedAt;
    if (this.lastModifiedBy != null) {
      data['lastModifiedBy'] = this.lastModifiedBy.toJson();
    }
    if (this.createdBy != null) {
      data['createdBy'] = this.createdBy.toJson();
    }
    data['customerId'] = this.customerId;
    data['expiresAt'] = this.expiresAt;
    data['value'] = this.value;
    return data;
  }
}

class LastModifiedBy {
  String clientId;
  bool isPlatformClient;

  LastModifiedBy({this.clientId, this.isPlatformClient});

  LastModifiedBy.fromJson(Map<String, dynamic> json) {
    clientId = json['clientId'];
    isPlatformClient = json['isPlatformClient'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['clientId'] = this.clientId;
    data['isPlatformClient'] = this.isPlatformClient;
    return data;
  }
}
