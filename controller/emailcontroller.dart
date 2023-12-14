import 'dart:convert';
import 'package:studio_projects/global.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:http/http.dart' as http;

class emailcontroller extends GetxController{
  emailcontroller get instance => Get.find();
  var verification_id="".obs;

  Future<List> getWatchlistData() async {
    var request = http.Request('GET',
        Uri.parse(global.url+'/watchlistview/9987842719'));
    List<watch> wllist = [];

    http.StreamedResponse response = await request.send();
    var data = await response.stream.bytesToString();
    print(data);
    if (response.statusCode == 200) {
      var a = jsonDecode(data.toString());
      for (Map i in a){
        watch wt= watch(
            stock_id: i['stock_id'],
            lastPrice: i['lastPrice'],
            ideal_buy: i['ideal_buy'],
            ideal_sell: i['ideal_sell'],
            change: i['change']
        );

        wllist.add(wt);
      }
      return wllist;
    } else {
      print(response.reasonPhrase);
    }
    return wllist;
}}
class watch {
  String stock_id;
  double lastPrice, ideal_sell, ideal_buy,change;
  watch(
      {required this.stock_id,
        required this.lastPrice,
        required this.ideal_buy,
        required this.ideal_sell,
        required this.change});
}