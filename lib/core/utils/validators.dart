class Validator {
  static String? nameValidator(String? value) {
    if (value == null) return 'Name cannot be empty';
    if (!RegExp("^[a-zA-Z ]+\$").hasMatch(value)) {
      return "Only alphabets and spaces are allowed in the Name field";
    }
    return null;
  }

  static bool isNameValid(String? value) {
    return nameValidator(value) == null;
  }

  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) return 'Email cannot be empty';
    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  static bool isEmailValid(String? value) {
    return emailValidator(value) == null;
  }

  static String? phoneValidator(String? value) {
    if (value == null || value.isEmpty) return 'Phone number cannot be empty';
    if (!RegExp(
            r'^(?:\234|0)?(?:70|80|81|90|91|701|702|703|704|705|706|707|708|709|802|803|804|805|806|807|808|809|810|811|812|813|814|815|816|817|818|819|901|902|903|904|905|906|907|908|909|910|911|912)\d{7}$')
        .hasMatch(value)) {
      return 'Please enter a valid Nigerian phone number';
    }
    return null;
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) return 'Password cannot be empty';
    if (value.length < 8) return 'Password must be at least 8 characters long';
    if (!RegExp(r'(?=.*[A-Z])').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!RegExp(r'(?=.*[a-z])').hasMatch(value)) {
      return 'Password must contain at least one lowercase letter';
    }
    if (!RegExp(r'(?=.*\d)').hasMatch(value)) {
      return 'Password must contain at least one digit';
    }
    if (!RegExp(r'(?=.*[!@#\$&*~])').hasMatch(value)) {
      return 'Password must contain at least one special character';
    }
    return null;
  }

  static String? confirmPasswordValidator(String? value, String? password) {
    if (value == null || value.isEmpty) {
      return 'Confirm password cannot be empty';
    }
    if (value != password) return 'Passwords do not match';
    return null;
  }

  static String? confirmPhoneValidator(String? value, String? phone) {
    if (value == null || value.isEmpty) {
      return 'Confirm phone number cannot be empty';
    }
    if (value != phone) return 'Phone numbers do not match';
    return null;
  }

  static String? ageValidator(String? value) {
    if (value == null || value.isEmpty) return 'Age cannot be empty';
    if (int.tryParse(value) == null) return 'Please enter a valid number';
    return null;
  }

  static String? notEmptyValidator(String? value) {
    if (value == null || value.isEmpty) return 'Field cannot be empty';
    return null;
  }
}
