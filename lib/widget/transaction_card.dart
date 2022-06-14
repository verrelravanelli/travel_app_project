// import 'package:airplane/models/transaction_model.dart';
import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

import '../theme.dart';
import 'booking_details_item.dart';

class TransactionCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 30,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 30,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: kWhiteColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Note : Destination Tile
          Row(
            children: [
              Container(
                width: 70,
                height: 70,
                margin: EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      'https://images.unsplash.com/photo-1518791841217-8f162f1e1131?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Paris, France',
                      style: blackTextStyle.copyWith(
                        fontSize: 18,
                        fontWeight: medium,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      '3 nights',
                      style: greyTextStyle.copyWith(
                        fontWeight: light,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    margin: EdgeInsets.only(
                      right: 2,
                    ),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/icon_star.png',
                        ),
                      ),
                    ),
                  ),
                  Text(
                    '4.9',
                    style: blackTextStyle.copyWith(
                      fontWeight: medium,
                    ),
                  ),
                ],
              ),
            ],
          ),
          // Note : Booking details
          Container(
            margin: EdgeInsets.only(
              top: 20,
            ),
            child: Text(
              'Booking Details',
              style: blackTextStyle.copyWith(
                fontSize: 16,
                fontWeight: semiBold,
              ),
            ),
          ),
          // Note : Booking Details Item
          BookingDetailsItem(
            detailTitle: 'Traveler',
            valueText: '2',
            valueColor: kBlackColor,
          ),
          BookingDetailsItem(
            detailTitle: 'Seat',
            valueText: '2',
            valueColor: kBlackColor,
          ),
          BookingDetailsItem(
            detailTitle: 'Insurance',
            valueText: 'Yes',
            valueColor: kBlackColor,
          ),
          BookingDetailsItem(
            detailTitle: 'Refundable',
            valueText: 'Yes',
            valueColor: kBlackColor,
          ),
          BookingDetailsItem(
            detailTitle: 'VAT',
            valueText: 'Yes',
            valueColor: kBlackColor,
          ),
          BookingDetailsItem(
            detailTitle: 'Price',
            valueText: '\$1,000',
            valueColor: kBlackColor,
          ),
          BookingDetailsItem(
            detailTitle: 'Grand Total',
            valueText: '\$1,000',
            valueColor: kPrimaryColor,
          ),
        ],
      ),
    );
  }
}
