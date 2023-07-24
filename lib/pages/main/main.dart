import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:konachan/pages/download/view.dart';
import 'package:konachan/pages/home/view.dart';
import 'package:konachan/pages/library/view.dart';
import 'package:konachan/pages/main/controller.dart';
import 'package:konachan/pages/search/controller.dart';
import 'package:konachan/pages/search/view.dart';
import 'package:konachan/pages/settings/view.dart';
import 'package:konachan/widgets/navigation.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MainController c = Get.put(MainController());
    return Obx(
      () => NavigationView(
        logo: const Text.rich(TextSpan(children: [
          TextSpan(
            text: "Kona",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          TextSpan(
            text: "chan",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: Colors.deepOrange,
            ),
          ),
        ])),
        navigationButtons: [
          const SizedBox(height: 20),
          SizedBox(
            height: 50,
            child: TextField(
              controller: c.textEditingController,
              decoration: InputDecoration(
                hintText: "Search",
                prefixIcon: const Icon(
                  Icons.search,
                  size: 20,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.all(8),
              ),
              onSubmitted: (value) {
                c.index = 4;
                Get.find<SearchPageController>().tags.value = value;
                if (MediaQuery.of(context).size.width < 600) {
                  Navigator.of(context).pop();
                }
              },
            ),
          ),
          const SizedBox(height: 20),
          NavigationButton(
            onPressed: () {
              c.index = 0;
            },
            selected: c.index == 0,
            child: const Text(
              "Home",
            ),
          ),
          const SizedBox(height: 8),
          NavigationButton(
            onPressed: () {
              c.index = 1;
            },
            selected: c.index == 1,
            child: const Text(
              "Library",
            ),
          ),
          const SizedBox(height: 8),
          NavigationButton(
            onPressed: () {
              c.index = 2;
            },
            selected: c.index == 2,
            child: const Text(
              "Download",
            ),
          ),
          const SizedBox(height: 8),
          NavigationButton(
            onPressed: () {
              c.index = 3;
            },
            selected: c.index == 3,
            child: const Text(
              "Settings",
            ),
          ),
        ],
        body: IndexedStack(
          index: c.index,
          children: const [
            HomePage(),
            LibraryPage(),
            DownloadPage(),
            SettingsPage(),
            SearchPage(),
          ],
        ),
      ),
    );
  }
}
