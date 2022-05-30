import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:grpc_bloc_example/src/models/abstract/view.dart';
import 'package:grpc_bloc_example/src/models/app_error.dart';
import 'package:grpc_bloc_example/src/models/enums.dart';
import 'package:grpc_bloc_example/src/util/snack.dart';

typedef OnError = void Function(AppException error);

class BaseViewState<W extends StatefulWidget> extends State<W>
    implements BaseView {
  WidgetState currentState = WidgetState.init;

  BaseViewState();

  @override
  void initState() {
    super.initState();
  }

  Widget getLoadingView() {
    return const CircularProgressIndicator();
  }

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }

  @override
  void onError(AppException error,
      {ErrorShowType showType = ErrorShowType.snack}) {
    currentState = WidgetState.init;
    // final localization = AppLocalizations.of(context)!;

    String message;
    int code = error.code == null ? 0 : error.code!;

    // switch (code) {
    //   case AppException.kHaveToAgree:
    //     message = localization.haveToAgreeAllPolicies;
    //     break;
    //   case AppException.kFillNecessaryData:
    //     message = localization.fillNecessaryDatas;
    //     break;

    //   case AppException.kWarningPhoneNumberWithoutZero:
    //     message = localization.warningPhoneNumberWithoutZero;
    //     break;
    //   case AppException.kUnknownError:
    //     message = localization.unknownError;
    //     break;
    //   case AppException.kWarningPhoneNotTrue:
    //     message = localization.warningPhoneNotTrue;
    //     break;
    //   case AppException.kWarningCodeNotTrue:
    //     message = localization.warningCodeNotTrue;
    //     break;

    //   default:
    //     message = error.message;
    // }

    message = error.message;
    if (showType == ErrorShowType.snack) {
      Snack.showInfoSnack(context, message,
          duration: const Duration(seconds: 2));
      return;
    }

    // showDialog(
    //     context: context,
    //     builder: (context) => AlertDialog(
    //           title: Text(localization.alert),
    //           content: Text(message),
    //           actions: [
    //             ElevatedButton(
    //                 onPressed: () => Navigator.pop(context),
    //                 child: Text(localization.ok))
    //           ],
    //         ));
  }

  showLoaderDialog(BuildContext context, {String? text}) {
    AlertDialog alert = AlertDialog(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
              // backgroundColor: AppThemeData.primaryColor,
              ),
          text != null
              ? Container(
                  margin: const EdgeInsets.only(left: 7), child: Text(text))
              : const SizedBox(
                  width: 1,
                  height: 1,
                ),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  void actionState(WidgetState state, {String? text}) {
    // if (isActive) {
    //   showLoaderDialog(context, text: text);
    // } else {
    //   try {
    //     Navigator.pop(context);
    //   } catch (e) {
    //     debugPrint(e.toString());
    //   }
    // }

    if (currentState == state) return;

    if (mounted) {
      setState(() {
        currentState = state;
      });
    }
  }
}
