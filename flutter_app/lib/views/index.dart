import 'package:accordion/accordion.dart';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/controllers/contact_me.dart';
import 'package:flutter_app/themes/base_theme.dart';
import 'package:flutter_app/widgets/text_span_tooltip.dart';
import 'package:flutter_bullet_list/flutter_bullet_list.dart';
import 'package:flutter_multi_formatter/utils/unfocuser.dart';
import 'package:get/get.dart';


class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _isMobile = _isMobileDevice(context);
    return Unfocuser(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Green Range, LLC'),
        ),
        body: ListView(
            children: _buildChildren(context)
        ),
        floatingActionButton: _isMobile
          ? _buildFAB(context)
          : null,
      ),
    );
  }
}

Widget _buildFAB(BuildContext context) {
  final ContactMeController controller = Get.find<ContactMeController>();

  return GetBuilder<ContactMeController>(
    builder: (builder) {
      return FloatingActionButton(
        tooltip: 'Contact Me',
        child: const Icon(Icons.contact_mail),
        onPressed: () async {
          final List<String>? _fields = await showTextInputDialog(
            title: 'Contact Me',
            message: !builder.showForm
              ? 'Your contact request was already sent!'
              : null,
            context: context,
            okLabel: 'Send',
            textFields: [
              DialogTextField(
                hintText: controller.name,
                keyboardType: TextInputType.name,
                validator: (value) =>
                (value == null || value.isEmpty)
                    ? 'Please enter your name'
                    : null,
              ),
              DialogTextField(
                hintText: controller.email,
                keyboardType: TextInputType.emailAddress,
                validator: (value) => EmailValidator.validate(value!)
                    ? null
                    : 'Please enter a valid email address',
              ),
              DialogTextField(
                hintText: controller.company,
              ),
              DialogTextField(
                hintText: controller.question,
                minLines: 4,
                maxLines: 7,
              ),
            ],
          );

          if (_fields != null && _fields.isNotEmpty) {
            Map<String, String> _data = {
              "name": _fields[0],
              "email": _fields[1],
              "company": _fields[2],
              "question": _fields[3]
            };
            controller.sendEmail(_data);
          }
        },
      );
    },
  );
}

