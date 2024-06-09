import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final duerChangeNotifierProvider = ChangeNotifierProvider<DuerChangeNotifier>((ref) => DuerChangeNotifier());

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pinkAccent),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key});

  @override
  ConsumerState createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState {
  final _createPopUpController = ScrollController();
  final _editPopUpController = ScrollController();
  final _searchController = TextEditingController();
  final _idnmeController = TextEditingController();
  final _idaddController = TextEditingController();
  final _idamtController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final mnthList = ['January','February','March','April','May','June','July','August','September','October','November','December'];
  bool _pop = true;

  void _onSearchChanged() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _createPopUpController.dispose();
    _editPopUpController.dispose();
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _idnmeController.dispose();
    _idaddController.dispose();
    _idamtController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final darkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final Color screenNormal = darkMode ? Colors.black : Colors.white;
    final Color screenInverse = darkMode ? Colors.white : Colors.black;
    final devHeight = MediaQuery.of(context).size.height;
    final devWidth = MediaQuery.of(context).size.width;

    return PopScope(
      canPop: _pop,
      onPopInvoked: (canPop) => setState(() {
        if (_focusNode.hasFocus) {
          _focusNode.unfocus();
          _pop = true;
        }
      }),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: screenNormal,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 100.0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                          flex: 3,
                          child: Container(
                            alignment: Alignment.center,
                            height: 43.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30.0),
                                color: Colors.grey.withOpacity(0.2)
                            ),
                            child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 0.0),
                                child: CupertinoTextField(
                                  onTapOutside: (_) => _focusNode.unfocus(),
                                  onTap: () => setState(() => _pop = false),
                                  focusNode: _focusNode,
                                  controller: _searchController,
                                  cursorColor: Colors.grey,
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      color: screenInverse
                                  ),
                                  placeholder: 'Search',
                                  placeholderStyle: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0)
                                  ),
                                  suffix: _searchController.text.isNotEmpty
                                      ? GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _searchController.clear();
                                      });
                                    },
                                    child: const Icon(
                                      CupertinoIcons.clear_thick_circled,
                                      size: 20.0,
                                      color: Colors.grey,
                                    )
                                  )
                                      : null,
                              )
                            )
                          )
                      ),
                      const SizedBox(
                        width: 10.0
                      ),
                      Expanded(
                        flex: 1,
                        child: ElevatedButton(
                          style:  ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              backgroundColor: Colors.transparent,
                              surfaceTintColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                          ),
                            onPressed: () {
                            _idnmeController.clear();
                            _idaddController.clear();
                            _idamtController.clear();
                            showDialog(
                                barrierColor: Colors.transparent,
                                context: context,
                                builder: (context) {
                                  Color colorShade_Create = MediaQuery.of(context).platformBrightness == Brightness.dark ? Colors.white : Colors.black;
                                  bool _clientFill_Create = true;
                                  List<String> mnthSelected_Create = ['null','null','null','null','null','null','null','null','null','null','null','null'];

                                  return StatefulBuilder(builder: (context, changeState) {
                                    return Padding(
                                        padding: const EdgeInsets.only(top: 60.0),
                                        child: AlertDialog(
                                          backgroundColor: MediaQuery.of(context).platformBrightness == Brightness.dark ? Colors.grey.shade900 : Colors.grey.shade100,
                                          surfaceTintColor: Colors.grey,
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20.0)
                                              )
                                          ),
                                          title: Text(
                                              "Create ID",
                                              style: TextStyle(
                                                  fontSize: 24.0,
                                                  color: colorShade_Create
                                              )
                                          ),
                                          content: SizedBox(
                                              height: 400.0,
                                              child: SingleChildScrollView(
                                                  controller: _createPopUpController,
                                                  child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: <Widget>[
                                                        RichText(
                                                            text: TextSpan(
                                                                style: TextStyle(
                                                                    color: colorShade_Create
                                                                ),
                                                                children: [
                                                                  const TextSpan(text: 'Mention Client • '),
                                                                  TextSpan(
                                                                      text: 'Required',
                                                                      style: TextStyle(
                                                                          color: _clientFill_Create ? colorShade_Create : Colors.red
                                                                      )
                                                                  )
                                                                ]
                                                            )
                                                        ),
                                                        Container(
                                                            height: 75.0,
                                                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                                                            child: TextField(
                                                                controller: _idnmeController,
                                                                inputFormatters: <TextInputFormatter>[
                                                                  LengthLimitingTextInputFormatter(50)
                                                                ],
                                                                style: TextStyle(
                                                                    color: colorShade_Create
                                                                ),
                                                                cursorColor: Colors.grey,
                                                                decoration: InputDecoration(
                                                                    border: const OutlineInputBorder(),
                                                                    enabledBorder: const OutlineInputBorder(
                                                                        borderSide: BorderSide(
                                                                          color: Colors.grey,
                                                                          width: 1.0,
                                                                        )
                                                                    ),
                                                                    focusedBorder: OutlineInputBorder(
                                                                        borderSide: BorderSide(
                                                                          color: colorShade_Create,
                                                                          width: 1.0,
                                                                        )
                                                                    )
                                                                )
                                                            )
                                                        ),
                                                        Text(
                                                            'Mention Address • Optional',
                                                            style: TextStyle(
                                                                color: colorShade_Create
                                                            )
                                                        ),
                                                        Container(
                                                            height: 145.0,
                                                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                                                            child: TextField(
                                                                controller: _idaddController,
                                                                keyboardType: TextInputType.multiline,
                                                                maxLines: 4,
                                                                style: TextStyle(
                                                                    color: colorShade_Create
                                                                ),
                                                                cursorColor: Colors.grey,
                                                                decoration: InputDecoration(
                                                                    border: const OutlineInputBorder(),
                                                                    enabledBorder: const OutlineInputBorder(
                                                                        borderSide: BorderSide(
                                                                          color: Colors.grey,
                                                                          width: 1.0
                                                                        )
                                                                    ),
                                                                    focusedBorder: OutlineInputBorder(
                                                                        borderSide: BorderSide(
                                                                          color: colorShade_Create,
                                                                          width: 1.0
                                                                        )
                                                                    )
                                                                )
                                                            )
                                                        ),
                                                        Text(
                                                            'Mention Amount ( Rs. | ₹ )',
                                                            style: TextStyle(
                                                                color: colorShade_Create
                                                            )
                                                        ),
                                                        Container(
                                                            height: 75.0,
                                                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                                                            child: TextField(
                                                                controller: _idamtController,
                                                                keyboardType: TextInputType.number,
                                                                inputFormatters: <TextInputFormatter>[
                                                                  FilteringTextInputFormatter.digitsOnly,
                                                                  LengthLimitingTextInputFormatter(20)
                                                                ],
                                                                style: TextStyle(
                                                                    color: colorShade_Create
                                                                ),
                                                                cursorColor: Colors.grey,
                                                                decoration: InputDecoration(
                                                                    border: const OutlineInputBorder(),
                                                                    enabledBorder: const OutlineInputBorder(
                                                                        borderSide: BorderSide(
                                                                          color: Colors.grey,
                                                                          width: 1.0,
                                                                        )
                                                                    ),
                                                                    focusedBorder: OutlineInputBorder(
                                                                        borderSide: BorderSide(
                                                                          color: colorShade_Create,
                                                                          width: 1.0,
                                                                        )
                                                                    )
                                                                )
                                                            )
                                                        ),
                                                        Text(
                                                            'Mention Time Period',
                                                            style: TextStyle(
                                                                color: colorShade_Create
                                                            )
                                                        ),
                                                        Column(
                                                            children: List<Widget>.generate(
                                                                12, (index) {
                                                              return CustomSwitch(
                                                                  value: false,
                                                                  text: mnthList[index],
                                                                  onChanged: (value) {
                                                                    changeState(() => value ? mnthSelected_Create[index] = mnthList[index]
                                                                        : mnthSelected_Create[index] = 'null');
                                                                  }
                                                              );
                                                            }
                                                            )
                                                        )
                                                      ]
                                                  )
                                              )
                                          ),
                                          actionsPadding: const EdgeInsets.symmetric(horizontal: 25.0),
                                          contentPadding: const EdgeInsets.symmetric(horizontal: 25.0),
                                          actionsAlignment: MainAxisAlignment.spaceBetween,
                                          actions: <Widget>[
                                            ElevatedButton(
                                                style:  ElevatedButton.styleFrom(
                                                  padding: EdgeInsets.zero,
                                                  backgroundColor: Colors.transparent,
                                                  surfaceTintColor: Colors.transparent,
                                                  shadowColor: Colors.transparent,
                                                ),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text(
                                                    'Cancel',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: colorShade_Create
                                                    )
                                                )
                                            ),
                                            ElevatedButton(
                                                style:  ElevatedButton.styleFrom(
                                                  padding: EdgeInsets.zero,
                                                  backgroundColor: Colors.transparent,
                                                  surfaceTintColor: Colors.transparent,
                                                  shadowColor: Colors.transparent,
                                                ),
                                                onPressed: () {
                                                  if(_idnmeController.text.isEmpty){
                                                   _createPopUpController.animateTo(0.0,
                                                        duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
                                                   changeState(() => _clientFill_Create = false);
                                                  } else {
                                                    Navigator.of(context).pop();
                                                    changeState(() => _clientFill_Create = true);
                                                    ref.read(duerChangeNotifierProvider).addData(_idnmeController.text,
                                                        _idaddController.text, _idamtController.text, mnthSelected_Create);
                                                  }
                                                },
                                                child: const Text(
                                                    'Create',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.pinkAccent
                                                    )
                                                )
                                            )
                                          ]
                                        )
                                    );
                                  });
                                });
                            },
                            child: Icon(
                              Icons.add_circle_outline_rounded,
                              color: Colors.pinkAccent.withOpacity(0.55),
                              size: 32.0
                            )
                        )
                      )
                    ]
                  )
                )
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight: devHeight - 150.0
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                      Radius.circular(30.0)
                  ),
                  child: SingleChildScrollView(
                    child: Consumer(builder: (context, ref, child) {
                      final duerState = ref.watch(duerChangeNotifierProvider).data;
                      final filteredDuerState = duerState.where((data) {
                        return _searchController.text.isEmpty ||
                            data.duer_nme.toLowerCase().contains(_searchController.text.toLowerCase());
                      }).toList();

                      return Theme(
                          data: Theme.of(context).copyWith(
                              cardColor: screenInverse.withOpacity(0.1)
                          ),
                          child: ExpansionPanelList(
                              dividerColor: screenInverse.withOpacity(
                                  0.1),
                              materialGapSize: 0,
                              elevation: 0,
                              expandIconColor: screenInverse,
                              expansionCallback: (int index, bool isExpanded) {
                                ref.read(duerChangeNotifierProvider).expandData(
                                    index, isExpanded);
                              },
                              children: filteredDuerState
                                  .asMap()
                                  .entries
                                  .map<ExpansionPanel>((entry) {
                                final index = entry.key;
                                final data = entry.value;

                                return ExpansionPanel(
                                    isExpanded: data.isExpanded,
                                    headerBuilder: (BuildContext context,
                                        bool isExpanded) {
                                      return ListTile(
                                          title: Text(
                                              data.duer_nme,
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: screenInverse
                                              )
                                          ),
                                          subtitle: Text(
                                              'Set at ${data.duer_tme}',
                                              style: TextStyle(
                                                  fontSize: 11.0,
                                                  color: screenInverse
                                              )
                                          ),
                                          trailing: Text(
                                              'Rs. | ₹ ${data.duer_amt}',
                                              style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: screenInverse
                                              )
                                          )
                                      );
                                    },
                                    body: ConstrainedBox(
                                        constraints: BoxConstraints(
                                            minWidth: devWidth
                                        ),
                                        child: SizedBox(
                                            child: Padding(
                                                padding: const EdgeInsets.all(
                                                    5.0),
                                                child: Column(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .start,
                                                    children: <Widget>[
                                                      Wrap(
                                                          spacing: 8.0,
                                                          runSpacing: 4.0,
                                                          children: data
                                                              .duer_mnth.where((
                                                              mnth) =>
                                                          mnth != 'null').map((
                                                              mnth) {
                                                            return Chip(
                                                                label: Text(
                                                                    mnth),
                                                                backgroundColor: darkMode
                                                                    ? Colors
                                                                    .blue
                                                                    .shade100
                                                                    : Colors
                                                                    .blue
                                                                    .shade300,
                                                                shape: const StadiumBorder(
                                                                    side: BorderSide(
                                                                        color: Colors
                                                                            .transparent
                                                                    )
                                                                )
                                                            );
                                                          }).toList()
                                                      ),
                                                      const SizedBox(
                                                          height: 12.0),
                                                      Padding(
                                                          padding: const EdgeInsets
                                                              .symmetric(
                                                              horizontal: 8.0),
                                                          child: Align(
                                                            alignment: Alignment
                                                                .topLeft,
                                                            child: Text(
                                                                'At : ${data
                                                                    .duer_add}',
                                                                style: TextStyle(
                                                                    color: screenInverse
                                                                )
                                                            ),
                                                          )
                                                      ),
                                                      const SizedBox(
                                                          height: 12.0),
                                                      Row(
                                                          children: <Widget>[
                                                            Expanded(
                                                                child: SizedBox(
                                                                    child: TextButton(
                                                                        onPressed: () {},
                                                                        onLongPress: () {
                                                                          showDialog(
                                                                              barrierColor: Colors
                                                                                  .transparent,
                                                                              context: context,
                                                                              builder: (
                                                                                  context) {
                                                                                Color colorShade_Delete = MediaQuery
                                                                                    .of(
                                                                                    context)
                                                                                    .platformBrightness ==
                                                                                    Brightness
                                                                                        .dark
                                                                                    ? Colors
                                                                                    .white
                                                                                    : Colors
                                                                                    .black;

                                                                                return StatefulBuilder(
                                                                                    builder: (
                                                                                        context,
                                                                                        _) {
                                                                                      return AlertDialog(
                                                                                          backgroundColor: MediaQuery
                                                                                              .of(
                                                                                              context)
                                                                                              .platformBrightness ==
                                                                                              Brightness
                                                                                                  .dark
                                                                                              ? Colors
                                                                                              .grey
                                                                                              .shade900
                                                                                              : Colors
                                                                                              .grey
                                                                                              .shade100,
                                                                                          surfaceTintColor: Colors
                                                                                              .grey,
                                                                                          shape: const RoundedRectangleBorder(
                                                                                              borderRadius: BorderRadius
                                                                                                  .all(
                                                                                                  Radius
                                                                                                      .circular(
                                                                                                      20.0)
                                                                                              )
                                                                                          ),
                                                                                          title: Text(
                                                                                              "Delete ID",
                                                                                              style: TextStyle(
                                                                                                  fontSize: 24.0,
                                                                                                  color: colorShade_Delete
                                                                                              )
                                                                                          ),
                                                                                          content: Text(
                                                                                              "Note : Deleted ID cannot be retrieved",
                                                                                              style: TextStyle(
                                                                                                  color: colorShade_Delete
                                                                                              )
                                                                                          ),
                                                                                          actionsPadding: const EdgeInsets
                                                                                              .symmetric(
                                                                                              horizontal: 25.0),
                                                                                          contentPadding: const EdgeInsets
                                                                                              .symmetric(
                                                                                              horizontal: 25.0),
                                                                                          actionsAlignment: MainAxisAlignment
                                                                                              .spaceBetween,
                                                                                          actions: <
                                                                                              Widget>[
                                                                                            ElevatedButton(
                                                                                                style: ElevatedButton
                                                                                                    .styleFrom(
                                                                                                  padding: EdgeInsets
                                                                                                      .zero,
                                                                                                  backgroundColor: Colors
                                                                                                      .transparent,
                                                                                                  surfaceTintColor: Colors
                                                                                                      .transparent,
                                                                                                  shadowColor: Colors
                                                                                                      .transparent,
                                                                                                ),
                                                                                                onPressed: () {
                                                                                                  Navigator
                                                                                                      .of(
                                                                                                      context)
                                                                                                      .pop();
                                                                                                },
                                                                                                child: Text(
                                                                                                    'Cancel',
                                                                                                    style: TextStyle(
                                                                                                        fontSize: 16,
                                                                                                        color: colorShade_Delete
                                                                                                    )
                                                                                                )
                                                                                            ),
                                                                                            ElevatedButton(
                                                                                                style: ElevatedButton
                                                                                                    .styleFrom(
                                                                                                  padding: EdgeInsets
                                                                                                      .zero,
                                                                                                  backgroundColor: Colors
                                                                                                      .transparent,
                                                                                                  surfaceTintColor: Colors
                                                                                                      .transparent,
                                                                                                  shadowColor: Colors
                                                                                                      .transparent,
                                                                                                ),
                                                                                                onPressed: () {
                                                                                                  Navigator
                                                                                                      .of(
                                                                                                      context)
                                                                                                      .pop();
                                                                                                  ref
                                                                                                      .read(
                                                                                                      duerChangeNotifierProvider)
                                                                                                      .removeData(
                                                                                                      duerState[index]);
                                                                                                },
                                                                                                child: const Text(
                                                                                                    'Confirm',
                                                                                                    style: TextStyle(
                                                                                                        fontSize: 16,
                                                                                                        color: Colors
                                                                                                            .pinkAccent
                                                                                                    )
                                                                                                )
                                                                                            )
                                                                                          ]
                                                                                      );
                                                                                    });
                                                                              });
                                                                        },
                                                                        child: Icon(
                                                                            Icons
                                                                                .delete_outline_rounded,
                                                                            color: screenInverse,
                                                                            size: 30.0
                                                                        )
                                                                    )
                                                                )
                                                            ),
                                                            const SizedBox(
                                                                width: 50.0),
                                                            Expanded(
                                                                child: TextButton(
                                                                    onPressed: () {
                                                                      _idnmeController
                                                                          .text =
                                                                          data
                                                                              .duer_nme;
                                                                      _idaddController
                                                                          .text =
                                                                          data
                                                                              .duer_add;
                                                                      _idamtController
                                                                          .text =
                                                                          data
                                                                              .duer_amt;
                                                                      showDialog(
                                                                          barrierColor: Colors
                                                                              .transparent,
                                                                          context: context,
                                                                          builder: (
                                                                              context) {
                                                                            Color colorShade_Edit = MediaQuery
                                                                                .of(
                                                                                context)
                                                                                .platformBrightness ==
                                                                                Brightness
                                                                                    .dark
                                                                                ? Colors
                                                                                .white
                                                                                : Colors
                                                                                .black;
                                                                            bool _clientFill_Edit = true;
                                                                            List<
                                                                                String> mnthSelected_Edit = data
                                                                                .duer_mnth;

                                                                            return StatefulBuilder(
                                                                                builder: (
                                                                                    context,
                                                                                    changeState) {
                                                                                  return Padding(
                                                                                      padding: const EdgeInsets
                                                                                          .only(
                                                                                          top: 60.0),
                                                                                      child: AlertDialog(
                                                                                          backgroundColor: MediaQuery
                                                                                              .of(
                                                                                              context)
                                                                                              .platformBrightness ==
                                                                                              Brightness
                                                                                                  .dark
                                                                                              ? Colors
                                                                                              .grey
                                                                                              .shade900
                                                                                              : Colors
                                                                                              .grey
                                                                                              .shade100,
                                                                                          surfaceTintColor: Colors
                                                                                              .grey,
                                                                                          shape: const RoundedRectangleBorder(
                                                                                              borderRadius: BorderRadius
                                                                                                  .all(
                                                                                                  Radius
                                                                                                      .circular(
                                                                                                      20.0)
                                                                                              )
                                                                                          ),
                                                                                          title: Text(
                                                                                              "Edit ID",
                                                                                              style: TextStyle(
                                                                                                  fontSize: 24.0,
                                                                                                  color: colorShade_Edit
                                                                                              )
                                                                                          ),
                                                                                          content: SizedBox(
                                                                                              height: 400.0,
                                                                                              child: SingleChildScrollView(
                                                                                                  controller: _editPopUpController,
                                                                                                  child: Column(
                                                                                                      mainAxisAlignment: MainAxisAlignment
                                                                                                          .start,
                                                                                                      crossAxisAlignment: CrossAxisAlignment
                                                                                                          .start,
                                                                                                      mainAxisSize: MainAxisSize
                                                                                                          .min,
                                                                                                      children: <
                                                                                                          Widget>[
                                                                                                        RichText(
                                                                                                            text: TextSpan(
                                                                                                                style: TextStyle(
                                                                                                                    color: colorShade_Edit
                                                                                                                ),
                                                                                                                children: [
                                                                                                                  const TextSpan(
                                                                                                                      text: 'Edit Client • '),
                                                                                                                  TextSpan(
                                                                                                                      text: 'Required',
                                                                                                                      style: TextStyle(
                                                                                                                          color: _clientFill_Edit
                                                                                                                              ? colorShade_Edit
                                                                                                                              : Colors
                                                                                                                              .red
                                                                                                                      )
                                                                                                                  )
                                                                                                                ]
                                                                                                            )
                                                                                                        ),
                                                                                                        Container(
                                                                                                            height: 75.0,
                                                                                                            padding: const EdgeInsets
                                                                                                                .symmetric(
                                                                                                                vertical: 4.0),
                                                                                                            child: TextField(
                                                                                                                controller: _idnmeController,
                                                                                                                inputFormatters: <
                                                                                                                    TextInputFormatter>[
                                                                                                                  LengthLimitingTextInputFormatter(
                                                                                                                      50)
                                                                                                                ],
                                                                                                                style: TextStyle(
                                                                                                                    color: colorShade_Edit
                                                                                                                ),
                                                                                                                cursorColor: Colors
                                                                                                                    .grey,
                                                                                                                decoration: InputDecoration(
                                                                                                                    border: const OutlineInputBorder(),
                                                                                                                    enabledBorder: const OutlineInputBorder(
                                                                                                                        borderSide: BorderSide(
                                                                                                                          color: Colors
                                                                                                                              .grey,
                                                                                                                          width: 1.0,
                                                                                                                        )
                                                                                                                    ),
                                                                                                                    focusedBorder: OutlineInputBorder(
                                                                                                                        borderSide: BorderSide(
                                                                                                                          color: colorShade_Edit,
                                                                                                                          width: 1.0,
                                                                                                                        )
                                                                                                                    )
                                                                                                                )
                                                                                                            )
                                                                                                        ),
                                                                                                        Text(
                                                                                                            'Edit Address • Optional',
                                                                                                            style: TextStyle(
                                                                                                                color: colorShade_Edit
                                                                                                            )
                                                                                                        ),
                                                                                                        Container(
                                                                                                            height: 145.0,
                                                                                                            padding: const EdgeInsets
                                                                                                                .symmetric(
                                                                                                                vertical: 4.0),
                                                                                                            child: TextField(
                                                                                                                controller: _idaddController,
                                                                                                                keyboardType: TextInputType
                                                                                                                    .multiline,
                                                                                                                maxLines: 4,
                                                                                                                style: TextStyle(
                                                                                                                    color: colorShade_Edit
                                                                                                                ),
                                                                                                                cursorColor: Colors
                                                                                                                    .grey,
                                                                                                                decoration: InputDecoration(
                                                                                                                    border: const OutlineInputBorder(),
                                                                                                                    enabledBorder: const OutlineInputBorder(
                                                                                                                        borderSide: BorderSide(
                                                                                                                            color: Colors
                                                                                                                                .grey,
                                                                                                                            width: 1.0
                                                                                                                        )
                                                                                                                    ),
                                                                                                                    focusedBorder: OutlineInputBorder(
                                                                                                                        borderSide: BorderSide(
                                                                                                                            color: colorShade_Edit,
                                                                                                                            width: 1.0
                                                                                                                        )
                                                                                                                    )
                                                                                                                )
                                                                                                            )
                                                                                                        ),
                                                                                                        Text(
                                                                                                            'Edit Amount ( Rs. | ₹ )',
                                                                                                            style: TextStyle(
                                                                                                                color: colorShade_Edit
                                                                                                            )
                                                                                                        ),
                                                                                                        Container(
                                                                                                            height: 75.0,
                                                                                                            padding: const EdgeInsets
                                                                                                                .symmetric(
                                                                                                                vertical: 4.0),
                                                                                                            child: TextField(
                                                                                                                controller: _idamtController,
                                                                                                                keyboardType: TextInputType
                                                                                                                    .number,
                                                                                                                inputFormatters: <
                                                                                                                    TextInputFormatter>[
                                                                                                                  FilteringTextInputFormatter
                                                                                                                      .digitsOnly,
                                                                                                                  LengthLimitingTextInputFormatter(
                                                                                                                      20)
                                                                                                                ],
                                                                                                                style: TextStyle(
                                                                                                                    color: colorShade_Edit
                                                                                                                ),
                                                                                                                cursorColor: Colors
                                                                                                                    .grey,
                                                                                                                decoration: InputDecoration(
                                                                                                                    border: const OutlineInputBorder(),
                                                                                                                    enabledBorder: const OutlineInputBorder(
                                                                                                                        borderSide: BorderSide(
                                                                                                                          color: Colors
                                                                                                                              .grey,
                                                                                                                          width: 1.0,
                                                                                                                        )
                                                                                                                    ),
                                                                                                                    focusedBorder: OutlineInputBorder(
                                                                                                                        borderSide: BorderSide(
                                                                                                                          color: colorShade_Edit,
                                                                                                                          width: 1.0,
                                                                                                                        )
                                                                                                                    )
                                                                                                                )
                                                                                                            )
                                                                                                        ),
                                                                                                        Text(
                                                                                                            'Edit Time Period',
                                                                                                            style: TextStyle(
                                                                                                                color: colorShade_Edit
                                                                                                            )
                                                                                                        ),
                                                                                                        Column(
                                                                                                            children: List<
                                                                                                                Widget>.generate(
                                                                                                                12, (
                                                                                                                index) {
                                                                                                              return CustomSwitch(
                                                                                                                  value: mnthSelected_Edit[index] !=
                                                                                                                      'null',
                                                                                                                  text: mnthList[index],
                                                                                                                  onChanged: (
                                                                                                                      value) {
                                                                                                                    changeState(() =>
                                                                                                                    value
                                                                                                                        ?
                                                                                                                    mnthSelected_Edit[index] =
                                                                                                                    mnthList[index]
                                                                                                                        : mnthSelected_Edit[index] =
                                                                                                                    'null');
                                                                                                                  }
                                                                                                              );
                                                                                                            }
                                                                                                            )
                                                                                                        )
                                                                                                      ]
                                                                                                  )
                                                                                              )
                                                                                          ),
                                                                                          actionsPadding: const EdgeInsets
                                                                                              .symmetric(
                                                                                              horizontal: 25.0),
                                                                                          contentPadding: const EdgeInsets
                                                                                              .symmetric(
                                                                                              horizontal: 25.0),
                                                                                          actionsAlignment: MainAxisAlignment
                                                                                              .spaceBetween,
                                                                                          actions: <
                                                                                              Widget>[
                                                                                            ElevatedButton(
                                                                                                style: ElevatedButton
                                                                                                    .styleFrom(
                                                                                                  padding: EdgeInsets
                                                                                                      .zero,
                                                                                                  backgroundColor: Colors
                                                                                                      .transparent,
                                                                                                  surfaceTintColor: Colors
                                                                                                      .transparent,
                                                                                                  shadowColor: Colors
                                                                                                      .transparent,
                                                                                                ),
                                                                                                onPressed: () {
                                                                                                  Navigator
                                                                                                      .of(
                                                                                                      context)
                                                                                                      .pop();
                                                                                                },
                                                                                                child: Text(
                                                                                                    'Cancel',
                                                                                                    style: TextStyle(
                                                                                                        fontSize: 16,
                                                                                                        color: colorShade_Edit
                                                                                                    )
                                                                                                )
                                                                                            ),
                                                                                            ElevatedButton(
                                                                                                style: ElevatedButton
                                                                                                    .styleFrom(
                                                                                                  padding: EdgeInsets
                                                                                                      .zero,
                                                                                                  backgroundColor: Colors
                                                                                                      .transparent,
                                                                                                  surfaceTintColor: Colors
                                                                                                      .transparent,
                                                                                                  shadowColor: Colors
                                                                                                      .transparent,
                                                                                                ),
                                                                                                onPressed: () {
                                                                                                  if (_idnmeController
                                                                                                      .text
                                                                                                      .isEmpty) {
                                                                                                    _editPopUpController
                                                                                                        .animateTo(
                                                                                                        0.0,
                                                                                                        duration: const Duration(
                                                                                                            milliseconds: 500),
                                                                                                        curve: Curves
                                                                                                            .easeIn);
                                                                                                    changeState(() =>
                                                                                                    _clientFill_Edit =
                                                                                                    false);
                                                                                                  } else {
                                                                                                    Navigator
                                                                                                        .of(
                                                                                                        context)
                                                                                                        .pop();
                                                                                                    changeState(() =>
                                                                                                    _clientFill_Edit =
                                                                                                    true);
                                                                                                    ref
                                                                                                        .read(
                                                                                                        duerChangeNotifierProvider)
                                                                                                        .editData(
                                                                                                        index,
                                                                                                        _idnmeController
                                                                                                            .text,
                                                                                                        _idaddController
                                                                                                            .text,
                                                                                                        _idamtController
                                                                                                            .text,
                                                                                                        mnthSelected_Edit);
                                                                                                  }
                                                                                                },
                                                                                                child: const Text(
                                                                                                    'Save',
                                                                                                    style: TextStyle(
                                                                                                        fontSize: 16,
                                                                                                        color: Colors
                                                                                                            .pinkAccent
                                                                                                    )
                                                                                                )
                                                                                            )
                                                                                          ]
                                                                                      )
                                                                                  );
                                                                                });
                                                                          });
                                                                    },
                                                                    child: Icon(
                                                                        Icons
                                                                            .edit_note_rounded,
                                                                        color: screenInverse,
                                                                        size: 30.0
                                                                    )
                                                                )
                                                            )
                                                          ]
                                                      )
                                                    ]
                                                )
                                            )
                                        )
                                    )
                                );
                              }).toList()
                          )
                      );
                    }
                    )
                  )
                )
              )
            ]
          )
        )
      )
    );
  }
}

