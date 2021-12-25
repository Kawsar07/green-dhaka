import 'package:flutter/material.dart';
import 'package:green_dhaka/constraint/color.dart';

class TermsAndCondition extends StatefulWidget {
  @override
  _TermsAndConditionState createState() => _TermsAndConditionState();
}

class _TermsAndConditionState extends State<TermsAndCondition> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Terms & Conditions"),),
      body: SingleChildScrollView(
          child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Green Dhaka is leading Online Plants, Seeds delivery app, Shop anytime, anywhere from a vast range of 12,000+ products including plants, flowers, pots & more at the best prices. Enjoy hassle-free online plant shopping and home delivery at just a click of a button.",
                  textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 10,),
                  Text(
                    'Terms & Conditions',
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),
                  ),
                  SizedBox(height: 10,),
                Text(
                  """
Not only are T&Cs crucial for protecting you from potential liabilities, but (especially in cases of e-commerce) they often contain legally mandated information such as users’ rights, withdrawal or cancellation disclosures.

A valid Terms of Service document is generally required whenever complex issues are at stake, such as in the case of e-commerce, where sensitive information such as payment data is processed. In these cases, the Terms & Conditions typically contains legal information related to conditions of sale and disclosures on methods of payment, shipping, delivery, withdrawals, and cancellation conditions etc. – as commonly required by consumer protection regulations.

Under most countries’ consumer laws, in addition to the default required privacy disclosures, you’ll need to inform customers of the following:
                  """,textAlign: TextAlign.justify,
                ),
                SizedBox(height: 10,),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   dotBuilder(),
                   SizedBox(width: 10,),
                   Text("Returns/Refund details."),
                  ],
                ),
                SizedBox(height: 10,),
                 Row(
                  
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   dotBuilder(),
                   SizedBox(width: 10,),
                   Expanded(child: Text("Warranty/ Guarantee information (where applicable).")),
                  ],
                ),
                 SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   dotBuilder(),
                   SizedBox(width: 10,),
                   Text("Terms of delivery of product/ service."),
                  ],
                ),
                 SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   dotBuilder(),
                   SizedBox(width: 10,),
                   Expanded(child: Text("Identifying information such as a legal address and business name.")),
                  ],
                ),
                 SizedBox(height: 10,),
               Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   dotBuilder(),
                   SizedBox(width: 10,),
                   Text("Industry related legal disclosures."),
                  ],
                ),
                 SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   dotBuilder(),
                   SizedBox(width: 10,),
                   Expanded(child: Text("Rights of consumers (such as withdrawal rights), where applicable.")),
                  ],
                ),
                 SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   dotBuilder(),
                   SizedBox(width: 10,),
                   Text("Seller contact details (e.g. email address)."),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget dotBuilder(){
  return Container(
    width: 20,
    height: 20,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: MyColor.primary
    ),
    child: Icon(Icons.check,color: MyColor.whitish,size: 15,),
  );
}