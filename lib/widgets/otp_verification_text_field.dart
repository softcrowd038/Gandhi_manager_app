import 'package:gandhi_tvs/common/app_imports.dart';

class OtpVerificationField extends HookWidget {
  final int otpLength;
  final Function(String) onChanged;

  const OtpVerificationField({
    super.key,
    this.otpLength = 8,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final controllers = useState<List<TextEditingController>>(
      List.generate(otpLength, (_) => TextEditingController()),
    );
    final focusNodes = useState<List<FocusNode>>(
      List.generate(otpLength, (_) => FocusNode()),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(otpLength, (index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: SizedBox(
            width: 40.0,
            child: TextFormField(
              controller: controllers.value[index],
              focusNode: focusNodes.value[index],
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, color: Colors.black),
              decoration: InputDecoration(
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
                counterText: '',
              ),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(1),
              ],
              maxLength: 1,
              onChanged: (value) {
                onChanged(value);

                if (value.isNotEmpty && index < otpLength - 1) {
                  FocusScope.of(
                    context,
                  ).requestFocus(focusNodes.value[index + 1]);
                }

                if (value.isEmpty && index > 0) {
                  FocusScope.of(
                    context,
                  ).requestFocus(focusNodes.value[index - 1]);
                }
              },
            ),
          ),
        );
      }),
    );
  }
}