class CustomSwitch extends StatefulWidget {
  final bool value;
  final String text;
  final ValueChanged<bool> onChanged;

  const CustomSwitch({
    Key? key,
    required this.value,
    required this.text,
    required this.onChanged
  }) : super(key: key);

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  late bool isSwitched;

  @override
  void initState() {
    super.initState();
    isSwitched = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.0,
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: LayoutBuilder(
        builder: (ctx, constraints) {
          return Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 2.0,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(5.0),
                  )
                )
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isSwitched = !isSwitched;
                    widget.onChanged(isSwitched); // Notify parent of the change
                  });
                },
                child: Stack(
                  children: [
                    AnimatedPositioned(
                      top: constraints.maxHeight - 35.0,
                      left: isSwitched ? constraints.maxWidth - 100.0 : 0.0,
                      duration: const Duration(milliseconds: 300),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: isSwitched ? Colors.pinkAccent : Colors.grey,
                        ),
                        width: 100.0,
                        height: 35.0,
                        child: Center(
                          child: Text(
                            widget.text,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white
                            )
                          )
                        )
                      )
                    )
                  ]
                )
              )
            ]
          );
        }
      )
    );
  }
}


class Duer {
  Duer({
    required this.duer_nme,
    required this.duer_add,
    required this.duer_amt,
    required this.duer_tme,
    required this.duer_mnth,
    this.isExpanded = false,
});
  String duer_nme;
  String duer_add;
  String duer_amt;
  String duer_tme;
  List<String> duer_mnth;
  bool isExpanded;

