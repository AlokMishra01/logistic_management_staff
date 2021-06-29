import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../constants/values.dart';
import '../../widgets/detail_row.dart';
import '../../widgets/general_button.dart';
import '../../widgets/profile_info_heading.dart';

class LoadDetailModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: TEXT_WHITE,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(RADIUS),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: BASE_PADDING),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: BASE_PADDING),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 100,
                  height: 4,
                  decoration: BoxDecoration(
                    color: TEXT_SECONDARY_LIGHT,
                    borderRadius: BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: BASE_PADDING),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ProfileInfoHeading(title: 'Package Information'),
                    DetailRow(title: 'Size: ', value: '10 x 10 ft.'),
                    DetailRow(title: 'Weight: ', value: '50 Kg.'),
                    DetailRow(title: 'Route: ', value: 'Bhaktapur'),
                    DetailRow(
                      title: 'Checkpoint: ',
                      value: 'Madhyapur Thimi -7',
                    ),
                    DetailRow(title: 'Price: ', value: 'Rs. 250'),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GeneralButton(
                        color: FIELD_BACKGROUND,
                        child: Text(
                          'VIEW ROUTE MAP',
                          style: TextStyle(
                            color: TEXT_BLUE,
                            fontSize: DETAILS_TEXT - 2,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onTab: () {},
                      ),
                    ),
                    SizedBox(height: BASE_PADDING),
                    ProfileInfoHeading(title: 'Reciever Inforamtion'),
                    DetailRow(title: 'Name: ', value: 'Rajendra Prajapati'),
                    DetailRow(title: 'Address: ', value: 'Bhaktapur'),
                    DetailRow(title: 'Mobile Number: ', value: '9878787654'),
                    DetailRow(title: 'Email: ', value: 'Rajendra@gmail.com'),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GeneralButton(
                        color: FIELD_BACKGROUND,
                        child: Text(
                          'CALL RECIVER',
                          style: TextStyle(
                            color: TEXT_BLUE,
                            fontSize: DETAILS_TEXT - 2,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onTab: () {},
                      ),
                    ),
                    SizedBox(height: BASE_PADDING),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
