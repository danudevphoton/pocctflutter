class FormValidation {
  String emptyValidation(String value) {
    if (value == null || value.isEmpty) return '';
    return null;
  }

  String emailValidation(String value) {
    var regExp = RegExp(r'^[\w\-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (value == null || value.isEmpty) return '';
    if (!regExp.hasMatch(value)) return '';
    return null;
  }
}
