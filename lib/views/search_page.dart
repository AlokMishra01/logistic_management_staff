import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants/values.dart';
import '../widgets/custom_input.dart';
import '../widgets/header.dart';
import '../widgets/order_list_item.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _search = TextEditingController();

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Header(title: 'Search', backButton: true),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: BASE_PADDING),
              child: CustomInput(
                controller: _search,
                hint: 'Search order here...',
                icon: CupertinoIcons.search,
              ),
            ),
            Expanded(
              child: ListView.separated(
                physics: BouncingScrollPhysics(),
                itemCount: 3,
                separatorBuilder: (_, i) => SizedBox(height: BASE_PADDING),
                itemBuilder: (_, i) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (i == 0) SizedBox(height: HEADER_TEXT / 2),
                      OrderListItem(isactive: 2 != i),
                      if (i == 2) SizedBox(height: HEADER_TEXT * 2),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
