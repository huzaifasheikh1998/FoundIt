import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _AboutAppStateScreen();
}

class _AboutAppStateScreen extends State<PrivacyPolicyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF1F2F6),
      appBar: AppBar(
        leadingWidth: 70,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Privacy Policy",
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
                  'Welcome to Found IT – an Inventory Management App! We have this Privacy Policy to update you about our data (your personal information) handling and processing practices, describing how we gather, proceed, share, disclose, and safeguard your personal information when you access or use our App or Service. Safeguarding your privacy is our commitment, and we take a secure and responsible approach to handling your personal data.',
                ),
                _buildSectionTitle(
                    'Information Collected About Users and Merchants and How We Use It'),
                _buildSectionContent(
                  'We may collect personal information when you create an account on the App or use the Service. Personal information we collect from you includes your name, e-mail address, contact/phone number, shipping address, and payment details (if applicable). Our users can also be businesses; if you are a merchant accessing or using our Service, we may gather your business identity, contact information, and payment information. Whatever information we collect from you, this information helps us provide and enhance our services, process seamless and timely transactions, and communicate efficiently with you.',
                ),
                _buildSectionTitle('How We Collect Your Data'),
                _buildSectionContent(
                  'We may collect personal information from you through various means, including direct interactions, automated technologies, and third parties. We collect personal information when you create an account, update your profile, or communicate with us directly. We collect personal information when you use our App, and we do so through cookies, web beacons, and server logs. We also collect personal information from third parties we work with, and we do so with your consent or as permitted by law. Our trusted third-party service providers are payment processors, shipping vendors, and others.',
                ),
                _buildSectionTitle('How We Use Your Data'),
                _buildSectionContent(
                  'We use your personal information for various legitimate purposes. Your data helps us ensure and maintain the functionality of our App. We use your data to process and manage your inventory and interactions with you, including round-the-clock customer support service and updates. We also use your information to bring enhancement to our services and new features while ensuring the App’s functionality, security, and integrity.',
                ),
                _buildSectionTitle('Sharing Personal Data with Third Parties'),
                _buildSectionContent(
                  'We do not trade, lease, rent, or sell your personal data. However, we may share your information with our trusted third-party service providers and legal authorities. We work with service providers, such as payment processors and shipping vendors, who help us seamlessly operate our App; hence, we need to share your data with them. We also collaborate with legal authorities and may share your data with them when required by law or to protect our rights and safety. We ensure that third parties abide by data protection rules and regulations and only use your data legally, as our contracts allow.',
                ),
                _buildSectionTitle('Retention Periods'),
                _buildSectionContent(
                  'We retain your personal information for a period as long as necessary. Your information helps us provide our services seamlessly, abide by legal obligations, address disputes by resolving them, and enforce our agreements. Once that period ends, we securely erase your data from our database.',
                ),
                _buildSectionTitle('Information Security'),
                _buildSectionContent(
                  'As protecting your information is our priority, we take appropriate technical and organizational measures, including encryption, secure servers, and access controls. We implement those to safeguard your personal data from unauthorized access, modification, leak, or destruction.',
                ),
                _buildSectionTitle('Your Choices Relating to Our Services'),
                _buildSectionContent(
                  'You reserve the right to access your data to correct, update, or delete it. You have the right to object to or restrict the data processing made by us. You can also request data portability and withdraw your consent at any time. However, while doing so, you are responsible for maintaining the fairness of data processing based on permission before its withdrawal.',
                ),
                _buildSectionTitle(
                    'Additional Disclosure for European Residents'),
                _buildSectionContent(
                  'You may reside in the European Economic Area (EEA) or the United Kingdom. If so, you reserve the right to access your personal information for updating, correcting, or erasing it, object to or restrict our data processing, request data portability, and file complaints with a supervisory authority. Processing your data from our side has a legal basis, including consent, performance of a contract, and legitimate interests. Overall, you reserve certain rights relating to your personal information according to Data Protection Laws in the EU and UK (collectively the “GDPR”).',
                ),
                _buildSectionTitle(
                    'Additional Disclosures for California Residents'),
                _buildSectionContent(
                  'You may reside in California, and if so, you reserve the right to request information associated with the sorts of personal data we gather and share. Every term and phrase used under this section conveys the same meaning or has the same significance as those specified under the California Consumer Privacy Act and its implementing regulations, as modified (collectively, the “CCPA”). Under the CCPA, California residents reserve rights regarding Personal Information. You can request access to and remove personal data. You also have the right to opt out of the disclosure or sharing of your personal data. Remember that we do not trade, lease, sell, or rent personal information.',
                ),
                _buildSectionTitle(
                    'Additional Disclosures for Colorado, Connecticut, Delaware, Indiana, Iowa, Montana, Oregon, Tennessee, Texas, Utah, and Virginia Residents'),
                _buildSectionContent(
                  'Residents of these states have certain rights with respect to the data we collect under the state laws, including the Colorado Privacy Act, Connecticut Data Privacy Act, Delaware Personal Data Privacy Act, Indiana Consumer Data Protection Act, Iowa Consumer Data Protection Act, Montana Consumer Data Privacy Act, Oregon Consumer Privacy Act, Tennessee Information Protection Act, Texas Data Privacy and Security Act, Utah Consumer Privacy Act, Virginia Consumer Data Protection Act, and other similar laws that may be potentially set to be introduced in the future. Residents of these states can access data for correction or deletion, request data portability, and opt out of targeted advertising.',
                ),
                _buildSectionTitle(
                    'How to Exercise Your Legal Rights Under GDPR, CCPA, or Heightened U.S. Privacy Laws'),
                _buildSectionContent(
                  'To exercise your rights under GDPR, CCPA, or other applicable laws, you must verify yourself or your account by submitting the correct personal details. Whenever you need to delete your data via account settings, you can request us through email to access it. We don’t trade, rent, sell, or share your data, so we don’t make “opt-out” available. You must request data in a machine-readable format via email. You must (if living in California, Colorado, and Connecticut) use authorized agents with written consent. Contact the merchant directly for processor roles, and we aim to address requests within 30-45 days.',
                ),
                _buildSectionTitle('Links to Third-Party Sites'),
                _buildSectionContent(
                  'You may find links to third-party websites or services while using our App. These are external sites, and we do not own them, suggesting that we are not responsible for them, their privacy policies, their content, and their data-handling practices. It is advisable to take a careful approach to reviewing their policies.',
                ),
                _buildSectionTitle('Privacy Policy Changes'),
                _buildSectionContent(
                  'We have the right to amend, revise, or update this Privacy Policy occasionally when we need. Once any change is made, the revised version of this policy will be posted on our App. In this case, you will be notified of major changes through email. However, we may also deliver a prominent notification on the App. If you continue to use the App even after changes, it will imply your acceptance of or agreement to the revised Privacy Policy.',
                ),
                _buildSectionTitle('Complaints and Contact'),
                _buildSectionContent(
                  'If you want to interact with us or have any queries or concerns about our privacy policy, feel free to contact us at:\n\n'
                  '• Email\n'
                  '• Address\n'
                  '• Phone',
                ),
                SizedBox(height: 16.0),
                Text(
                  'By accessing or using Found IT, you accept that you have thoroughly read, reviewed, understood, and agree to our Privacy Policy.',
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
