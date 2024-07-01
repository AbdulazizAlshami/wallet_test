import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:smart_auth/smart_auth.dart';

import '../transactionScreens/transactionScreen.dart';


class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  late final SmsRetriever smsRetriever;
  late final TextEditingController pinController;
  late final FocusNode focusNode;
  late final GlobalKey<FormState> formKey;
  Timer? countdownTimer;
  Duration myDuration = const Duration(minutes: 5);

  void startTimer() {
    myDuration = const Duration(minutes: 5);
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
    if (!countdownTimer!.isActive) {
      setState(() {
        countDownComplete = true;
      });
    }
  }

  bool countDownComplete = false;
  bool resend = false;


  void setCountDown() {
    final reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countDownComplete = true;
        countdownTimer!.cancel();
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }
  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    pinController = TextEditingController();
    focusNode = FocusNode();
    startTimer();
    setState(() {
      if (resend == true) {
        startTimer();
      }
    });
    smsRetriever = SmsRetrieverImpl(
      SmartAuth(),
    );
  }

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = strDigits(myDuration.inMinutes.remainder(60));
    final seconds = strDigits(myDuration.inSeconds.remainder(60));

    const fillColor = Color.fromRGBO(192, 192, 192,0.9);

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        color:Colors.black,
        fontWeight: FontWeight.bold
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
       // border: Border.all(color: borderColor),
      ),
    );
    return Scaffold(
      body: Center(
        child: Form(
          key: formKey,
          child: Column(
           // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(height: 120,),
              const Directionality(
                  textDirection: TextDirection.rtl,
                  child: Text("التسجيل بإستخدام OTP", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26, color: Colors.black),)),
              const SizedBox(height: 16,),
              const Text("   لقد أرسلنا لك كود على رقمك 775553281 ", style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16, color: Colors.black),),
              const SizedBox(height: 30,),
              Directionality(
                textDirection: TextDirection.ltr,
                child: Pinput(
                  keyboardType: TextInputType.number,
                  smsRetriever: smsRetriever,
                  length: 6,
                  controller: pinController,
                  focusNode: focusNode,
                  defaultPinTheme: defaultPinTheme,
                  separatorBuilder: (index) => const SizedBox(width: 8),
                  validator: (value) {
                    return value != null|| value!.length != 6 ? null :'Pin is incorrect' ;
                  },
                  hapticFeedbackType: HapticFeedbackType.lightImpact,
                  onCompleted: (pin) {
                    debugPrint('onCompleted: $pin');
                  },
                  onChanged: (value) {
                    debugPrint('onChanged: $value');
                  },
                  cursor: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 9),
                        width: 22,
                        height: 1,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  focusedPinTheme: defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration!.copyWith(
                      color: const Color.fromRGBO(255, 87, 51,0.9),
                      borderRadius: BorderRadius.circular(8),
                      //border: Border.all(color: focusedBorderColor),
                    ),
                  ),
                  autofocus: true,
                  closeKeyboardWhenCompleted: true,
                  showCursor: true,
                  followingPinTheme: defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration!.copyWith(
                      color: fillColor,
                      borderRadius: BorderRadius.circular(8),
                      //border: Border.all(color: focusedBorderColor),
                    ),
                  ),
                  submittedPinTheme: defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration!.copyWith(
                      color: fillColor,
                      borderRadius: BorderRadius.circular(8),
                     // border: Border.all(color: focusedBorderColor),
                    ),
                  ),
                  errorPinTheme: defaultPinTheme.copyBorderWith(
                    border: Border.all(color: Colors.redAccent),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    child: const Text(
                        'إعادة إرسال الكود',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,color: Color.fromRGBO(255, 87, 51,0.9),)),
                    onTap: () async {
                      if (countDownComplete) {
                        print("countDownComplete");
                        print(countDownComplete);
                        setState(() {
                          startTimer();
                        });
                      } else {

                      }
                    },
                  ),
                  Text(
                    '$minutes:$seconds',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: fillColor,
                        fontSize: 18),
                  ),

                ],
              ),
              const SizedBox(height: 150,),
              TextButton(
                onPressed: () {
                  focusNode.unfocus();
                  if (formKey.currentState!.validate()) {
                   if(pinController.text.length ==6)
                     {
                       Navigator.push(
                         context,
                         MaterialPageRoute(builder: (context) => const TransactionsScreen()),
                       );
                     }
                   else {
                     ScaffoldMessenger.of(context).showSnackBar(
                       const SnackBar(
                         backgroundColor: Color.fromRGBO(255, 87, 51,0.9),
                         content: Text('عليك ملئ جميع الخانات'),
                         duration: Duration(seconds:2),
                       ),
                     );
                   }
                  }
                },
                style: TextButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(255, 87, 51, 1.0),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 100.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
                child: const Text('تسجيل الدخول', style: TextStyle(fontWeight: FontWeight.bold),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SmsRetrieverImpl implements SmsRetriever {
  const SmsRetrieverImpl(this.smartAuth);

  final SmartAuth smartAuth;

  @override
  Future<void> dispose() {
    return smartAuth.removeSmsListener();
  }

  @override
  Future<String?> getSmsCode() async {
    final signature = await smartAuth.getAppSignature();
    debugPrint('App Signature: $signature');
    final res = await smartAuth.getSmsCode(
      useUserConsentApi: true,
    );
    if (res.succeed && res.codeFound) {
      return res.code!;
    }
    return null;
  }

  @override
  bool get listenForMultipleSms => false;
}