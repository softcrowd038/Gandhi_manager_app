class Validators {
  static String? requiredField(String? value,
      {String fieldName = "This field"}) {
    if (value == null || value.isEmpty) {
      return 'Please enter $fieldName';
    }
    return null;
  }

  static String? pincode(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter pincode';
    } else if (!RegExp(r'^\d{6}$').hasMatch(value)) {
      return 'Pincode must be 6 digits';
    }
    return null;
  }

  static String? mobileNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter mobile number';
    } else if (!RegExp(r'^[6-9][0-9]{9}$').hasMatch(value)) {
      return 'Enter valid 10 digit mobile number';
    }
    return null;
  }

  static String? aadhaarNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter Aadhaar number';
    } else if (!RegExp(r'^\d{12}$').hasMatch(value)) {
      return 'Enter valid 12 digit Aadhaar number';
    }
    return null;
  }

  static String? panNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter PAN number';
    } else if (!RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]$')
        .hasMatch(value.toUpperCase())) {
      return 'Enter valid PAN number';
    }
    return null;
  }

  static String? age(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter age';
    }
    final parsed = int.tryParse(value);
    if (parsed == null || parsed <= 0 || parsed >= 100) {
      return 'Enter valid age';
    }
    return null;
  }
}
