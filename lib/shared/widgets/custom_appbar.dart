import 'package:flutter/material.dart';
import 'package:trelza_pubseek/features/settings/presentation/screens/settings.dart';
import 'package:trelza_pubseek/shared/extensions/app_theme_extensions.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({
    super.key,
    required this.title,
    required this.textcontroller,
    required this.retryFunction,
  });
  final String title;
  final TextEditingController textcontroller;
  final VoidCallback retryFunction;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          Image.asset("assets/logo/logo.png", height: 30),
          const SizedBox(width: 10), // spacing between icon and text
          Text(title, style: context.textTheme.titleLarge),
        ],
      ),
      backgroundColor: context.colorScheme.surface,
      actions: [
        IconButton(onPressed: retryFunction, icon: Icon(Icons.replay_outlined)),
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Settings()),
            );
          },
          icon: const Icon(Icons.settings),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: TextField(
            controller: textcontroller,
            style: context.textTheme.bodyMedium,
            decoration: InputDecoration(
              filled: true,
              fillColor: context.colorScheme.tertiary,
              contentPadding: const EdgeInsets.all(14),
              prefixIcon: Icon(
                Icons.search,
                color: context.colorScheme.onTertiary,
              ),
              suffixIcon:
                  textcontroller.text.isNotEmpty
                      ? IconButton(
                        onPressed: () {
                          textcontroller.clear();
                          FocusScope.of(context).unfocus();
                        },
                        icon: Icon(
                          Icons.cancel_outlined,
                          color: context.colorScheme.onTertiary,
                        ),
                      )
                      : null,
              hintStyle: context.textTheme.bodyMedium,
              hintText: context.loc.search,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: context.colorScheme.tertiary),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: context.colorScheme.tertiary),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(130);
}
