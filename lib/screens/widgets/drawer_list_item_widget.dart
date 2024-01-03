import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ndumeappflutter/util/constants.dart';

import '../../data/sessionManager/session_manager.dart';
import '../../injection_container.dart';
import '../cubits/homeChangeWidgetCubit/home_change_widget_cubit.dart';

class DrawerListItemWidget extends StatelessWidget {
  final String title;
  final String icon;
  final int index;
  final bool isHelpInfoIcon;

  const DrawerListItemWidget(
      {required this.title,
      required this.icon,
      required this.index,
      this.isHelpInfoIcon = false,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 5,
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      leading: Image.asset(
        icon,
        height: 24,
        width: 24,
        color: Colors.black,
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16),
      ),
      onTap: () async {
        Scaffold.of(context).closeDrawer();
        if (index != 7 && index != 8) {
          context.read<HomeChangeWidgetCubit>().changeHomeWidget(index);
        } else if (index == 7) {
          await sl<SessionManager>().initiateLogout();
          Navigator.pushNamedAndRemoveUntil(
            context,
            loginPage,
            (route) => false,
          );
        }
      },
    );
  }
}
