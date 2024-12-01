class Validators {
  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password is required';
    }

    if (password.length > 15) {
      return 'Password is too long, max 15 characters';
    } else if (password.length < 8) {
      return 'Password is too short, need at least 8 characters';
    }

    // Kiểm tra mật khẩu mạnh
    RegExp strongRegex = RegExp(
        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@.#$!%*?&])[A-Za-z\d@.#$!^%*?&]{8,15}$');
    if (strongRegex.hasMatch(password)) {
      return null; // Mật khẩu hợp lệ
    }

    // Kiểm tra mức độ mạnh nếu không phải mật khẩu mạnh
    int count = 0;

    if (RegExp(r'[a-z]').hasMatch(password)) count++; // Chứa chữ thường
    if (RegExp(r'[A-Z]').hasMatch(password)) count++; // Chứa chữ hoa
    if (RegExp(r'\d').hasMatch(password)) count++; // Chứa số
    if (RegExp(r'[!@#$%^&*.?]').hasMatch(password))
      count++; // Chứa ký tự đặc biệt

    // Định nghĩa mức độ mạnh của mật khẩu
    Map<int, String> strength = {
      1: "Very weak",
      2: "Weak",
      3: "Average",
      4: "Strong",
    };

    // Nếu mật khẩu không hợp lệ
    return 'Password is invalid. Strength: ${strength[count] ?? "Undefined"}';
  }

  // Hàm validate email
  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email is required';
    }
    RegExp emailRegex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|.(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if (!emailRegex.hasMatch(email)) {
      return 'Email is invalid';
    }
    return null; // trả về null nếu không có lỗi
  }
}
