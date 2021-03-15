class AccountUtils {
  AccountUtils._();

  static String _monthNamed(int index) {
    List<String> list = [
      'January',
      'February',
      'March',
      'May',
      'April',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return list[index - 1];
  }

  static String dateBirthFormatter(String src) {
    var splitSrc = src.split('-');
    var mNamed = _monthNamed(int.parse(splitSrc[1]));
    var result = '${splitSrc[2]} ${mNamed} ${splitSrc[0]}';
    return titleCase(result);
  }

  static String titleCase(String src) {
    var result = '';
    var splited = src.split(' ');
    for (var e in splited) {
      result += '${e[0].toUpperCase()}${e.substring(1)} ';
    }

    return result.trim();
  }

  static String phoneFormater(String src, [String locale]) {
    if (src == null || src.isEmpty) return '';
    var result = '';
    if (src.length > 10) {
      for (var i = 0; i < src.length; i++) {
        result += src[i];
        if (i == 3 || i == 7) {
          result += '-';
        }
      }
    } else {
      var first = src?.substring(0, 4) ?? '';
      var middle = src?.substring(4, 7) ?? '';
      var last = src?.substring(7) ?? '';
      result = '+1 ($first) $middle-$last';
    }

    return result.trim();
  }
}