  Map<String, dynamic> toJson() {
    return {
      'duer_nme': duer_nme,
      'duer_add': duer_add,
      'duer_amt': duer_amt,
      'duer_tme': duer_tme,
      'duer_mnth': duer_mnth,
      'isExpanded': false
    };
  }

  factory Duer.fromJson(Map<String, dynamic> json) {
    return Duer(
      duer_nme: json['duer_nme'],
      duer_add: json['duer_add'],
      duer_amt: json['duer_amt'],
      duer_tme: json['duer_tme'],
      duer_mnth: List<String>.from(json['duer_mnth'] ?? ['null','null','null','null','null','null','null','null','null','null','null','null']),
      isExpanded: false
    );
  }

}

class DuerChangeNotifier extends ChangeNotifier {

  final FlutterSecureStorage _initialDuer = FlutterSecureStorage();
  bool _disposed = false;
  List<Duer> _dataduer = [];
  List<Duer> get data => _dataduer;

  DuerChangeNotifier () {
    _loadList();
  }

  String compressJson(String jsonString) {
    List<int> compressedData = ZLibCodec().encode(utf8.encode(jsonString));
    return base64.encode(compressedData);
  }

  String decompressJson(String compressedString) {
    List<int> compressedData = base64.decode(compressedString);
    List<int> decompressedData = ZLibCodec().decode(compressedData);
    return utf8.decode(decompressedData);
  }

