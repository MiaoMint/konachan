import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:konachan/pages/download/controller.dart';
import 'package:konachan/pages/library/controller.dart';
import 'package:konachan/utils/storage.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return const Center(
        child: Text("This feature is not available on web"),
      );
    }
    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          title: Text("Settings"),
          automaticallyImplyLeading: false,
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              ListTile(
                title: const Text("Download Path"),
                subtitle: Text(
                  "Set the path to save the image, cuurent path: ${StroageUtils.downloadPath}",
                ),
                trailing: TextButton(
                  onPressed: () async {
                    final path = await FilePicker.platform.getDirectoryPath();
                    if (path != null) {
                      StroageUtils.downloadPath = path;
                      setState(() {});
                      Get.find<DownloadController>().onInit();
                      Get.find<LibraryController>().onInit();
                    }
                  },
                  child: const Text("Change"),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