List<Widget> _buildChildren(BuildContext context) {
  final _isMobile = _isMobileDevice(context);
  List<Widget> _children = [
    const SizedBox(height: 50),
    Center(
      child: Container(
        width: _isMobile ? context.width * 0.9 : context.width * 0.8,
        child: Material(
          elevation: 20,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(
                  top: 10,
                  left: 30,
                ),
                margin: const EdgeInsets.only(
                  bottom: 10,
                ),
                child: Text(
                  'Compostable and Sustainable Foodservice Disposables',
                  style: _isMobile
                      ? Theme.of(context).textTheme.headline3
                      : Theme.of(context).textTheme.headline2,
                ),
              ),
              Container(
                  padding: const EdgeInsets.only(
                    left: 30,
                    bottom: 20,
                  ),
                  margin: const EdgeInsets.only(
                    top: 10,
                  ),
                child: Text(
                  'Help Bend improve its environmental footprint by reducing plastic waste in our landfills.',
                  style: Theme.of(context).textTheme.headline4,
                )
              ),
            ],
          ),
        ),
      ),
    ),
    const SizedBox(height: 100),
    Divider(
      height: 100,
      thickness: 50,
      color: Theme.of(context).accentColor,
    ),
    const SizedBox(height: 80),
    Center(
      child: Container(
        width: _isMobile ? context.width * 0.9 : context.width * 0.8,
        child: Material(
          elevation: 10,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: 5.0, vertical: 5.0
                ),
                child: Text(
                  'About',
                  style: Theme.of(context).textTheme.headline2,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                    bottom: 20
                ),
                width: context.width * 0.75,
                child: Text(
                  'My name is Walker Sorlie and I am the owner and operator of Green Range, LLC. I was born and raised here in Bend, Oregon so I have a love and appreciation of everything that makes Bend, Bend!\n\nI have seen the explosion of food cart pods and artisan coffee shops. I have seen how hard all of the employees and owners of these local places work. With my business I aim to provide local foodservice businesses not only with the higest-quality compostable disposable products but also a personal and trusted service.',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    const SizedBox(height: 80),
    Divider(
      height: 100,
      thickness: 50,
      color: Theme.of(context).accentColor,
    ),
    const SizedBox(height: 80),
    Center(
      child: Container(
        width: _isMobile ? context.width * 0.9 : context.width * 0.8,
        child: Material(
          elevation: 10,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: 5.0, vertical: 5.0
                ),
                child: Text(
                  'My Service',
                  style: Theme.of(context).textTheme.headline2,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                ),
                width: context.width * 0.75,
                child: Text(
                  'I manage the entire lifecycle of your inventory and ordering needs! I purchase the products you want, store them in my own personal storage space, and I deliver them according to your schedule and needs.',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              Container(
                width: _isMobile
                    ? context.width * 0.75
                    : context.mediaQueryShortestSide <= 1200
                    ? context.width * 0.5
                    : context.width * 0.35,
                child: Accordion(
                  children: [
                    AccordionSection(
                      header: Center(
                        child: Text(
                          'Research',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
                      content: Text(
                        'I keep up-to-date on the latest compostable products and always take the time to find you the best price',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ),
                    AccordionSection(
                      header: Center(
                        child: Text(
                          'Ordering',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
                      content: Text(
                        "I make purchase orders and interact with suppliers and distributors so you don't have to",
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ),
                    AccordionSection(
                      header: Center(
                        child: Text(
                          'Ordering',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
                      content: Text(
                        "I make purchase orders and interact with suppliers and distributors so you don't have to",
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ),
                    AccordionSection(
                      header: Center(
                        child: Text(
                          'Storage',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
                      content: Text(
                        "I warehouse and store all of the products so you don't have to try and find space to fit that fifth box of cups",
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ),
                    AccordionSection(
                      header: Center(
                        child: Text(
                          'Deliver',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
                      content: Text(
                        "I deliver the products you desire on your schedule. So whenever you make an order, I can deliver that day, the next day, or whenever you'd like",
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ),
                    AccordionSection(
                      header: Center(
                        child: Text(
                          'Problem Resolving',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
                      content: FlutterBulletList(
                        bulletSize: 3.0,
                        textStyle: Theme.of(context).textTheme.bodyText2,
                        spaceBetweenItem: 15,
                        bulletColor: BaseTheme.baseTheme.primaryColor,
                        data: <ListItemModel>[
                          ListItemModel(
                              label: "I deliver the products you desire on your schedule. So whenever you make an order, I can deliver that day, the next day, or whenever you'd like"
                          ),
                          ListItemModel(
                              label: "Damaged product: Handle getting replacements"
                          ),
                          ListItemModel(
                              label: "Incorrect items sent: Handle getting correct items shipped"
                          ),
                          ListItemModel(
                              label: "Items out of stock: Find suitable interim replacement items"
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                  bottom: 20,
                ),
                width: context.width * 0.75,
                child: Text(
                  'I am at your disposal! Because I am a one-man show I am much more flexible than any other foodservice disposables product provider. If you want a specific item I can do the research and find the item for you. If you want a specific brand I can source that brand for you.',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    SizedBox(height: 80),
  ];

  if (!_isMobile) {
    _children.addAll(
        [
          Divider(
            height: 100,
            thickness: 50,
            color: Theme.of(context).accentColor,
          ),
          SizedBox(height: 80),
          _contactMeViewWeb(context),
          SizedBox(height: 80),
        ]
    );
  }

  return _children;
}

Widget _contactMeViewWeb(BuildContext context) {
  final _formKey = GlobalKey<FormState>();
  final ContactMeController controller = Get.find<ContactMeController>();

  List<Widget> _contactHeading = [
    Container(
      margin: const EdgeInsets.symmetric(
          horizontal: 15.0, vertical: 5.0
      ),
      child: Text(
        'Contact Me',
        style: Theme.of(context).textTheme.headline2,
      ),
    ),
    Container(
      padding: const EdgeInsets.only(
        bottom: 20,
      ),
      child: RichText(
        text: TextSpan(
          text: 'Please fill out this form or contact me directly at ',
          style: Theme.of(context).textTheme.bodyText2,
          children: <InlineSpan> [
            TooltipSpan(
                message: 'Copy Email',
                inlineSpan: TextSpan(
                  text: 'contact-me@greenrangeproducts.com.',
                  recognizer: TapGestureRecognizer()..onTap = () {
                    Clipboard.setData(
                      ClipboardData(
                          text: 'contact-me@greenrangeproducts.com'),
                    ).then((res) => Get.snackbar(
                        'Copied',
                        'Email address copied',
                        snackPosition: SnackPosition.BOTTOM
                    ));
                  },
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                    decoration: TextDecoration.underline,
                  ),
                ),
            ),
          ],
        ),
      ),
    ),
  ];

  return GetBuilder<ContactMeController>(
    builder: (builder) {
      return Visibility(
        visible: builder.showForm,
        child: Form(
          key: _formKey,
          child: Center(
            child: Container(
              width: context.width * 0.8,
              child: Material(
                elevation: 10,
                child: Column(
                  children: _contactHeading + [
                    Container(
                      width: context.width * 0.5,
                      child: TextFormField(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(),
                          labelText: controller.name,
                        ),
                        keyboardType: TextInputType.name,
                        onSaved: (name) => controller.name = name!,
                        validator: (field) => (field == null || field.isEmpty)
                            ? 'Please enter your name'
                            : null,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: context.width * 0.5,
                      child: TextFormField(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(),
                          labelText: controller.email,
                        ),
                        keyboardType: TextInputType.emailAddress,
                        onSaved: (email) => controller.email = email!,
                        validator: (field) => EmailValidator.validate(field!)
                            ? null
                            : 'Please enter a valid email address',
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: context.width * 0.5,
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(),
                          labelText: controller.company,
                        ),
                        onSaved: (company) => controller.company == company!
                            ? controller.company = ''
                            : controller.company = company,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: context.width * 0.6,
                      child: TextFormField(
                        onTap: controller.requestFocus,
                        focusNode: controller.focusNode,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(),
                          labelText: controller.question,
                        ),
                        onSaved: (question) => controller.question == question!
                            ? controller.question = ''
                            : controller.question = question,
                        minLines: 5,
                        maxLines: 10,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: ElevatedButton(
                        child: Text('Submit'),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            controller.sendEmail();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        replacement: Center(
          child: Container(
            width: context.width * 0.8,
            child: Material(
              elevation: 10,
              child: Column(
                children: _contactHeading + [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 30,
                    ),
                    child: Text(
                      'Contact request sent!',
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

bool _isMobileDevice(BuildContext context) => context.mediaQueryShortestSide <= 650;