import 'package:grpc_bloc_example/src/models/enums.dart';

import '../app_error.dart';

enum ErrorShowType { snack, modal }

class BaseView {
  void actionState(WidgetState state, {String? text}) {}
  void onError(AppException error,
      {ErrorShowType showType = ErrorShowType.snack}) {}
}
