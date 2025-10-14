import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:intervw_niveosys/utils/responsive.dart';
import 'package:intervw_niveosys/view/home_page.dart';
import 'package:intervw_niveosys/view/product_page.dart';
import 'package:intervw_niveosys/view/sales_page.dart';

class NavigationBarPage extends ConsumerWidget {
  const NavigationBarPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageIndex = ref.watch(bottomNavigationBarIndexProvider);

    final pageController = PageController(initialPage: pageIndex);

    final NotchBottomBarController controller = NotchBottomBarController(
      index: pageIndex,
    );

    return Scaffold(
      extendBody: true,
      bottomNavigationBar: AnimatedNotchBottomBar(
        bottomBarItems: const [
          BottomBarItem(
            inActiveItem: Icon(Icons.production_quantity_limits),
            activeItem: Icon(
              Icons.production_quantity_limits,
              color: Colors.grey,
            ),
          ),
          BottomBarItem(
            activeItem: Icon(Icons.home_filled, color: Colors.black),
            inActiveItem: Icon(Icons.home_filled, color: Colors.grey),
          ),
          BottomBarItem(
            inActiveItem: Icon(Icons.shop),
            activeItem: Icon(Icons.shop, color: Colors.grey),
          ),
        ],
        notchBottomBarController: controller,
        onTap: (int index) {
          ref.read(bottomNavigationBarIndexProvider.notifier).state = index;

          pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
          );
        },
        kIconSize: R.sw(20, context),
        kBottomRadius: R.sw(30, context),
      ),
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: pages,
        onPageChanged: (int index) {
          ref.read(bottomNavigationBarIndexProvider.notifier).state = index;
          controller.index = index;
        },
      ),
    );
  }
}

PageController pageController = PageController();
List<Widget> pages = [const ProductListPage(), HomePage(), SalesPage()];

final bottomNavigationBarIndexProvider = StateProvider<int>((ref) => 1);
