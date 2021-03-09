import 'dart:convert';

ProjectModel projectModelFromJson(String str) =>
    ProjectModel.fromJson(json.decode(str));

String projectModelToJson(ProjectModel data) => json.encode(data.toJson());

class ProjectModel {
  ProjectModel({
    this.key,
    this.name,
    this.countries,
    this.currencies,
    this.languages,
    this.createdAt,
    this.trialUntil,
    this.messages,
    this.carts,
    this.shoppingLists,
    this.version,
  });

  String key;
  String name;
  List<String> countries;
  List<String> currencies;
  List<String> languages;
  DateTime createdAt;
  String trialUntil;
  Messages messages;
  Carts carts;
  ShoppingLists shoppingLists;
  int version;

  factory ProjectModel.fromJson(Map<String, dynamic> json) => ProjectModel(
        key: json["key"],
        name: json["name"],
        countries: List<String>.from(json["countries"].map((x) => x)),
        currencies: List<String>.from(json["currencies"].map((x) => x)),
        languages: List<String>.from(json["languages"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        trialUntil: json["trialUntil"],
        messages: Messages.fromJson(json["messages"]),
        carts: Carts.fromJson(json["carts"]),
        shoppingLists: ShoppingLists.fromJson(json["shoppingLists"]),
        version: json["version"],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "name": name,
        "countries": List<dynamic>.from(countries.map((x) => x)),
        "currencies": List<dynamic>.from(currencies.map((x) => x)),
        "languages": List<dynamic>.from(languages.map((x) => x)),
        "createdAt": createdAt.toIso8601String(),
        "trialUntil": trialUntil,
        "messages": messages.toJson(),
        "carts": carts.toJson(),
        "shoppingLists": shoppingLists.toJson(),
        "version": version,
      };
}

class Carts {
  Carts({
    this.deleteDaysAfterLastModification,
    this.allowAddingUnpublishedProducts,
    this.countryTaxRateFallbackEnabled,
  });

  int deleteDaysAfterLastModification;
  bool allowAddingUnpublishedProducts;
  bool countryTaxRateFallbackEnabled;

  factory Carts.fromJson(Map<String, dynamic> json) => Carts(
        deleteDaysAfterLastModification:
            json["deleteDaysAfterLastModification"],
        allowAddingUnpublishedProducts: json["allowAddingUnpublishedProducts"],
        countryTaxRateFallbackEnabled: json["countryTaxRateFallbackEnabled"],
      );

  Map<String, dynamic> toJson() => {
        "deleteDaysAfterLastModification": deleteDaysAfterLastModification,
        "allowAddingUnpublishedProducts": allowAddingUnpublishedProducts,
        "countryTaxRateFallbackEnabled": countryTaxRateFallbackEnabled,
      };
}

class Messages {
  Messages({
    this.enabled,
    this.deleteDaysAfterCreation,
  });

  bool enabled;
  int deleteDaysAfterCreation;

  factory Messages.fromJson(Map<String, dynamic> json) => Messages(
        enabled: json["enabled"],
        deleteDaysAfterCreation: json["deleteDaysAfterCreation"],
      );

  Map<String, dynamic> toJson() => {
        "enabled": enabled,
        "deleteDaysAfterCreation": deleteDaysAfterCreation,
      };
}

class ShoppingLists {
  ShoppingLists({
    this.deleteDaysAfterLastModification,
  });

  int deleteDaysAfterLastModification;

  factory ShoppingLists.fromJson(Map<String, dynamic> json) => ShoppingLists(
        deleteDaysAfterLastModification:
            json["deleteDaysAfterLastModification"],
      );

  Map<String, dynamic> toJson() => {
        "deleteDaysAfterLastModification": deleteDaysAfterLastModification,
      };
}
