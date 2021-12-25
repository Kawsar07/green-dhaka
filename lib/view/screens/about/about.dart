import 'package:flutter/material.dart';

class AboutScreen extends StatefulWidget {
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("About"),),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                Text(
                  'Green Dhaka',
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),

                ),
                SizedBox(height: 10,),
              Text(
                "Green Dhaka is leading Online Plants, Seeds delivery app, Shop anytime, anywhere from a vast range of 12,000+ products including plants, flowers, pots & more at the best prices. Enjoy hassle-free online plant shopping and home delivery at just a click of a button.",
                textAlign: TextAlign.justify,
                ),
                SizedBox(height: 10,),
                Text(
                  'Service',
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),
                ),
                SizedBox(height: 10,),
              Text(
                """
* Wide range of products, including Fresh Live plants, Seeds, Gardening Tools, Handmade Products, Spices & More.
* Enjoy low prices and great offers: Buy at low prices with great offers including discounts.

* Fast and Secure Checkout: Pay by Paytm,Google-pay net-banking, credit and debit cards options and e-wallets.

* Assured Quality: All plants goes through thorough quality checks, thereby ensuring we only deliver the best.

* Fast Delivery, On-time, every-time: Fast and perfect dispatch to provide doorstep delivery of plants.

* Easy search options: use our various search options.
                """
              ),
            ],
          ),
        ),
      ),
    );
  }
}