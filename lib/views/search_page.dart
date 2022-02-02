import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logistic_management_staff/constants/colors.dart';
import 'package:logistic_management_staff/controllers/delivery_controller.dart';
import 'package:logistic_management_staff/widgets/load_list_item.dart';
import 'package:logistic_management_staff/widgets/order_type_bar.dart';
import 'package:provider/provider.dart';

import '../constants/values.dart';
import '../widgets/custom_input.dart';
import '../widgets/header.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({
    Key? key,
  }) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _search = TextEditingController();

  int _selected = 0;

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final delivery = context.watch<DeliveryController>();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Header(title: 'Search', backButton: true),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: BASE_PADDING),
              child: CustomInput(
                controller: _search,
                hint: 'Search package here...',
                icon: CupertinoIcons.search,
                onChanged: (v) {
                  delivery.searchPackage(
                    query: v.toString(),
                    isDispatch: _selected == 1,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(BASE_PADDING),
              child: Container(
                decoration: BoxDecoration(
                  color: FIELD_BACKGROUND,
                  borderRadius: BorderRadius.circular(RADIUS),
                ),
                child: Flex(
                  direction: Axis.horizontal,
                  children: [
                    OrderTypeBar(
                      title: "PICK UP",
                      selected: _selected == 0,
                      onTab: () {
                        _selected = 0;
                        setState(() {});
                        delivery.searchPackage(
                          query: _search.text,
                          isDispatch: _selected == 1,
                        );
                      },
                    ),
                    OrderTypeBar(
                      title: "DISPATCH",
                      selected: _selected == 1,
                      onTab: () {
                        _selected = 1;
                        setState(() {});
                        delivery.searchPackage(
                          query: _search.text,
                          isDispatch: _selected == 1,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: BASE_PADDING),
            if (delivery.searchedPackages.isNotEmpty)
              Expanded(
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemCount: delivery.searchedPackages.length,
                  separatorBuilder: (_, i) => const SizedBox(
                    height: BASE_PADDING,
                  ),
                  itemBuilder: (_, i) {
                    final p = delivery.searchedPackages[i];
                    return LoadListItem(
                      model: p,
                      isDispatch: _selected == 1,
                    );
                  },
                ),
              ),
            if (delivery.searchedPackages.isEmpty)
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.all(BASE_PADDING * 2),
                  child: Text(
                    'No package found related to your query.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: TEXT_SECONDARY,
                      fontSize: SUB_HEADER_TEXT,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
