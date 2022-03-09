import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      home: const MyHomePage(title: 'converter suhu'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController etInput = TextEditingController();
  List<String> listSatuanSuhu = ["kelvin", "reamor", "farenheit"];
  String selectedDropdown = "kelvin";
  double hasilPerhitungan = 0;
  List<String> listHasil = [];

  void onDropdownChange(Object value) {
    return setState(() {
      selectedDropdown = value.toString();
    });
  }

  void konversiSuhu() {
    return setState(() {
      if (etInput.text.isNotEmpty) {
        switch (selectedDropdown) {
          case "kelvin":
            hasilPerhitungan = int.parse(etInput.text) + 273.15;
            listHasil.add("kelvin :");
            break;
          case "reamor":
            hasilPerhitungan = int.parse(etInput.text) * 4 / 5;
            listHasil.add("reamor :");
            break;
          case "farenheit":
            hasilPerhitungan = (int.parse(etInput.text) * 9 / 5) * 32;
            listHasil.add("farenheit :");
            break;
          default:
        }
        listHasil.add(hasilPerhitungan.toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        margin: EdgeInsets.all(8),
        child: Column(
          children: [
            TextField(
              controller: etInput,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Celcius',
                hintText: 'Enter temperature in celcius',
              ),
            ),
            const SizedBox(height: 8),
            DropdownButton(
              isExpanded: true,
              value: selectedDropdown,
              items: listSatuanSuhu.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                onDropdownChange(value);
              },
            ),
            Text("hasil", style: TextStyle(fontSize: 20)),
            Text("$hasilPerhitungan", style: TextStyle(fontSize: 30)),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                    child: ElevatedButton(
                        onPressed: () {
                          konversiSuhu();
                        },
                        child: Text("konversi suhu"))),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text("riwayat konversi", style: TextStyle(fontSize: 15)),
            Expanded(
              child: ListView.builder(
              itemCount: listHasil.length,
              itemBuilder: (context, index){
                return Text(listHasil[index]);
              },
            ),
            ),
          ],
        ),
      ),
    );
  }
}