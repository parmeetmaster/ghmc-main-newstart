import 'package:flutter/material.dart';
import 'package:ghmc/globals/constants.dart';
import 'package:ghmc/model/resident/resident_search_response_model.dart';
import 'package:ghmc/provider/add_resident/add_resident_provider.dart';
import 'package:ghmc/screens/add_resident/add_resident.dart';
import 'package:provider/provider.dart';

class SearchResident extends StatefulWidget {
  const SearchResident({Key? key}) : super(key: key);

  @override
  _SearchResidentState createState() => _SearchResidentState();
}

class _SearchResidentState extends State<SearchResident> {
  var _queryController = TextEditingController();

  late final ResidentProvider provider;

  @override
  void initState() {
    super.initState();

    provider = Provider.of<ResidentProvider>(context, listen: false);
    provider.residentSearchResponseModel = null;
  }

  void onSubmitted(String value) {}

  @override
  Widget build(BuildContext context) {
    return Consumer<ResidentProvider>(builder: (context, value, child) {
      return SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(120.0),
            child: AppBar(
              title: Text("Search Resident"),
              automaticallyImplyLeading: true,
              backgroundColor: main_color.first,
              flexibleSpace: PreferredSize(
                preferredSize: Size.fromHeight(kToolbarHeight),
                child: Container(
                  height: 30,
                  child: Row(
                    children: [],
                  ),
                ),
              ),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(150),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: SizedBox(),
                        ),
                        Expanded(
                            flex: 14,
                            //huhhgb
                            child: Container(
                              height: 52,
                              padding: EdgeInsets.only(right: 20, top: 10),
                              child: TextFormField(
                                autofocus: true,
                                controller: _queryController,
                                cursorColor: Colors.black,
                                textInputAction: TextInputAction.search,
                                onChanged: (query) {},
                                onFieldSubmitted: (_) {
                                  print("submit done");
                                  provider.searchResident(
                                      _queryController.text, context);
                                },
                                decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.search,
                                      color: Colors.black,
                                    ),
                                    suffixIcon: GestureDetector(
                                        onTap: () {
                                          _queryController.clear();
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 5, right: 15.0),
                                          child: Text(
                                            "Clear",
                                          ),
                                        )),
                                    suffixIconConstraints: BoxConstraints(
                                      maxHeight: double.infinity,
                                      maxWidth: double.infinity,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                        width: 0,
                                        style: BorderStyle.none,
                                      ),
                                    ),
                                    filled: true,
                                    focusColor: Colors.black,
                                    contentPadding: EdgeInsets.only(
                                        top: 10, bottom: 10, left: 16),
                                    hintStyle: TextStyle(color: Colors.black45),
                                    hintText: "Search here...",
                                    fillColor: Colors.white),
                              ),
                            )),
                      ],
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
          body: provider.residentSearchResponseModel != null
              ? ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) => AddResidentScreen(
                                        resident_opr: RESIDENT_OPR.update,
                                  uuid:  provider.residentSearchResponseModel!.data!.first.uuid
                                  )));
                        },
                        child: Container(
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 10),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  _getValue(
                                      "Name",
                                      provider.residentSearchResponseModel!
                                          .data!.first.ownerName),
                                  _getValue(
                                      "House Address",
                                      provider.residentSearchResponseModel!
                                          .data!.first.houseAddress),
                                  _getValue(
                                      "Mobile number",
                                      provider.residentSearchResponseModel!
                                          .data!.first.ownerMobile),
                                  _getValue(
                                      "Total Members",
                                      provider.residentSearchResponseModel!
                                          .data!.first.totalMembers
                                          .toString()),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              : Container(
                  child: Center(
                    child: Text("No Search Result"),
                  ),
                ),
        ),
      );
    });
  }

  _getValue(key, value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 10,
            child: Text(
              key,
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Text(":"),
          SizedBox(
            width: 20,
          ),
          Expanded(
            flex: 20,
            child: Text(
              value,
            ),
          ),
        ],
      ),
    );
  }
}
