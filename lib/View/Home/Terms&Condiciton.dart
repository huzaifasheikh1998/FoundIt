import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class TermsAndCondicitonScreen extends StatefulWidget {
  const TermsAndCondicitonScreen({super.key});

  @override
  State<TermsAndCondicitonScreen> createState() => _AboutAppStateScreen();
}

class _AboutAppStateScreen extends State<TermsAndCondicitonScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF1F2F6),
      appBar: AppBar(
        leadingWidth: 70,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Terms & Condiciton",
          style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
              color: Color(0xff2C2C2C)),
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Padding(
            padding: EdgeInsets.only(left: 20.w),
            child: Container(
              width: 56.w,
              height: 38.h,
              child: Image.asset("assets/images/Group 331@2x.png"),
            ),
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                20.verticalSpace,

                _buildSectionContent(
                  'Welcome to Found IT! We\'re excited to have you become a member of our platform. '
                  'We have comprehensive Terms and Conditions (“Terms”) meticulously developed for all our users so they can use the App, services, and website (collectively, the “Service”) more conveniently. '
                  'Your use of the App and its Service will imply that you accept and agree to our Terms. It will also mean you agree to our Privacy Policy and other policies referenced here. '
                  'If you find any part associated with these Terms is not up to you, please refrain from using the App and discontinue using the Service.',
                ),
                _buildSectionTitle('1. Access & Membership'),
                _buildSectionContent(
                  'Gain an enhanced organizational experience by becoming a member of Found IT. Once you sign up for the app, you will be eligible to enjoy the Service features that enable you to easily manage your storage spaces, whether it’s your garage or storage units. '
                  'Becoming a member of the App requires you to submit your information - it must be up-to-date, accurate, and complete. Maintaining your account details’ confidentiality and all activities happening under the account is your core responsibility. '
                  'It may be possible that you notice any unauthorized use of your account or any activity under it without your permission. In this case, you are responsible for notifying us immediately. '
                  'Keep in mind that membership in the App is a privilege, suggesting that you must protect your account from any misuse that can result in an immediate account deactivation or termination of your access.',
                ),
                _buildSectionTitle('2. Modifications'),
                _buildSectionContent(
                  'The entire world is constantly evolving, and so is Found IT and its practices, processes, procedures, technology, and legal requirements. '
                  'We may bring changes to these Terms whenever needed. This way, we will reflect modifications brought to our practices, processes, procedures, technology, and/or legal requirements. '
                  'Whenever changes, modifications, or updates are made, we are responsible for updating you using appropriate communication means, including emails or notifications within the Service. '
                  'We recommend you review these revised aspects because your continued use of the App or its Service implies that you accept and agree to the changes. In case you disagree with any changes we make to these Terms, you are advised not to use or stop accessing the App or using the Service.',
                ),
                _buildSectionTitle('3. Content'),
                _buildSectionContent(
                  'Found IT may provide an abundance of content in the form of text, images, videos, graphics, and software. We either own this content or use it with permission from our licensors. '
                  'We invite you to use our content only for personal use instead of any kind of commercial purpose. Nevertheless, we strictly prohibit you from copying, altering, distributing, or misusing our content or any part of it without prior consent in the written format. '
                  'We creatively and diligently work on and produce our content, and we appreciate your respect for it and our efforts.',
                ),
                _buildSectionTitle('4. Use of Services'),
                _buildSectionContent(
                  'We created this App to be intuitive and user-centric, making it beneficial for organizing and managing your belongings. '
                  'You agree to be responsible when accessing the App and using our Services, including inventory management, QR code generation, and order tracking. '
                  'This means you agree not to engage in harassment, impersonation, distractions, and use of bots or any automated systems when interacting with our Service. '
                  'If any violation or misuse of these Terms is made or other users or Service are disturbed, immediate account deactivation or termination of your access will be the end result.',
                ),
                _buildSectionTitle('5. Content and Services'),
                _buildSectionContent(
                  'Enhancing your experience is our primary goal, and we do so by offering valuable content and high-quality services. '
                  'Although we do our best to maintain accuracy and reliability, we do not or cannot guarantee that our content and services will always be error-free or uninterrupted. '
                  'We can exercise our right to change, update, modify, suspend, or halt any part of our Service whenever we need without prior notice. '
                  'We always engage in improving Found IT for you, and we appreciate your understanding and patience.',
                ),
                _buildSectionTitle(
                    '6. Your Rights in the Case of Lack of Conformity'),
                _buildSectionContent(
                  'If your expected quality or functionality standards are not met from a service or product you purchased from us, consumer protection laws give you rights. '
                  'You may claim for exchange, return, or refund, depending on where you live or your location. You can exercise these rights by contacting our customer support representative and sharing the problem, proof of purchase, and any pertinent documentation. '
                  'We’re committed to your satisfaction by addressing and resolving any problems immediately.',
                ),
                _buildSectionTitle(
                    '7. Responsibility of Site Members and Visitors'),
                _buildSectionContent(
                  'Your role as a Found IT member or visitor is crucial in maintaining a safe and positive community. '
                  'You are responsible for respectfully and lawfully interacting with others, avoiding sharing wrong or misleading information, and refraining from engaging in any activity that could hurt the Service or its users. '
                  'You agree to align your actions with our values of respect, integrity, and cooperation.',
                ),
                _buildSectionTitle('8. Payments and Fees'),
                _buildSectionContent(
                  'Using Found IT might involve making payments for certain Services, such as QR code printing. '
                  'All prices and fees are clearly stated, and you agree to pay them as outlined. Payments can be made using approved in-app methods, and you are responsible for providing accurate billing information. '
                  'If there are any issues with your payment method, we may suspend or terminate your access to paid services until the issue is resolved. Payment details are securely stored for in-app transactions.',
                ),
                _buildSectionTitle('9. Taxes'),
                _buildSectionContent(
                  'Depending on where you are located, your purchases may be subject to taxes, such as, but not limited to, sales taxes, VAT, GST, and duties (if and as applicable). '
                  'Aside from the circumstances mentioned below, it is your responsibility to pay any valid taxes related to transactions on Found IT. '
                  'In some U.S. states and other countries, we, as the seller, may collect the applicable taxes from you and pay them to the concerned tax authority. '
                  'Some circumstances may require you to show a legal immunity certificate, such as a Resale Certificate, VAT ID, or ABN.',
                ),
                _buildSectionTitle('10. Shipping'),
                _buildSectionContent(
                  'We understand the importance of on-time delivery and work diligently to prioritize reliable, seamless, and timely shipping for all your orders. '
                  'We will provide shipping details, including estimated delivery times and costs, at checkout. Your location matters and delivery times may vary accordingly. '
                  'Delivery times may also depend on the shipping method selected. After shipping your order, we will send tracking information to help you monitor its progress. '
                  'Although we do our best to meet these estimates, various external factors beyond our control can affect delivery times. If you experience any issues with your delivery, you can contact our customer service for support.',
                ),
                _buildSectionTitle('11. Description of Products'),
                _buildSectionContent(
                  'We take special precautions to describe our products precisely, including specifications, features, and prices. However, slight variations in packaging, design, or color may occur. '
                  'Before purchasing, you can contact us for answers to any questions about a product. Our goal is to enable you to make informed decisions, and we do so by ensuring you have all the information you need.',
                ),
                _buildSectionTitle('12. Purchase of Products'),
                _buildSectionContent(
                  'Once you purchase products from Found IT, you sign a binding agreement to pay for the items as described. '
                  'It is advisable to take a careful approach to reviewing your order before confirming. Remember that we don’t/cannot guarantee changes in orders or cancellation of orders after it has been processed. '
                  'If you experience any issues with your order, contact our support representative for immediate assistance.',
                ),
                _buildSectionTitle('13. Release'),
                _buildSectionContent(
                  'Your use of our Service will imply your acceptance and agreement to release Found IT and its associates (directors, employees, and affiliates) from any claims, obligations, damages, or losses resulting from your use of the Service or any disputes with other users. '
                  'With this release, all interactions and transactions made through the App are covered, emphasizing your responsibility for your actions and decisions.',
                ),
                _buildSectionTitle('14. Indemnity'),
                _buildSectionContent(
                  'You accept and agree to indemnify and hold Found IT and all its associated people harmless from any claims, obligations, accountabilities, costs, damages, or losses originating from your engagement with the Service, your violation of these Terms, or your abuse of any rights of another person or entity. '
                  'Your promise to cover helps us keep the environment safe and positive for all users.',
                ),
                _buildSectionTitle('15. Governing Law'),
                _buildSectionContent(
                  'The laws of the State of [Define State] govern these Terms and your use of the Service, irrespective of its conflict of law principles. '
                  'These laws shall apply to and resolve any disputes emerging from these Terms or the Service, ensuring reliability and impartiality in the resolution process.',
                ),
                _buildSectionTitle('16. Arbitration and Jury Trial Waiver'),
                _buildSectionContent(
                  'Any disputes, disagreements, claims, conflicts, or controversies stemming from or connected to these Terms or your use of the Service shall be addressed by arbitration executed by the American Arbitration Association (AAA) under the guidelines of its Commercial Arbitration Rules. '
                  'A single arbitrator will be responsible for conducting the arbitration, which be held in [Define Location]. You will be responsible for accepting the arbitrator\'s decision because that will be final and binding. '
                  'You consent to waive any right to a trial by jury or to participate in a class action legal action.',
                ),
                _buildSectionTitle('17. Privacy and Personal Data Processing'),
                _buildSectionContent(
                  'We always strive to ensure your privacy. We have a comprehensive Privacy Policy that briefly explains our data (your personal information) handling and processing practices. '
                  'By accessing our App or using the Service, you agree to our data handling and processing practices as explained in the Privacy Policy. We are committed to protecting your data from any unfortunate event and ensuring transparency in our data processing activities.',
                ),
                _buildSectionTitle('18. General'),
                _buildSectionContent(
                  'These Terms, including our Privacy Policy and any other policies referenced, are key elements that constitute the legal agreement between you and Found IT regarding your use of the Service. '
                  'If you find any part of these Terms invalid, illegal, or inoperative, the rest of the provisions will continue in full validity. Our failure to implement any right or provision defined under these Terms does not establish a waiver of that particular right or provision. '
                  'We reserve the right to transfer our rights, obligations, and responsibilities under these Terms without restrictions, but you can do this with our permission.',
                ),
                SizedBox(height: 16.0),
                Text(
                  'Thank you for being a member of the Found IT community. By accessing our platform or using our Service, you accept that you have thoroughly reviewed, understood, and acknowledged these Terms and Conditions. '
                  'If you need assistance or want answers to any questions, you can contact us at:',
                  style: GoogleFonts.lato(fontSize: 16),
                ),
                SizedBox(height: 16.0),
                Text(
                  '• Email\n'
                  '• Address\n'
                  '• Phone',
                  style: GoogleFonts.lato(fontSize: 16, color: Colors.blue),
                ),
                SizedBox(height: 16.0),
                Text(
                  'By accessing or using Found IT, you accept that you have thoroughly read, reviewed, understood, and agree to these Terms and Conditions.',
                  style: GoogleFonts.lato(fontSize: 16),
                ),

                // Container(
                //   width: 390.w,
                //   height: 799.h,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(5),
                //     color: Color(0xffFFFFFF),
                //   ),
                //   child: Column(
                //     children: [
                //       10.verticalSpace,
                //       Container(
                //         width: 350.w,
                //         height: 780.h,
                //         child: Text(
                //           textAlign: TextAlign.left,
                //           "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of de Finibus Bonorum et Malorum (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum,Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of de Finibus Bonorum et Malorum (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance The first line of Lorem Ipsum",
                //           style: TextStyle(color: Color(0xff667080)),
                //         ),
                //       ),
                //     ],
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildSectionTitle(String title) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Text(
      title,
      style: GoogleFonts.lato(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget _buildSectionContent(String content) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16.0),
    child: Text(
      content,
      style: GoogleFonts.lato(fontSize: 16),
    ),
  );
}
