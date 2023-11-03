import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EndDrawer extends StatelessWidget {
  const EndDrawer({
    super.key,
    required GlobalKey<ScaffoldState> scaffoldKey,
  }) : _scaffoldKey = scaffoldKey;

  final GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          IconButton(
            alignment: Alignment.topLeft,
            icon: const Icon(
              Icons.close,
              color: Colors.red,
            ),
            onPressed: () {
              _scaffoldKey.currentState!.closeEndDrawer();
            },
          ),
          const Text(
            textAlign: TextAlign.center,
            'Token Pro',
            style: TextStyle(
              color: Colors.deepPurple,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Divider(
            color: Colors.grey.shade300,
          ),
          ListTile(
            leading: const Icon(FontAwesomeIcons.shieldHalved),
            title: const Text('Privacy Policy'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(FontAwesomeIcons.snowflake),
            title: const Text('Terms & Conditions'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
