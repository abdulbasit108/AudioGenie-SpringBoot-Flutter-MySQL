import 'package:audio_genie/models/transcription.dart';
import 'package:audio_genie/services/auth_service.dart';
import 'package:audio_genie/services/transcription_service.dart';
import 'package:audio_genie/utils/constants.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthService authService = AuthService();
  final TranscriptionService transcriptionService = TranscriptionService();
  final TextEditingController audioLinkController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final ScrollController _resultScrollController = ScrollController();
  final _formKey = GlobalKey<FormState>();
  Transcription? transcription;
  List<Transcription>? transcriptionList;
  bool btnLoader = false;

  String generatedArticle = 'Identified Entities will be displayed here.';

  void generateArticle() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        btnLoader = true;
      });
      transcription = await transcriptionService.transcribeAudio(
          context: context, audioLink: audioLinkController.text);
      setState(() {
        btnLoader = false;
      });
    }
  }

  fetchAllTranscriptions() async {
    transcriptionList =
        await transcriptionService.fetchAllTranscriptions(context: context);
    setState(() {});
  }

  void copyToClipboard() {
    String copiedText = transcription!.entities.map((entity) {
      return 'Entity Type: ${entity.entityType}\n'
          'Text: ${entity.text}\n'
          'Start: ${entity.start}, End: ${entity.end}\n';
    }).join('\n');
    Clipboard.setData(ClipboardData(text: copiedText));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Copied to clipboard!')),
    );
  }

  @override
  void initState() {
    super.initState();
    fetchAllTranscriptions();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    // Screen width and height
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

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
            padding: const EdgeInsets.only(right: 30.0, top: 10),
            child: ElevatedButton(
              onPressed: () {
                authService.logOut(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kSecondaryLightColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(18),
              ),
              child: Text(
                'Sign Out',
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
      body: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Left side for inputs
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: screenWidth * 0.4,
                  height: screenHeight * 0.4,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: kSecondaryDarkColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Audio Entity Recognition',
                        style: TextStyle(
                          fontFamily: kPrimaryFont,
                          fontSize: 32,
                          color: kSecondaryLightColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Extract Meaningful Data From Your Audio',
                        style: TextStyle(
                          fontFamily: kPrimaryFont,
                          fontSize: 16,
                          color: kSecondaryLightColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Form(
                        key: _formKey,
                        child: TextFormField(
                          style: TextStyle(
                              fontFamily: kPrimaryFont,
                              color: kSecondaryLightColor),
                          controller: audioLinkController,
                          decoration: InputDecoration(
                            labelText: 'Paste your Audio URL here...',
                            labelStyle: TextStyle(
                                fontFamily: kPrimaryFont,
                                color: kSecondaryLightColor),
                            border: InputBorder.none,
                            filled: true,
                            fillColor: kPrimaryDarkColor,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter audio Link';
                            }

                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: kSecondaryLightColor,
                          ),
                          Text(
                            ' Ensure that the URL is publically accessible',
                            style: TextStyle(
                              fontFamily: kPrimaryFont,
                              fontSize: 16,
                              color: kSecondaryLightColor,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      btnLoader == false
                          ? ElevatedButton(
                              onPressed: generateArticle,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: kSecondaryLightColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 20),
                              ),
                              child: Text(
                                'Analyze Audio',
                                style: TextStyle(
                                  fontFamily: kPrimaryFont,
                                  color: kPrimaryDarkColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )
                          : CircularProgressIndicator(
                              color: kSecondaryLightColor,
                            )
                    ],
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.04,
                ),
                Container(
                  width: screenWidth * 0.4,
                  height: screenHeight * 0.4,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: kSecondaryDarkColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'History',
                        style: TextStyle(
                          fontFamily: kPrimaryFont,
                          fontSize: 32,
                          color: kSecondaryLightColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'View Your Transcription History',
                        style: TextStyle(
                          fontFamily: kPrimaryFont,
                          fontSize: 16,
                          color: kSecondaryLightColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 20),
                      transcriptionList == null
                          ? const Text('No History')
                          : Expanded(
                            child: RawScrollbar(
                              controller: _scrollController,
                              thumbColor: kSecondaryLightColor,
                              
                              child: ListView.builder(
                                controller: _scrollController,
                                scrollDirection: Axis.horizontal,
                                itemCount: transcriptionList!.length,
                                itemBuilder: (context, index) {
                                  final transcriptionEntry =
                                      transcriptionList![index];
                                  return Container(
                                    height: screenHeight * 0.15,
                                    width: screenWidth * 0.1,
                                    padding: const EdgeInsets.all(10),
                                    margin: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: kPrimaryDarkColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          transcriptionEntry.audioLink,
                                          style: TextStyle(
                                            fontFamily: kPrimaryFont,
                                            fontSize: 12,
                                            color: kSecondaryLightColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            transcription =
                                                transcriptionEntry;
                                            setState(() {});
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                kSecondaryLightColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            padding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 10,
                                                    horizontal: 10),
                                          ),
                                          child: Text(
                                            'View',
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
                                  );
                                },
                              ),
                            ),
                          )
                    ],
                  ),
                ),
              ],
            ),
            // Right side for output
            Container(
              width: screenWidth * 0.4,
              height: screenHeight * 0.84,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: kSecondaryDarkColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Results',
                    style: TextStyle(
                        fontFamily: kPrimaryFont,
                        fontSize: 32,
                        color: kSecondaryLightColor,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  transcription == null
                      ? Expanded(
                          child: SingleChildScrollView(
                            child: Text(
                              generatedArticle,
                              style: TextStyle(
                                fontFamily: kPrimaryFont,
                                fontSize: 16,
                                color: kSecondaryLightColor,
                              ),
                            ),
                          ),
                        )
                      : Expanded(
                          child: RawScrollbar(
                            thumbColor: kSecondaryLightColor,
                            controller: _resultScrollController,
                            child: SingleChildScrollView(
                              controller: _resultScrollController,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: transcription!.entities.map((entity) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: screenWidth * 0.36,
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: kPrimaryDarkColor,
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Entity Type: ${entity.entityType.toUpperCase()}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: kSecondaryLightColor,
                                              fontSize: 16.0,
                                            ),
                                          ),
                                          const SizedBox(height: 4.0),
                                          Text(
                                            'Text: ${entity.text}',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                color: kSecondaryLightColor,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          const SizedBox(height: 4.0),
                                          Text(
                                            'Start: ${entity.start}, End: ${entity.end}',
                                            style: TextStyle(
                                                fontSize: 14.0,
                                                color: kSecondaryLightColor,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: copyToClipboard,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kSecondaryLightColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 20),
                    ),
                    child: Text(
                      'Copy to Clipboard',
                      style: TextStyle(
                        fontFamily: kPrimaryFont,
                        color: kPrimaryDarkColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
