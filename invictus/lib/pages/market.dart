import 'package:flutter/material.dart';

// class Market extends StatefulWidget {
//   const Market({super.key});

//   @override
//   State<Market> createState() => _MarketState();
// }

// class _MarketState extends State<Market> {
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }

class Market extends StatefulWidget {
  @override
  _MarketState createState() => _MarketState();
}

class _MarketState extends State<Market> {
  String selectedDistrict = "Lucknow";
  String selectedMandi = "Lucknow Mandi";
  String selectedCommodity = "Pulses";
  String quoteDate = "14/02/2025";
  bool isLoading = false;

  final List<Map<String, dynamic>> marketData = [];

  List<String> districts = [
    "Agra",
    "Firozabad",
    "Mainpuri",
    "Mathura",
    "Aligarh",
    "Etah",
    "Hathras",
    "Kasganj",
    "Ambedkar Nagar",
    "Amethi",
    "Ayodhya",
    "Barabanki",
    "Sultanpur",
    "Azamgarh",
    "Ballia",
    "Mau",
    "Bareilly",
    "Badaun",
    "Pilibhit",
    "Shahjahanpur",
    "Basti",
    "Sant Kabir Nagar",
    "Siddharthnagar",
    "Banda",
    "Chitrakoot",
    "Hamirpur",
    "Mahoba",
    "Bahraich",
    "Balrampur",
    "Gonda",
    "Shravasti",
    "Deoria",
    "Gorakhpur",
    "Kushinagar",
    "Maharajganj",
    "Jhansi",
    "Jalaun",
    "Lalitpur",
    "Kannauj",
    "Kanpur Dehat",
    "Kanpur Nagar",
    "Farrukhabad",
    "Lakhimpur Kheri",
    "Hardoi",
    "Sitapur",
    "Unnao",
    "Lucknow",
    "Raebareli",
    "Amroha",
    "Bijnor",
    "Meerut",
    "Moradabad",
    "Rampur",
    "Sambhal",
    "Muzaffarnagar",
    "Baghpat",
    "Ghaziabad",
    "Gautam Buddha Nagar",
    "Bulandshahr",
    "Prayagraj",
    "Fatehpur",
    "Kaushambi",
    "Pratapgarh",
    "Mirzapur",
    "Sonbhadra",
    "Varanasi",
    "Chandauli",
    "Ghazipur",
    "Jaunpur",
    "Saharanpur",
    "Shamli"
  ];

  Map<String, List<String>> mandis = {};

  List<String> commodity = [];

  void _searchMarketData() {
    setState(() {
      isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Market Price Lookup")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                DropdownButtonFormField(
                  decoration: InputDecoration(labelText: "District"),
                  // value: selectedDistrict,
                  items: districts.map((String value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      selectedDistrict = newValue.toString();
                    });
                  },
                ),
                SizedBox(width: 10),
                DropdownButtonFormField(
                  decoration: InputDecoration(labelText: "Mandi"),
                  // value: selectedMandi,
                  items: mandis[selectedDistrict]?.map((String value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      selectedMandi = newValue.toString();
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(labelText: "Commodity"),
                    // value: selectedCommodity,
                    items: commodity.map((String value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        selectedCommodity = newValue.toString();
                      });
                    },
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(labelText: "Quote Date"),
                    controller: TextEditingController(text: quoteDate),
                    readOnly: true,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: _searchMarketData,
              child: Text("Search", style: TextStyle(color: Colors.white),),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                  minimumSize: Size(double.infinity, 50)),
            ),
            SizedBox(height: 20),
            isLoading
                ? Center(child: CircularProgressIndicator())
                : Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            columnSpacing: 20,
                            columns: [
                              DataColumn(
                                  label: Text(
                                "#",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                              DataColumn(
                                  label: Text(
                                "Name",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                              DataColumn(
                                  label: Text(
                                "Wholesale ₹/Qtl",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                              DataColumn(
                                  label: Text(
                                "Retail ₹/Kg",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                            ],
                            rows: marketData
                                .asMap()
                                .entries
                                .map((entry) => DataRow(cells: [
                                      DataCell(
                                          Text((entry.key + 1).toString())),
                                      DataCell(Text(entry.value["name"])),
                                      DataCell(Text(
                                          entry.value["wholesale"].toString())),
                                      DataCell(Text(
                                          entry.value["retail"].toString())),
                                    ]))
                                .toList(),
                          ),
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}
