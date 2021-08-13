import 'package:flutter/material.dart';
import 'package:nomoca_flutter/constants/route_names.dart';
import 'package:nomoca_flutter/data/entity/remote/notification_entity.dart';
import 'package:nomoca_flutter/presentation/arguments/qr_read_confirm_argument.dart';
import 'package:nomoca_flutter/presentation/authentication_view.dart';
import 'package:nomoca_flutter/presentation/error_view.dart';
import 'package:nomoca_flutter/presentation/family_user_list_view.dart';
import 'package:nomoca_flutter/presentation/institution_view.dart';
import 'package:nomoca_flutter/presentation/notification_detail_view.dart';
import 'package:nomoca_flutter/presentation/patient_card_view.dart';
import 'package:nomoca_flutter/presentation/qr_read_confirm_view.dart';
import 'package:nomoca_flutter/presentation/qr_read_input_view.dart';
import 'package:nomoca_flutter/presentation/qr_read_select_user_type_view.dart';
import 'package:nomoca_flutter/presentation/sign_in_view.dart';
import 'package:nomoca_flutter/presentation/sign_up_view.dart';
import 'package:nomoca_flutter/presentation/top_view.dart';
import 'package:nomoca_flutter/presentation/upsert_user_view.dart';
import 'package:nomoca_flutter/presentation/upsert_user_view_arguments.dart';
import 'package:nomoca_flutter/presentation/user_management_view.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;

    switch (settings.name) {
      case RouteNames.top:
        return MaterialPageRoute(
          builder: (context) => TopView(),
        );
      case RouteNames.signUp:
        return MaterialPageRoute(
          builder: (context) => SignUpView(),
        );
      case RouteNames.signIn:
        return MaterialPageRoute(
          builder: (context) => SignInView(),
        );
      case RouteNames.authentication:
        return arguments is String?
            ? MaterialPageRoute(
                builder: (context) =>
                    AuthenticationView(mobilePhoneNumber: arguments))
            : MaterialPageRoute(builder: (context) => TopView());
      case RouteNames.patientCard:
        return MaterialPageRoute(
          builder: (context) => PatientCardView(),
        );
      case RouteNames.institution:
        return MaterialPageRoute(
          builder: (context) => InstitutionView(),
        );
      case RouteNames.notificationDetail:
        return arguments is NotificationEntity?
            ? MaterialPageRoute(
                builder: (context) =>
                    NotificationDetailView(notification: arguments))
            : MaterialPageRoute(builder: (context) => TopView());
      case RouteNames.upsertUser:
        return arguments is UpsertUserViewArguments?
            ? MaterialPageRoute(
                builder: (context) => UpsertUserView(args: arguments))
            : MaterialPageRoute(builder: (context) => TopView());
      case RouteNames.familyUserList:
        return arguments is bool?
            ? MaterialPageRoute(
                builder: (context) =>
                    FamilyUserListView(isQrInputRoute: arguments))
            : MaterialPageRoute(builder: (context) => TopView());
      case RouteNames.userManagement:
        return arguments is String?
            ? MaterialPageRoute(
                builder: (context) =>
                    UserManagementView(informationMessage: arguments))
            : MaterialPageRoute(builder: (context) => TopView());
      case RouteNames.qrReadSelectUserType:
        return MaterialPageRoute(
          builder: (context) => QrReadSelectUserTypeView(),
          fullscreenDialog: true,
        );
      case RouteNames.qrReadInput:
        return arguments is int?
            ? MaterialPageRoute(
                builder: (context) => QrReadInputView(familyUserId: arguments))
            : MaterialPageRoute(builder: (context) => TopView());
      case RouteNames.qrReadConfirm:
        return arguments is QrReadConfirmArgument?
            ? MaterialPageRoute(
                builder: (context) => QrReadConfirmView(args: arguments))
            : MaterialPageRoute(builder: (context) => TopView());
      case RouteNames.error:
        return MaterialPageRoute(
          builder: (context) => ErrorView(
            errorMessage: arguments is String?
                ? (arguments != null)
                    ? arguments
                    : 'エラー画面の引数が存在しません'
                : 'エラー画面の引数が文字列ではありません',
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const ErrorView(errorMessage: '指定された画面が存在しません'),
        );
    }
  }
}