  void _loadList() async {
    String? compressedJsonString = await _initialDuer.read(key: 'dataduer');
    if (compressedJsonString != null) {
      String jsonString = decompressJson(compressedJsonString);
      _dataduer = (json.decode(jsonString) as List)
          .map((item) => Duer.fromJson(item))
          .toList();
    }
    notifyListeners();
  }

  void _saveList() {
    String jsonString = json.encode(_dataduer.map((item) => item.toJson()).toList());
    String compressedJson = compressJson(jsonString);
    _initialDuer.write(key: 'dataduer', value: compressedJson);
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  void expandData(int index, bool isExpanded) {
    _dataduer[index] = Duer(
      duer_nme: _dataduer[index].duer_nme,
      duer_add: _dataduer[index].duer_add,
      duer_amt: _dataduer[index].duer_amt,
      duer_tme: _dataduer[index].duer_tme,
      duer_mnth: _dataduer[index].duer_mnth,
      isExpanded: isExpanded
    );
    notifyListeners();
  }

  void addData (String nme, String add, String amt, List<String> mnth) {
    final now = DateTime.now();
    final formattedTimestamp = DateFormat('yyyy-MM-dd HH:mm').format(now);
    _dataduer.add(
        Duer(
        duer_nme: nme,
        duer_add: add == '' ? '-' : add,
        duer_amt: amt == '' ? '-' : amt,
        duer_tme: formattedTimestamp,
        duer_mnth: mnth,
        isExpanded: false
        )
    );
    notifyListeners();
    _saveList();
  }

  void editData (int index, String nme, String add, String amt, List<String> mnth) {
    final now = DateTime.now();
    final formattedTimestamp = DateFormat('yyyy-MM-dd HH:mm').format(now);
    _dataduer[index] = Duer(
            duer_nme: nme,
            duer_add: add == '' ? '-' : add,
            duer_amt: amt == '' ? '-' : amt,
            duer_tme: formattedTimestamp,
            duer_mnth: mnth,
            isExpanded: true
        );
    notifyListeners();
    _saveList();
  }

  void removeData (Duer value) {
    _dataduer.remove(value);
    notifyListeners();
    _saveList();
  }

}
