import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:realstate/constants/constants.dart';
import 'package:realstate/model/house.dart';
import 'package:realstate/provider/house_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class BottomButtons extends ConsumerStatefulWidget {
  final int index;
  const BottomButtons(this.index);

  @override
  ConsumerState<BottomButtons> createState() => _BottomButtonsState();
}

class _BottomButtonsState extends ConsumerState<BottomButtons> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String? number;
    return ref.watch(feedProvider).when(
          data: (List<House> house_list) {
            return Padding(
              padding: const EdgeInsets.only(bottom: appPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: size.width * 0.4,
                    height: 60,
                    decoration: BoxDecoration(
                        color: darkBlue,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                              color: darkBlue.withOpacity(0.6),
                              offset: Offset(0, 10),
                              blurRadius: 10)
                        ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          (Icons.mail_rounded),
                          color: white,
                        ),
                        Text(
                          ' Message',
                          style: TextStyle(
                            color: white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      //  await FlutterPhoneDirectCaller.callNumber(
                      //       '+251961035355');
                      setState(() {
                        number=house_list[widget.index].phone_number.toString();
                      });

                      launch(
                          'tel://$number');
                      print(
                          'tHE pHONE nUMBER IS $number');
                    },
                    child: Container(
                      width: size.width * 0.4,
                      height: 60,
                      decoration: BoxDecoration(
                          color: darkBlue,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                                color: darkBlue.withOpacity(0.6),
                                offset: Offset(0, 10),
                                blurRadius: 10)
                          ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            (Icons.call_rounded),
                            color: white,
                          ),
                          Text(
                            ' Call',
                            style: TextStyle(
                              color: white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          error: (error, stateTrace) {
            return const Center(
              child: Text('error'),
            );
          },
          loading: () => const CircularProgressIndicator(),
        );
  }
}
