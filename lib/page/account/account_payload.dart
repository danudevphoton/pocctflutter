import '../../model/customer_model.dart';

class AccountPayload {
  Map _constructPayload(int csVersion, List actions) => {
        "version": csVersion,
        "actions": actions,
      };

  Map addAddress(int csVersion, Addresses address) {
    var actions = [
      {"action": "addAddress", "address": address.toJson()}
    ];
    return _constructPayload(csVersion, actions);
  }

  Map changeAddress(int csVersion, Addresses address) {
    var actions = [
      {
        "action": "changeAddress",
        "addressId": address.id,
        "address": address.toJson()
      }
    ];
    return _constructPayload(csVersion, actions);
  }

  Map removeAddress(int csVersion, String addressId) {
    var actions = [
      {"action": "removeAddress", "addressId": addressId}
    ];
    return _constructPayload(csVersion, actions);
  }

  Map setDefaultAddress(int csVersion, String addressId) {
    var actions = [
      {"action": "setDefaultShippingAddress", "addressId": addressId},
      {"action": "setDefaultBillingAddress", "addressId": addressId}
    ];
    return _constructPayload(csVersion, actions);
  }

  Map changeName(
      int csVersion, String firstName, String middleName, String lastName) {
    var actions = [
      {"action": "setFirstName", "firstName": firstName},
      {"action": "setMiddleName", "middleName": middleName},
      {"action": "setLastName", "lastName": lastName}
    ];
    return _constructPayload(csVersion, actions);
  }

  Map changeEmail(int csVersion, String newEmail) {
    var actions = [
      {"action": "changeEmail", "email": newEmail}
    ];
    return _constructPayload(csVersion, actions);
  }

  Map createVerifyEmailToken(String csId, int csVersion) =>
      {"id": csId, "version": csVersion, "ttlMinutes": 1};

  Map verifiesEmail(int csVersion, String tokenValue) =>
      {"version": csVersion, "tokenValue": tokenValue};
}
