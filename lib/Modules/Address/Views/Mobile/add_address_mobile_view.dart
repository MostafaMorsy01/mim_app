import 'package:flutter/cupertino.dart';

class AddAddressMobileView extends StatefulWidget {
  const AddAddressMobileView({Key? key}) : super(key: key);

  @override
  State<AddAddressMobileView> createState() => _AddAddressMobileViewState();
}

class _AddAddressMobileViewState extends State<AddAddressMobileView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController specialMarkController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    nameController.dispose();
    areaController.dispose();
    streetController.dispose();
    specialMarkController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
