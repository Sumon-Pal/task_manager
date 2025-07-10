import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/update_profile_screen.dart';

import '../screens/sign_in_screen.dart';

class TMAppBar extends StatefulWidget implements PreferredSizeWidget {
  const TMAppBar({super.key});

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  State<TMAppBar> createState() => _TMAppBarState();
}

class _TMAppBarState extends State<TMAppBar> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTapUpdateProfile,
      child: AppBar(
        backgroundColor: Colors.green,
        title: Row(
          children: [
            CircleAvatar(),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sumon Pal',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'sumonpalcse@gamil.com',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(onPressed: _onTapSignOut, icon: Icon(Icons.exit_to_app)),
          ],
        ),
      ),
    );
  }

  void _onTapSignOut() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      SignInScreen.name,
      (predicate) => false,
    );
  }
  void _onTapUpdateProfile(){
    if(ModalRoute.of(context)?.settings.name != UpdateProfileScreen.name) {
       Navigator.pushNamed(context, UpdateProfileScreen.name);
    }
    //Navigator.pushNamed(context, UpdateProfileScreen.name);
  }
}
