import 'package:audio_genie/utils/constants.dart';
import 'package:audio_genie/screens/login_screen.dart';
import 'package:audio_genie/screens/register_screen.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final ScrollController _scrollController = ScrollController();
  final double _scrollDuration = 50;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    Future.delayed(Duration.zero, () {
      _scrollController
          .animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(seconds: _scrollDuration.toInt()),
        curve: Curves.linear,
      )
          .then((_) {
        _scrollController.jumpTo(0);
        _startAutoScroll();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    // Screen width and height
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    final List<String> logos = [
      'assets/images/logo1.png',
      'assets/images/logo4.png',
      'assets/images/logo3.png',
      'assets/images/logo4.png',
      'assets/images/logo3.png',
      'assets/images/logo4.png',
      'assets/images/logo3.png',
      'assets/images/logo4.png',
      'assets/images/logo3.png',
      'assets/images/logo4.png',
    ];

    return Scaffold(
      backgroundColor: kPrimaryDarkColor,
      appBar: AppBar(
        backgroundColor: kPrimaryDarkColor,
        forceMaterialTransparency: true,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 30.0, top: 10),
          child: Text(
            'Audio Genie',
            style: TextStyle(
              fontFamily: kPrimaryFont,
              color: kSecondaryLightColor,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0, right: 20),
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              child: Text(
                'Sign in',
                style: TextStyle(
                  fontFamily: kPrimaryFont,
                  color: kSecondaryLightColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 30.0, top: 10),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RegisterScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kSecondaryLightColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(18),
              ),
              child: Text(
                'Start for Free',
                style: TextStyle(
                  fontFamily: kPrimaryFont,
                  color: kPrimaryDarkColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 90),
            Center(
              child: Text(
                'Extract Key Information\nfrom Audio Instantly',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 60,
                  fontFamily: kPrimaryFont,
                  color: kSecondaryLightColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 40),
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth / 5.5),
                child: Text(
                  'Convert audio into actionable insights by identifying key entities like company names, locations, and dates. Get a detailed list with entity types, text, and precise timestamps without the need for full transcription. Perfect for industries that need to extract critical information quickly and efficiently.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    fontFamily: kPrimaryFont,
                    color: kSecondaryLightColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RegisterScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kSecondaryLightColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(18),
              ),
              child: Text(
                'Start for Free',
                style: TextStyle(
                  fontFamily: kPrimaryFont,
                  color: kPrimaryDarkColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 40),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Trusted by over 10,000 companies, including teams at',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    fontFamily: kPrimaryFont,
                    color: kSecondaryLightColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              height: 200, // Adjust height as needed
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                controller: _scrollController,
                itemCount: logos.length *
                    2, // Multiply by 2 to create a looping effect
                itemBuilder: (context, index) {
                  final logoIndex = index % logos.length;
                  return Row(
                    children: [
                      SizedBox(
                        width: 250,
                        height: 200, // Adjust width as needed
                        child: Image.asset(
                            logos[logoIndex]), // Replace with your logo asset
                      ),
                      const SizedBox(width: 50), // Gap between logos
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Frequently Asked Questions',
                    style: TextStyle(
                      fontSize: 40,
                      fontFamily: kPrimaryFont,
                      color: kSecondaryLightColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ExpansionTile(
                    backgroundColor: kSecondaryDarkColor,
                    collapsedBackgroundColor: kSecondaryDarkColor,
                    title: Text(
                      'What is Audio Genie?',
                      style: TextStyle(
                          fontSize: 24,
                          fontFamily: kPrimaryFont,
                          color: kSecondaryLightColor,
                          fontWeight: FontWeight.w600),
                    ),
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Audio Genie is a tool that extracts key information from audio recordings, such as company names, locations, and dates. It provides a detailed list with entity types, text, and precise timestamps without needing a full transcription.',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: kPrimaryFont,
                            color: kSecondaryLightColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  ExpansionTile(
                    backgroundColor: kSecondaryDarkColor,
                    collapsedBackgroundColor: kSecondaryDarkColor,
                    title: Text(
                      'How does it work?',
                      style: TextStyle(
                          fontSize: 24,
                          fontFamily: kPrimaryFont,
                          color: kSecondaryLightColor,
                          fontWeight: FontWeight.w600),
                    ),
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'You upload your audio file, and Audio Genie analyzes the content to identify key entities and provides timestamps for these entities. You can then review and use this information for your needs.',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: kPrimaryFont,
                            color: kSecondaryLightColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  ExpansionTile(
                    backgroundColor: kSecondaryDarkColor,
                    collapsedBackgroundColor: kSecondaryDarkColor,
                    title: Text(
                      'What types of entities are supported?',
                      style: TextStyle(
                          fontSize: 24,
                          fontFamily: kPrimaryFont,
                          color: kSecondaryLightColor,
                          fontWeight: FontWeight.w600),
                    ),
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'The model is designed to automatically detect and classify various types of entities within the transcription text. The detected entities and their corresponding types is listed individually, ordered by when they first appear in the transcript.\n',
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: kPrimaryFont,
                                color: kSecondaryLightColor,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                showEntityDetailsPopup(context, screenHeight);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: kSecondaryLightColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                              ),
                              child: Text(
                                'View Complete List',
                                style: TextStyle(
                                  fontFamily: kPrimaryFont,
                                  fontSize: 14,
                                  color: kPrimaryDarkColor,
                                  fontWeight: FontWeight.w600,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  ExpansionTile(
                    backgroundColor: kSecondaryDarkColor,
                    collapsedBackgroundColor: kSecondaryDarkColor,
                    title: Text(
                      'How are misspellings or variations of entities handled?',
                      style: TextStyle(
                          fontSize: 24,
                          fontFamily: kPrimaryFont,
                          color: kSecondaryLightColor,
                          fontWeight: FontWeight.w600),
                    ),
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'The model is capable of identifying entities with variations in spelling or formatting. However, the accuracy of the detection may depend on the severity of the variation or misspelling.',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: kPrimaryFont,
                            color: kSecondaryLightColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Add more ExpansionTiles here for additional FAQ entries
                ],
              ),
            ),

            const SizedBox(height: 50),

            const SizedBox(height: 50),
            // Footer section
            Container(
              color: kPrimaryDarkColor,
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Center(
                child: Text(
                  '© 2024 Audio Genie. All rights reserved.',
                  style: TextStyle(
                    fontFamily: kPrimaryFont,
                    color: kSecondaryLightColor,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showEntityDetailsPopup(BuildContext context, double screenHeight) {
     final ScrollController scrollController = ScrollController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: kSecondaryDarkColor,
          title: Text('Entity Types and Descriptions',
              style: TextStyle(
                color: kSecondaryLightColor,
                fontWeight: FontWeight.bold
              )),
          content: ConstrainedBox(
             constraints: BoxConstraints( maxHeight: screenHeight * 0.5),
            child: RawScrollbar(
              thumbColor: kSecondaryLightColor,
              controller: scrollController,
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    entityInfoTile(
                        'account_number',
                        'Customer account or membership identification number',
                        'Policy No. 10042992; Member ID: HZ-5235-001'),
                    entityInfoTile(
                        'banking_information',
                        'Banking information, including account and routing numbers',
                        ''),
                    entityInfoTile('blood_type', 'Blood type', 'O-, AB positive'),
                    entityInfoTile('credit_card_cvv',
                        'Credit card verification code', 'CVV: 080'),
                    entityInfoTile('credit_card_expiration',
                        'Expiration date of a credit card', ''),
                    entityInfoTile('credit_card_number', 'Credit card number', ''),
                    entityInfoTile('date', 'Specific calendar date', 'December 18'),
                    entityInfoTile(
                        'date_interval',
                        'Broader time periods, including date ranges, months, seasons, years, and decades',
                        '2020-2021; 5-9 May; January 1984'),
                    entityInfoTile('date_of_birth', 'Date of birth',
                        'Date of Birth: March 7, 1961'),
                    entityInfoTile('drivers_license', 'Driver\'s license number',
                        'DL# 356933-540'),
                    entityInfoTile('drug', 'Medications, vitamins, or supplements',
                        'Advil, Acetaminophen, Panadol'),
                    entityInfoTile(
                        'duration',
                        'Periods of time, specified as a number and a unit of time',
                        '8 months; 2 years'),
                    entityInfoTile(
                        'email_address', 'Email address', 'support@assemblyai.com'),
                    entityInfoTile('event', 'Name of an event or holiday',
                        'Olympics, Yom Kippur'),
                    entityInfoTile(
                        'filename',
                        'Names of computer files, including the extension or filepath',
                        'Taxes/2012/brad-tax-returns.pdf'),
                    entityInfoTile(
                        'gender_sexuality',
                        'Terms indicating gender identity or sexual orientation, including slang terms',
                        'female; bisexual; trans'),
                    entityInfoTile(
                        'healthcare_number',
                        'Healthcare numbers and health plan beneficiary numbers',
                        'Policy No.: 5584-486-674-YM'),
                    entityInfoTile('injury', 'Bodily injury',
                        'I broke my arm, I have a sprained wrist'),
                    entityInfoTile(
                        'ip_address',
                        'Internet IP address, including IPv4 and IPv6 formats',
                        '192.168.0.1'),
                    entityInfoTile('language', 'Name of a natural language',
                        'Spanish, French'),
                    entityInfoTile(
                        'location',
                        'Any Location reference including mailing address, postal code, city, state, province, country, or coordinates.',
                        'Lake Victoria, 145 Windsor St., 90210'),
                    entityInfoTile(
                        'marital_status',
                        'Terms indicating marital status',
                        'Single; common-law; ex-wife; married'),
                    entityInfoTile(
                        'medical_condition',
                        'Name of a medical condition, disease, syndrome, deficit, or disorder',
                        'chronic fatigue syndrome, arrhythmia, depression'),
                    entityInfoTile(
                        'medical_process',
                        'Medical process, including treatments, procedures, and tests',
                        'heart surgery, CT scan'),
                    entityInfoTile('money_amount', 'Name and/or amount of currency',
                        '15 pesos, \$94.50'),
                    entityInfoTile(
                        'nationality',
                        'Terms indicating nationality, ethnicity, or race',
                        'American, Asian, Caucasian'),
                    entityInfoTile(
                        'number_sequence',
                        'Numerical PII (including alphanumeric strings) that doesn\'t fall under other categories',
                        ''),
                    entityInfoTile('occupation', 'Job title or profession',
                        'professor, actors, engineer, CPA'),
                    entityInfoTile('organization', 'Name of an organization',
                        'CNN, McDonalds, University of Alaska, Northwest General Hospital'),
                    entityInfoTile(
                        'passport_number',
                        'Passport numbers, issued by any country',
                        'PA4568332; NU3C6L86S12'),
                    entityInfoTile(
                        'password',
                        'Account passwords, PINs, access keys, or verification answers',
                        '27%alfalfa, temp1234, My mother\'s maiden name is Smith'),
                    entityInfoTile(
                        'person_age', 'Number associated with an age', '27, 75'),
                    entityInfoTile('person_name', 'Name of a person',
                        'Bob, Doug Jones, Dr. Kay Martinez, MD'),
                    entityInfoTile('phone_number', 'Telephone or fax number', ''),
                    entityInfoTile(
                        'physical_attribute',
                        'Distinctive bodily attributes, including terms indicating race',
                        'I\'m 190cm tall; He belongs to the Black students\' association'),
                    entityInfoTile(
                        'political_affiliation',
                        'Terms referring to a political party, movement, or ideology',
                        'Republican, Liberal'),
                    entityInfoTile(
                        'religion',
                        'Terms indicating religious affiliation',
                        'Hindu, Catholic'),
                    entityInfoTile(
                        'statistics', 'Medical statistics', '18%, 18 percent'),
                    entityInfoTile('time', 'Expressions indicating clock times',
                        '19:37:28; 10pm EST'),
                    entityInfoTile(
                        'url', 'Internet addresses', 'https://www.assemblyai.com/'),
                    entityInfoTile('us_social_security_number',
                        'Social Security Number or equivalent', ''),
                    entityInfoTile('username', 'Usernames, login names, or handles',
                        '@AssemblyAI'),
                    entityInfoTile(
                        'vehicle_id',
                        'Vehicle identification numbers (VINs), vehicle serial numbers, and license plate numbers',
                        '5FNRL38918B111818; BIF7547'),
                    entityInfoTile(
                        'zodiac_sign', 'Names of Zodiac signs', 'Aries; Taurus'),
                  ],
                ),
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kSecondaryLightColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              ),
              child: Text(
                'Close',
                style: TextStyle(
                  fontFamily: kPrimaryFont,
                  fontSize: 14,
                  color: kPrimaryDarkColor,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        );
      },
    );
  }

  Widget entityInfoTile(String name, String description, String example) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: kSecondaryLightColor,
              fontSize: 16,
            ),
          ),
          Text(
            description,
            style: TextStyle(
              fontSize: 14,
              color: kSecondaryLightColor,
            ),
          ),
          if (example.isNotEmpty)
            Text(
              'Example: $example',
              style: TextStyle(
                fontSize: 14,
                color: kSecondaryLightColor,
                fontStyle: FontStyle.italic,
              ),
            ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
