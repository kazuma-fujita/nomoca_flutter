import 'package:flutter/material.dart';
import 'package:nomoca_flutter/constants/route_names.dart';
import 'package:nomoca_flutter/data/entity/remote/notification_entity.dart';
import 'package:nomoca_flutter/presentation/authentication_view.dart';
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
        return MaterialPageRoute(
          builder: (context) => AuthenticationView(),
        );
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
                builder: (context) => NotificationDetailView(arguments))
            : MaterialPageRoute(builder: (context) => TopView());
      case RouteNames.upsertUser:
        return MaterialPageRoute(
          builder: (context) => UpsertUserView(),
        );
      case RouteNames.familyUserList:
        return MaterialPageRoute(
          builder: (context) => FamilyUserListView(),
        );
      case RouteNames.userManagement:
        return MaterialPageRoute(
          builder: (context) => UserManagementView(),
        );
      case RouteNames.qrReadSelectUserType:
        return MaterialPageRoute(
          builder: (context) => QrReadSelectUserTypeView(),
          fullscreenDialog: true,
        );
      case RouteNames.qrReadInput:
        return MaterialPageRoute(
          builder: (context) => QrReadInputView(),
        );
      case RouteNames.qrReadConfirm:
        return MaterialPageRoute(
          builder: (context) => QrReadConfirmView(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => TopView(),
        );
    }
  }
}
